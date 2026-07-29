/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../features/inventory/purchase/purchase.dart' as _i2;
import '../../../features/inventory/products/product.dart' as _i3;
import 'package:lekhsmi_computers_client/src/protocol/protocol.dart' as _i4;

abstract class PurchaseItem implements _i1.SerializableModel {
  PurchaseItem._({
    this.id,
    required this.purchaseId,
    this.purchase,
    required this.productId,
    this.product,
    required this.quantity,
    required this.unitPrice,
  });

  factory PurchaseItem({
    int? id,
    required int purchaseId,
    _i2.Purchase? purchase,
    required int productId,
    _i3.Product? product,
    required int quantity,
    required int unitPrice,
  }) = _PurchaseItemImpl;

  factory PurchaseItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return PurchaseItem(
      id: jsonSerialization['id'] as int?,
      purchaseId: jsonSerialization['purchaseId'] as int,
      purchase: jsonSerialization['purchase'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Purchase>(
              jsonSerialization['purchase'],
            ),
      productId: jsonSerialization['productId'] as int,
      product: jsonSerialization['product'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Product>(
              jsonSerialization['product'],
            ),
      quantity: jsonSerialization['quantity'] as int,
      unitPrice: jsonSerialization['unitPrice'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int purchaseId;

  _i2.Purchase? purchase;

  int productId;

  _i3.Product? product;

  int quantity;

  int unitPrice;

  /// Returns a shallow copy of this [PurchaseItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PurchaseItem copyWith({
    int? id,
    int? purchaseId,
    _i2.Purchase? purchase,
    int? productId,
    _i3.Product? product,
    int? quantity,
    int? unitPrice,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PurchaseItem',
      if (id != null) 'id': id,
      'purchaseId': purchaseId,
      if (purchase != null) 'purchase': purchase?.toJson(),
      'productId': productId,
      if (product != null) 'product': product?.toJson(),
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PurchaseItemImpl extends PurchaseItem {
  _PurchaseItemImpl({
    int? id,
    required int purchaseId,
    _i2.Purchase? purchase,
    required int productId,
    _i3.Product? product,
    required int quantity,
    required int unitPrice,
  }) : super._(
         id: id,
         purchaseId: purchaseId,
         purchase: purchase,
         productId: productId,
         product: product,
         quantity: quantity,
         unitPrice: unitPrice,
       );

  /// Returns a shallow copy of this [PurchaseItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PurchaseItem copyWith({
    Object? id = _Undefined,
    int? purchaseId,
    Object? purchase = _Undefined,
    int? productId,
    Object? product = _Undefined,
    int? quantity,
    int? unitPrice,
  }) {
    return PurchaseItem(
      id: id is int? ? id : this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      purchase: purchase is _i2.Purchase?
          ? purchase
          : this.purchase?.copyWith(),
      productId: productId ?? this.productId,
      product: product is _i3.Product? ? product : this.product?.copyWith(),
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }
}
