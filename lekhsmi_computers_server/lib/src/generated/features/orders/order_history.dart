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
import 'package:serverpod/serverpod.dart' as _i1;
import '../../features/orders/order.dart' as _i2;
import 'package:lekhsmi_computers_server/src/generated/protocol.dart' as _i3;

abstract class OrderHistory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OrderHistory._({
    this.id,
    required this.order,
    required this.status,
    int? amount,
  }) : amount = amount ?? 0;

  factory OrderHistory({
    int? id,
    required _i2.Orders order,
    required String status,
    int? amount,
  }) = _OrderHistoryImpl;

  factory OrderHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderHistory(
      id: jsonSerialization['id'] as int?,
      order: _i3.Protocol().deserialize<_i2.Orders>(jsonSerialization['order']),
      status: jsonSerialization['status'] as String,
      amount: jsonSerialization['amount'] as int?,
    );
  }

  static final t = OrderHistoryTable();

  static const db = OrderHistoryRepository._();

  @override
  int? id;

  _i2.Orders order;

  String status;

  int amount;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OrderHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderHistory copyWith({
    int? id,
    _i2.Orders? order,
    String? status,
    int? amount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderHistory',
      if (id != null) 'id': id,
      'order': order.toJson(),
      'status': status,
      'amount': amount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderHistory',
      if (id != null) 'id': id,
      'order': order.toJsonForProtocol(),
      'status': status,
      'amount': amount,
    };
  }

  static OrderHistoryInclude include() {
    return OrderHistoryInclude._();
  }

  static OrderHistoryIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderHistoryTable>? orderByList,
    OrderHistoryInclude? include,
  }) {
    return OrderHistoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderHistory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrderHistory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderHistoryImpl extends OrderHistory {
  _OrderHistoryImpl({
    int? id,
    required _i2.Orders order,
    required String status,
    int? amount,
  }) : super._(
         id: id,
         order: order,
         status: status,
         amount: amount,
       );

  /// Returns a shallow copy of this [OrderHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderHistory copyWith({
    Object? id = _Undefined,
    _i2.Orders? order,
    String? status,
    int? amount,
  }) {
    return OrderHistory(
      id: id is int? ? id : this.id,
      order: order ?? this.order.copyWith(),
      status: status ?? this.status,
      amount: amount ?? this.amount,
    );
  }
}

class OrderHistoryUpdateTable extends _i1.UpdateTable<OrderHistoryTable> {
  OrderHistoryUpdateTable(super.table);

  _i1.ColumnValue<_i2.Orders, _i2.Orders> order(_i2.Orders value) =>
      _i1.ColumnValue(
        table.order,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> amount(int value) => _i1.ColumnValue(
    table.amount,
    value,
  );
}

class OrderHistoryTable extends _i1.Table<int?> {
  OrderHistoryTable({super.tableRelation}) : super(tableName: 'orderhistory') {
    updateTable = OrderHistoryUpdateTable(this);
    order = _i1.ColumnSerializable<_i2.Orders>(
      'order',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    amount = _i1.ColumnInt(
      'amount',
      this,
      hasDefault: true,
    );
  }

  late final OrderHistoryUpdateTable updateTable;

  late final _i1.ColumnSerializable<_i2.Orders> order;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt amount;

  @override
  List<_i1.Column> get columns => [
    id,
    order,
    status,
    amount,
  ];
}

class OrderHistoryInclude extends _i1.IncludeObject {
  OrderHistoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OrderHistory.t;
}

class OrderHistoryIncludeList extends _i1.IncludeList {
  OrderHistoryIncludeList._({
    _i1.WhereExpressionBuilder<OrderHistoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrderHistory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OrderHistory.t;
}

class OrderHistoryRepository {
  const OrderHistoryRepository._();

  /// Returns a list of [OrderHistory]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<OrderHistory>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderHistoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OrderHistory>(
      where: where?.call(OrderHistory.t),
      orderBy: orderBy?.call(OrderHistory.t),
      orderByList: orderByList?.call(OrderHistory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OrderHistory] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<OrderHistory?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderHistoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderHistoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OrderHistory>(
      where: where?.call(OrderHistory.t),
      orderBy: orderBy?.call(OrderHistory.t),
      orderByList: orderByList?.call(OrderHistory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OrderHistory] by its [id] or null if no such row exists.
  Future<OrderHistory?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OrderHistory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OrderHistory]s in the list and returns the inserted rows.
  ///
  /// The returned [OrderHistory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OrderHistory>> insert(
    _i1.DatabaseSession session,
    List<OrderHistory> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OrderHistory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OrderHistory] and returns the inserted row.
  ///
  /// The returned [OrderHistory] will have its `id` field set.
  Future<OrderHistory> insertRow(
    _i1.DatabaseSession session,
    OrderHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrderHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrderHistory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrderHistory>> update(
    _i1.DatabaseSession session,
    List<OrderHistory> rows, {
    _i1.ColumnSelections<OrderHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrderHistory>(
      rows,
      columns: columns?.call(OrderHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderHistory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrderHistory> updateRow(
    _i1.DatabaseSession session,
    OrderHistory row, {
    _i1.ColumnSelections<OrderHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrderHistory>(
      row,
      columns: columns?.call(OrderHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderHistory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OrderHistory?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OrderHistoryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OrderHistory>(
      id,
      columnValues: columnValues(OrderHistory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OrderHistory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OrderHistory>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OrderHistoryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OrderHistoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderHistoryTable>? orderBy,
    _i1.OrderByListBuilder<OrderHistoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OrderHistory>(
      columnValues: columnValues(OrderHistory.t.updateTable),
      where: where(OrderHistory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderHistory.t),
      orderByList: orderByList?.call(OrderHistory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OrderHistory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrderHistory>> delete(
    _i1.DatabaseSession session,
    List<OrderHistory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrderHistory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrderHistory].
  Future<OrderHistory> deleteRow(
    _i1.DatabaseSession session,
    OrderHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrderHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrderHistory>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrderHistoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrderHistory>(
      where: where(OrderHistory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderHistoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrderHistory>(
      where: where?.call(OrderHistory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OrderHistory] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrderHistoryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OrderHistory>(
      where: where(OrderHistory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
