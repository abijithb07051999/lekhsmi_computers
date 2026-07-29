import 'package:serverpod/serverpod.dart';
import 'package:lekhsmi_computers_server/src/generated/protocol.dart';

class PurchaseEndpoint extends Endpoint {
  Future<List<Purchase>> getAllPurchases(Session session) async {
    return await Purchase.db.find(session);
  }

  Future<List<PurchaseItem>> getPurchaseItems(Session session, {required int purchaseId}) async {
    return await PurchaseItem.db.find(
      session,
      where: (t) => t.purchaseId.equals(purchaseId),
      include: PurchaseItem.include(
        product: Product.include(),
      ),
    );
  }

  Future<Purchase> createPurchase(
    Session session, {
    required Purchase purchase,
    required List<PurchaseItem> items,
  }) async {
    final createdPurchase = await Purchase.db.insertRow(session, purchase);
    final int purchaseId = createdPurchase.id!;

    for (final item in items) {
      item.purchaseId = purchaseId;
      await PurchaseItem.db.insertRow(session, item);

      // Automatically update stock in Product table
      final product = await Product.db.findById(session, item.productId);
      if (product != null) {
        product.quantity += item.quantity;
        if (item.unitPrice > 0) {
          product.buyPrice = item.unitPrice;
        }
        await Product.db.updateRow(session, product);
      }
    }

    return createdPurchase;
  }

  Future<Purchase> updatePurchase(Session session, {required Purchase purchase}) async {
    return await Purchase.db.updateRow(session, purchase);
  }

  Future<Purchase> deletePurchase(Session session, {required Purchase purchase}) async {
    if (purchase.id != null) {
      final items = await PurchaseItem.db.find(
        session,
        where: (t) => t.purchaseId.equals(purchase.id!),
      );
      for (final item in items) {
        final product = await Product.db.findById(session, item.productId);
        if (product != null) {
          product.quantity = (product.quantity - item.quantity).clamp(0, 999999);
          await Product.db.updateRow(session, product);
        }
        await PurchaseItem.db.deleteRow(session, item);
      }
    }
    return await Purchase.db.deleteRow(session, purchase);
  }
}
