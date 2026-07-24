import 'package:serverpod/serverpod.dart';

import 'package:lekhsmi_computers_server/src/generated/features/orders/order.dart';
import 'package:lekhsmi_computers_server/src/generated/features/orders/order_history.dart';

class OrderEndpoint extends Endpoint {
  //? Order Section
  Future<List<Orders>> getAllOrders(Session session) async {
    return Orders.db.find(session);
  }

  Future<Orders> addNewOrder(Session session, {required Orders order}) async {
    return Orders.db.insertRow(session, order);
  }

  Future<Orders> updateExistingOrder(
    Session session, {
    required Orders order,
  }) async {
    return await Orders.db.updateRow(session, order);
  }

  Future<Orders> deleteExistingOrder(
    Session session, {
    required Orders order,
  }) async {
    return await Orders.db.deleteRow(session, order);
  }

  //? Order History Section
  Future<List<OrderHistory>> getAllOrderStatus(Session session) async {
    return OrderHistory.db.find(session);
  }

  Future<OrderHistory> addNewOrderStatus(
    Session session,
    OrderHistory orderHistory,
  ) async {
    return await OrderHistory.db.insertRow(session, orderHistory);
  }

  Future<OrderHistory> deleteOrderStatus(
    Session session,
    OrderHistory orderHistory,
  ) async {
    return await OrderHistory.db.deleteRow(session, orderHistory);
  }

  Future<OrderHistory> updateOrderStatus(
    Session session,
    OrderHistory orderHistory,
  ) async {
    return await OrderHistory.db.updateRow(session, orderHistory);
  }

  Future<List<OrderHistory>> getAllOngoingAndPendingOrders(
    Session session,
  ) async {
    return await OrderHistory.db.find(
      session,
      where: (t) => t.status.equals('Ongoing') | t.status.equals('Pending'),
    );
  }

  Future<List<OrderHistory>> getAllCompletedAndConcelledOrders(
    Session session,
  ) async {
    return await OrderHistory.db.find(
      session,
      where: (t) => t.status.equals('Completed') | t.status.equals('Cancelled')
    );
  }
}
