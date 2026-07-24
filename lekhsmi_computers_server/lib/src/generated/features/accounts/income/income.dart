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

abstract class Income implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Income._({
    this.id,
    required this.date,
    required this.reason,
    required this.amount,
  });

  factory Income({
    int? id,
    required DateTime date,
    required String reason,
    required int amount,
  }) = _IncomeImpl;

  factory Income.fromJson(Map<String, dynamic> jsonSerialization) {
    return Income(
      id: jsonSerialization['id'] as int?,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      reason: jsonSerialization['reason'] as String,
      amount: jsonSerialization['amount'] as int,
    );
  }

  static final t = IncomeTable();

  static const db = IncomeRepository._();

  @override
  int? id;

  DateTime date;

  String reason;

  int amount;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Income]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Income copyWith({
    int? id,
    DateTime? date,
    String? reason,
    int? amount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Income',
      if (id != null) 'id': id,
      'date': date.toJson(),
      'reason': reason,
      'amount': amount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Income',
      if (id != null) 'id': id,
      'date': date.toJson(),
      'reason': reason,
      'amount': amount,
    };
  }

  static IncomeInclude include() {
    return IncomeInclude._();
  }

  static IncomeIncludeList includeList({
    _i1.WhereExpressionBuilder<IncomeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IncomeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IncomeTable>? orderByList,
    IncomeInclude? include,
  }) {
    return IncomeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Income.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Income.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IncomeImpl extends Income {
  _IncomeImpl({
    int? id,
    required DateTime date,
    required String reason,
    required int amount,
  }) : super._(
         id: id,
         date: date,
         reason: reason,
         amount: amount,
       );

  /// Returns a shallow copy of this [Income]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Income copyWith({
    Object? id = _Undefined,
    DateTime? date,
    String? reason,
    int? amount,
  }) {
    return Income(
      id: id is int? ? id : this.id,
      date: date ?? this.date,
      reason: reason ?? this.reason,
      amount: amount ?? this.amount,
    );
  }
}

class IncomeUpdateTable extends _i1.UpdateTable<IncomeTable> {
  IncomeUpdateTable(super.table);

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );

  _i1.ColumnValue<String, String> reason(String value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<int, int> amount(int value) => _i1.ColumnValue(
    table.amount,
    value,
  );
}

class IncomeTable extends _i1.Table<int?> {
  IncomeTable({super.tableRelation}) : super(tableName: 'income') {
    updateTable = IncomeUpdateTable(this);
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    amount = _i1.ColumnInt(
      'amount',
      this,
    );
  }

  late final IncomeUpdateTable updateTable;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnString reason;

  late final _i1.ColumnInt amount;

  @override
  List<_i1.Column> get columns => [
    id,
    date,
    reason,
    amount,
  ];
}

class IncomeInclude extends _i1.IncludeObject {
  IncomeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Income.t;
}

class IncomeIncludeList extends _i1.IncludeList {
  IncomeIncludeList._({
    _i1.WhereExpressionBuilder<IncomeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Income.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Income.t;
}

class IncomeRepository {
  const IncomeRepository._();

  /// Returns a list of [Income]s matching the given query parameters.
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
  Future<List<Income>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<IncomeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IncomeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IncomeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Income>(
      where: where?.call(Income.t),
      orderBy: orderBy?.call(Income.t),
      orderByList: orderByList?.call(Income.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Income] matching the given query parameters.
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
  Future<Income?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<IncomeTable>? where,
    int? offset,
    _i1.OrderByBuilder<IncomeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IncomeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Income>(
      where: where?.call(Income.t),
      orderBy: orderBy?.call(Income.t),
      orderByList: orderByList?.call(Income.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Income] by its [id] or null if no such row exists.
  Future<Income?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Income>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Income]s in the list and returns the inserted rows.
  ///
  /// The returned [Income]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Income>> insert(
    _i1.DatabaseSession session,
    List<Income> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Income>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Income] and returns the inserted row.
  ///
  /// The returned [Income] will have its `id` field set.
  Future<Income> insertRow(
    _i1.DatabaseSession session,
    Income row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Income>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Income]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Income>> update(
    _i1.DatabaseSession session,
    List<Income> rows, {
    _i1.ColumnSelections<IncomeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Income>(
      rows,
      columns: columns?.call(Income.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Income]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Income> updateRow(
    _i1.DatabaseSession session,
    Income row, {
    _i1.ColumnSelections<IncomeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Income>(
      row,
      columns: columns?.call(Income.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Income] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Income?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<IncomeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Income>(
      id,
      columnValues: columnValues(Income.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Income]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Income>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<IncomeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<IncomeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IncomeTable>? orderBy,
    _i1.OrderByListBuilder<IncomeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Income>(
      columnValues: columnValues(Income.t.updateTable),
      where: where(Income.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Income.t),
      orderByList: orderByList?.call(Income.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Income]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Income>> delete(
    _i1.DatabaseSession session,
    List<Income> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Income>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Income].
  Future<Income> deleteRow(
    _i1.DatabaseSession session,
    Income row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Income>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Income>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<IncomeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Income>(
      where: where(Income.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<IncomeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Income>(
      where: where?.call(Income.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Income] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<IncomeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Income>(
      where: where(Income.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
