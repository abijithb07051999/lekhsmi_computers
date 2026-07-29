import 'package:serverpod/serverpod.dart';

import 'package:lekhsmi_computers_server/src/generated/protocol.dart';

class DashboardEndpoint extends Endpoint {
  Future<List<Supplier>> getFirstFiveSupplires(Session session) async {
    return await Supplier.db.find(
      session,
      limit: 5,
      orderBy: (t) => t.id,
    );
  }

  Future<int> getTotalOfThisMonthIncome(
    Session session,
    DateTime date,
  ) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final startOfNextMonth = DateTime(date.year, date.month + 1, 1);

    final incomes = await Income.db.find(
      session,
      where: (t) => t.date.between(startOfMonth, startOfNextMonth),
    );

    int total = 0;
    for (final income in incomes) {
      total += income.amount;
    }
    return total;
  }

  Future<int> totalBrandCountrs(Session session) async {
    return Brand.db.count(session);
  }

  Future<int> totalSupplierCount(Session session) async {
    return Supplier.db.count(session);
  }

  Future<int> totalCategoryCount(Session session) async {
    return Category.db.count(session);
  }

  Future<List<Product>> getFirstFiveOutOfStockProduct(Session session) async {
    return await Product.db.find(
      session,
      limit: 5,
      orderBy: (t) => t.quantity,
      where: (t) => t.quantity.equals(0),
    );
  }

  // i want to get first five live order [ongoing and pending] from the OrderHistory table, if the there is no data return empty list 
  
  Future<List<OrderHistory>> getFirstFiveLiveOrder(Session session) async {
    return await OrderHistory.db.find(
      session,
      limit: 5,
      orderDescending: true,
      orderBy: (t) => t.id,
      where: (t) =>
          t.status.equals('Ongoing') |
          t.status.equals('Pending') |
          t.status.equals('ongoing') |
          t.status.equals('pending'),
    );
  }
}
