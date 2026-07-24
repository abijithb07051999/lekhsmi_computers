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

abstract class Brand implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Brand._({
    this.id,
    required this.name,
    bool? status,
  }) : status = status ?? true;

  factory Brand({
    int? id,
    required String name,
    bool? status,
  }) = _BrandImpl;

  factory Brand.fromJson(Map<String, dynamic> jsonSerialization) {
    return Brand(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['status']),
    );
  }

  static final t = BrandTable();

  static const db = BrandRepository._();

  @override
  int? id;

  String name;

  bool status;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Brand]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Brand copyWith({
    int? id,
    String? name,
    bool? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Brand',
      if (id != null) 'id': id,
      'name': name,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Brand',
      if (id != null) 'id': id,
      'name': name,
      'status': status,
    };
  }

  static BrandInclude include() {
    return BrandInclude._();
  }

  static BrandIncludeList includeList({
    _i1.WhereExpressionBuilder<BrandTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BrandTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BrandTable>? orderByList,
    BrandInclude? include,
  }) {
    return BrandIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Brand.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Brand.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BrandImpl extends Brand {
  _BrandImpl({
    int? id,
    required String name,
    bool? status,
  }) : super._(
         id: id,
         name: name,
         status: status,
       );

  /// Returns a shallow copy of this [Brand]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Brand copyWith({
    Object? id = _Undefined,
    String? name,
    bool? status,
  }) {
    return Brand(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}

class BrandUpdateTable extends _i1.UpdateTable<BrandTable> {
  BrandUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<bool, bool> status(bool value) => _i1.ColumnValue(
    table.status,
    value,
  );
}

class BrandTable extends _i1.Table<int?> {
  BrandTable({super.tableRelation}) : super(tableName: 'brand') {
    updateTable = BrandUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    status = _i1.ColumnBool(
      'status',
      this,
      hasDefault: true,
    );
  }

  late final BrandUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnBool status;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    status,
  ];
}

class BrandInclude extends _i1.IncludeObject {
  BrandInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Brand.t;
}

class BrandIncludeList extends _i1.IncludeList {
  BrandIncludeList._({
    _i1.WhereExpressionBuilder<BrandTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Brand.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Brand.t;
}

class BrandRepository {
  const BrandRepository._();

  /// Returns a list of [Brand]s matching the given query parameters.
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
  Future<List<Brand>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BrandTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BrandTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BrandTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Brand>(
      where: where?.call(Brand.t),
      orderBy: orderBy?.call(Brand.t),
      orderByList: orderByList?.call(Brand.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Brand] matching the given query parameters.
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
  Future<Brand?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BrandTable>? where,
    int? offset,
    _i1.OrderByBuilder<BrandTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BrandTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Brand>(
      where: where?.call(Brand.t),
      orderBy: orderBy?.call(Brand.t),
      orderByList: orderByList?.call(Brand.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Brand] by its [id] or null if no such row exists.
  Future<Brand?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Brand>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Brand]s in the list and returns the inserted rows.
  ///
  /// The returned [Brand]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Brand>> insert(
    _i1.DatabaseSession session,
    List<Brand> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Brand>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Brand] and returns the inserted row.
  ///
  /// The returned [Brand] will have its `id` field set.
  Future<Brand> insertRow(
    _i1.DatabaseSession session,
    Brand row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Brand>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Brand]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Brand>> update(
    _i1.DatabaseSession session,
    List<Brand> rows, {
    _i1.ColumnSelections<BrandTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Brand>(
      rows,
      columns: columns?.call(Brand.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Brand]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Brand> updateRow(
    _i1.DatabaseSession session,
    Brand row, {
    _i1.ColumnSelections<BrandTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Brand>(
      row,
      columns: columns?.call(Brand.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Brand] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Brand?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BrandUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Brand>(
      id,
      columnValues: columnValues(Brand.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Brand]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Brand>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BrandUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BrandTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BrandTable>? orderBy,
    _i1.OrderByListBuilder<BrandTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Brand>(
      columnValues: columnValues(Brand.t.updateTable),
      where: where(Brand.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Brand.t),
      orderByList: orderByList?.call(Brand.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Brand]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Brand>> delete(
    _i1.DatabaseSession session,
    List<Brand> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Brand>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Brand].
  Future<Brand> deleteRow(
    _i1.DatabaseSession session,
    Brand row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Brand>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Brand>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BrandTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Brand>(
      where: where(Brand.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BrandTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Brand>(
      where: where?.call(Brand.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Brand] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BrandTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Brand>(
      where: where(Brand.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
