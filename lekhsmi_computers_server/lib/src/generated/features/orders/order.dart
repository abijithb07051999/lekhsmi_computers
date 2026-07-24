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
import 'package:lekhsmi_computers_server/src/generated/protocol.dart' as _i2;

abstract class Orders implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Orders._({
    this.id,
    required this.orderId,
    required this.customerName,
    required this.contact1,
    this.contact2,
    this.email,
    required this.address,
    required this.date,
    required this.complaints,
  });

  factory Orders({
    int? id,
    required String orderId,
    required String customerName,
    required int contact1,
    int? contact2,
    String? email,
    required String address,
    required DateTime date,
    required List<String> complaints,
  }) = _OrdersImpl;

  factory Orders.fromJson(Map<String, dynamic> jsonSerialization) {
    return Orders(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as String,
      customerName: jsonSerialization['customerName'] as String,
      contact1: jsonSerialization['contact1'] as int,
      contact2: jsonSerialization['contact2'] as int?,
      email: jsonSerialization['email'] as String?,
      address: jsonSerialization['address'] as String,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      complaints: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['complaints'],
      ),
    );
  }

  static final t = OrdersTable();

  static const db = OrdersRepository._();

  @override
  int? id;

  String orderId;

  String customerName;

  int contact1;

  int? contact2;

  String? email;

  String address;

  DateTime date;

  List<String> complaints;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Orders]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Orders copyWith({
    int? id,
    String? orderId,
    String? customerName,
    int? contact1,
    int? contact2,
    String? email,
    String? address,
    DateTime? date,
    List<String>? complaints,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Orders',
      if (id != null) 'id': id,
      'orderId': orderId,
      'customerName': customerName,
      'contact1': contact1,
      if (contact2 != null) 'contact2': contact2,
      if (email != null) 'email': email,
      'address': address,
      'date': date.toJson(),
      'complaints': complaints.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Orders',
      if (id != null) 'id': id,
      'orderId': orderId,
      'customerName': customerName,
      'contact1': contact1,
      if (contact2 != null) 'contact2': contact2,
      if (email != null) 'email': email,
      'address': address,
      'date': date.toJson(),
      'complaints': complaints.toJson(),
    };
  }

  static OrdersInclude include() {
    return OrdersInclude._();
  }

  static OrdersIncludeList includeList({
    _i1.WhereExpressionBuilder<OrdersTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrdersTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrdersTable>? orderByList,
    OrdersInclude? include,
  }) {
    return OrdersIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Orders.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Orders.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrdersImpl extends Orders {
  _OrdersImpl({
    int? id,
    required String orderId,
    required String customerName,
    required int contact1,
    int? contact2,
    String? email,
    required String address,
    required DateTime date,
    required List<String> complaints,
  }) : super._(
         id: id,
         orderId: orderId,
         customerName: customerName,
         contact1: contact1,
         contact2: contact2,
         email: email,
         address: address,
         date: date,
         complaints: complaints,
       );

  /// Returns a shallow copy of this [Orders]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Orders copyWith({
    Object? id = _Undefined,
    String? orderId,
    String? customerName,
    int? contact1,
    Object? contact2 = _Undefined,
    Object? email = _Undefined,
    String? address,
    DateTime? date,
    List<String>? complaints,
  }) {
    return Orders(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      customerName: customerName ?? this.customerName,
      contact1: contact1 ?? this.contact1,
      contact2: contact2 is int? ? contact2 : this.contact2,
      email: email is String? ? email : this.email,
      address: address ?? this.address,
      date: date ?? this.date,
      complaints: complaints ?? this.complaints.map((e0) => e0).toList(),
    );
  }
}

class OrdersUpdateTable extends _i1.UpdateTable<OrdersTable> {
  OrdersUpdateTable(super.table);

  _i1.ColumnValue<String, String> orderId(String value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<String, String> customerName(String value) => _i1.ColumnValue(
    table.customerName,
    value,
  );

  _i1.ColumnValue<int, int> contact1(int value) => _i1.ColumnValue(
    table.contact1,
    value,
  );

  _i1.ColumnValue<int, int> contact2(int? value) => _i1.ColumnValue(
    table.contact2,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> address(String value) => _i1.ColumnValue(
    table.address,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> complaints(List<String> value) =>
      _i1.ColumnValue(
        table.complaints,
        value,
      );
}

class OrdersTable extends _i1.Table<int?> {
  OrdersTable({super.tableRelation}) : super(tableName: 'orders') {
    updateTable = OrdersUpdateTable(this);
    orderId = _i1.ColumnString(
      'orderId',
      this,
    );
    customerName = _i1.ColumnString(
      'customerName',
      this,
    );
    contact1 = _i1.ColumnInt(
      'contact1',
      this,
    );
    contact2 = _i1.ColumnInt(
      'contact2',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    complaints = _i1.ColumnSerializable<List<String>>(
      'complaints',
      this,
    );
  }

  late final OrdersUpdateTable updateTable;

  late final _i1.ColumnString orderId;

  late final _i1.ColumnString customerName;

  late final _i1.ColumnInt contact1;

  late final _i1.ColumnInt contact2;

  late final _i1.ColumnString email;

  late final _i1.ColumnString address;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnSerializable<List<String>> complaints;

  @override
  List<_i1.Column> get columns => [
    id,
    orderId,
    customerName,
    contact1,
    contact2,
    email,
    address,
    date,
    complaints,
  ];
}

class OrdersInclude extends _i1.IncludeObject {
  OrdersInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Orders.t;
}

class OrdersIncludeList extends _i1.IncludeList {
  OrdersIncludeList._({
    _i1.WhereExpressionBuilder<OrdersTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Orders.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Orders.t;
}

class OrdersRepository {
  const OrdersRepository._();

  /// Returns a list of [Orders]s matching the given query parameters.
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
  Future<List<Orders>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrdersTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrdersTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrdersTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Orders>(
      where: where?.call(Orders.t),
      orderBy: orderBy?.call(Orders.t),
      orderByList: orderByList?.call(Orders.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Orders] matching the given query parameters.
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
  Future<Orders?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrdersTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrdersTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrdersTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Orders>(
      where: where?.call(Orders.t),
      orderBy: orderBy?.call(Orders.t),
      orderByList: orderByList?.call(Orders.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Orders] by its [id] or null if no such row exists.
  Future<Orders?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Orders>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Orders]s in the list and returns the inserted rows.
  ///
  /// The returned [Orders]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Orders>> insert(
    _i1.DatabaseSession session,
    List<Orders> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Orders>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Orders] and returns the inserted row.
  ///
  /// The returned [Orders] will have its `id` field set.
  Future<Orders> insertRow(
    _i1.DatabaseSession session,
    Orders row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Orders>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Orders]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Orders>> update(
    _i1.DatabaseSession session,
    List<Orders> rows, {
    _i1.ColumnSelections<OrdersTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Orders>(
      rows,
      columns: columns?.call(Orders.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Orders]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Orders> updateRow(
    _i1.DatabaseSession session,
    Orders row, {
    _i1.ColumnSelections<OrdersTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Orders>(
      row,
      columns: columns?.call(Orders.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Orders] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Orders?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OrdersUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Orders>(
      id,
      columnValues: columnValues(Orders.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Orders]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Orders>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OrdersUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OrdersTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrdersTable>? orderBy,
    _i1.OrderByListBuilder<OrdersTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Orders>(
      columnValues: columnValues(Orders.t.updateTable),
      where: where(Orders.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Orders.t),
      orderByList: orderByList?.call(Orders.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Orders]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Orders>> delete(
    _i1.DatabaseSession session,
    List<Orders> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Orders>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Orders].
  Future<Orders> deleteRow(
    _i1.DatabaseSession session,
    Orders row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Orders>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Orders>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrdersTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Orders>(
      where: where(Orders.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrdersTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Orders>(
      where: where?.call(Orders.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Orders] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrdersTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Orders>(
      where: where(Orders.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
