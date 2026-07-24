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

abstract class Supplier
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Supplier._({
    this.id,
    required this.name,
    required this.address,
    required this.contact1,
    required this.contact2,
  });

  factory Supplier({
    int? id,
    required String name,
    required String address,
    required int contact1,
    required int contact2,
  }) = _SupplierImpl;

  factory Supplier.fromJson(Map<String, dynamic> jsonSerialization) {
    return Supplier(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      address: jsonSerialization['address'] as String,
      contact1: jsonSerialization['contact1'] as int,
      contact2: jsonSerialization['contact2'] as int,
    );
  }

  static final t = SupplierTable();

  static const db = SupplierRepository._();

  @override
  int? id;

  String name;

  String address;

  int contact1;

  int contact2;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Supplier]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Supplier copyWith({
    int? id,
    String? name,
    String? address,
    int? contact1,
    int? contact2,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Supplier',
      if (id != null) 'id': id,
      'name': name,
      'address': address,
      'contact1': contact1,
      'contact2': contact2,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Supplier',
      if (id != null) 'id': id,
      'name': name,
      'address': address,
      'contact1': contact1,
      'contact2': contact2,
    };
  }

  static SupplierInclude include() {
    return SupplierInclude._();
  }

  static SupplierIncludeList includeList({
    _i1.WhereExpressionBuilder<SupplierTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupplierTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupplierTable>? orderByList,
    SupplierInclude? include,
  }) {
    return SupplierIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Supplier.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Supplier.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupplierImpl extends Supplier {
  _SupplierImpl({
    int? id,
    required String name,
    required String address,
    required int contact1,
    required int contact2,
  }) : super._(
         id: id,
         name: name,
         address: address,
         contact1: contact1,
         contact2: contact2,
       );

  /// Returns a shallow copy of this [Supplier]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Supplier copyWith({
    Object? id = _Undefined,
    String? name,
    String? address,
    int? contact1,
    int? contact2,
  }) {
    return Supplier(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      contact1: contact1 ?? this.contact1,
      contact2: contact2 ?? this.contact2,
    );
  }
}

class SupplierUpdateTable extends _i1.UpdateTable<SupplierTable> {
  SupplierUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> address(String value) => _i1.ColumnValue(
    table.address,
    value,
  );

  _i1.ColumnValue<int, int> contact1(int value) => _i1.ColumnValue(
    table.contact1,
    value,
  );

  _i1.ColumnValue<int, int> contact2(int value) => _i1.ColumnValue(
    table.contact2,
    value,
  );
}

class SupplierTable extends _i1.Table<int?> {
  SupplierTable({super.tableRelation}) : super(tableName: 'supplier') {
    updateTable = SupplierUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    address = _i1.ColumnString(
      'address',
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
  }

  late final SupplierUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString address;

  late final _i1.ColumnInt contact1;

  late final _i1.ColumnInt contact2;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    address,
    contact1,
    contact2,
  ];
}

class SupplierInclude extends _i1.IncludeObject {
  SupplierInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Supplier.t;
}

class SupplierIncludeList extends _i1.IncludeList {
  SupplierIncludeList._({
    _i1.WhereExpressionBuilder<SupplierTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Supplier.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Supplier.t;
}

class SupplierRepository {
  const SupplierRepository._();

  /// Returns a list of [Supplier]s matching the given query parameters.
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
  Future<List<Supplier>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SupplierTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupplierTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupplierTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Supplier>(
      where: where?.call(Supplier.t),
      orderBy: orderBy?.call(Supplier.t),
      orderByList: orderByList?.call(Supplier.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Supplier] matching the given query parameters.
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
  Future<Supplier?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SupplierTable>? where,
    int? offset,
    _i1.OrderByBuilder<SupplierTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SupplierTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Supplier>(
      where: where?.call(Supplier.t),
      orderBy: orderBy?.call(Supplier.t),
      orderByList: orderByList?.call(Supplier.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Supplier] by its [id] or null if no such row exists.
  Future<Supplier?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Supplier>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Supplier]s in the list and returns the inserted rows.
  ///
  /// The returned [Supplier]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Supplier>> insert(
    _i1.DatabaseSession session,
    List<Supplier> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Supplier>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Supplier] and returns the inserted row.
  ///
  /// The returned [Supplier] will have its `id` field set.
  Future<Supplier> insertRow(
    _i1.DatabaseSession session,
    Supplier row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Supplier>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Supplier]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Supplier>> update(
    _i1.DatabaseSession session,
    List<Supplier> rows, {
    _i1.ColumnSelections<SupplierTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Supplier>(
      rows,
      columns: columns?.call(Supplier.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Supplier]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Supplier> updateRow(
    _i1.DatabaseSession session,
    Supplier row, {
    _i1.ColumnSelections<SupplierTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Supplier>(
      row,
      columns: columns?.call(Supplier.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Supplier] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Supplier?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SupplierUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Supplier>(
      id,
      columnValues: columnValues(Supplier.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Supplier]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Supplier>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SupplierUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SupplierTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SupplierTable>? orderBy,
    _i1.OrderByListBuilder<SupplierTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Supplier>(
      columnValues: columnValues(Supplier.t.updateTable),
      where: where(Supplier.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Supplier.t),
      orderByList: orderByList?.call(Supplier.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Supplier]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Supplier>> delete(
    _i1.DatabaseSession session,
    List<Supplier> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Supplier>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Supplier].
  Future<Supplier> deleteRow(
    _i1.DatabaseSession session,
    Supplier row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Supplier>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Supplier>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SupplierTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Supplier>(
      where: where(Supplier.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SupplierTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Supplier>(
      where: where?.call(Supplier.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Supplier] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SupplierTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Supplier>(
      where: where(Supplier.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
