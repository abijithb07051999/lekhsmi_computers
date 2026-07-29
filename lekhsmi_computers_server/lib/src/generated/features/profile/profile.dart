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

abstract class Profile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Profile._({
    this.id,
    required this.storeName,
    required this.phone,
    required this.email,
    this.website,
    required this.address,
  });

  factory Profile({
    int? id,
    required String storeName,
    required String phone,
    required String email,
    String? website,
    required String address,
  }) = _ProfileImpl;

  factory Profile.fromJson(Map<String, dynamic> jsonSerialization) {
    return Profile(
      id: jsonSerialization['id'] as int?,
      storeName: jsonSerialization['storeName'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
      website: jsonSerialization['website'] as String?,
      address: jsonSerialization['address'] as String,
    );
  }

  static final t = ProfileTable();

  static const db = ProfileRepository._();

  @override
  int? id;

  String storeName;

  String phone;

  String email;

  String? website;

  String address;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Profile copyWith({
    int? id,
    String? storeName,
    String? phone,
    String? email,
    String? website,
    String? address,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'storeName': storeName,
      'phone': phone,
      'email': email,
      if (website != null) 'website': website,
      'address': address,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'storeName': storeName,
      'phone': phone,
      'email': email,
      if (website != null) 'website': website,
      'address': address,
    };
  }

  static ProfileInclude include() {
    return ProfileInclude._();
  }

  static ProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<ProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfileTable>? orderByList,
    ProfileInclude? include,
  }) {
    return ProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Profile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Profile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileImpl extends Profile {
  _ProfileImpl({
    int? id,
    required String storeName,
    required String phone,
    required String email,
    String? website,
    required String address,
  }) : super._(
         id: id,
         storeName: storeName,
         phone: phone,
         email: email,
         website: website,
         address: address,
       );

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Profile copyWith({
    Object? id = _Undefined,
    String? storeName,
    String? phone,
    String? email,
    Object? website = _Undefined,
    String? address,
  }) {
    return Profile(
      id: id is int? ? id : this.id,
      storeName: storeName ?? this.storeName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website is String? ? website : this.website,
      address: address ?? this.address,
    );
  }
}

class ProfileUpdateTable extends _i1.UpdateTable<ProfileTable> {
  ProfileUpdateTable(super.table);

  _i1.ColumnValue<String, String> storeName(String value) => _i1.ColumnValue(
    table.storeName,
    value,
  );

  _i1.ColumnValue<String, String> phone(String value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<String, String> email(String value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> website(String? value) => _i1.ColumnValue(
    table.website,
    value,
  );

  _i1.ColumnValue<String, String> address(String value) => _i1.ColumnValue(
    table.address,
    value,
  );
}

class ProfileTable extends _i1.Table<int?> {
  ProfileTable({super.tableRelation}) : super(tableName: 'profile') {
    updateTable = ProfileUpdateTable(this);
    storeName = _i1.ColumnString(
      'storeName',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    website = _i1.ColumnString(
      'website',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
  }

  late final ProfileUpdateTable updateTable;

  late final _i1.ColumnString storeName;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnString website;

  late final _i1.ColumnString address;

  @override
  List<_i1.Column> get columns => [
    id,
    storeName,
    phone,
    email,
    website,
    address,
  ];
}

class ProfileInclude extends _i1.IncludeObject {
  ProfileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Profile.t;
}

class ProfileIncludeList extends _i1.IncludeList {
  ProfileIncludeList._({
    _i1.WhereExpressionBuilder<ProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Profile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Profile.t;
}

class ProfileRepository {
  const ProfileRepository._();

  /// Returns a list of [Profile]s matching the given query parameters.
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
  Future<List<Profile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Profile>(
      where: where?.call(Profile.t),
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Profile] matching the given query parameters.
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
  Future<Profile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Profile>(
      where: where?.call(Profile.t),
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Profile] by its [id] or null if no such row exists.
  Future<Profile?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Profile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Profile]s in the list and returns the inserted rows.
  ///
  /// The returned [Profile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Profile>> insert(
    _i1.DatabaseSession session,
    List<Profile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Profile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Profile] and returns the inserted row.
  ///
  /// The returned [Profile] will have its `id` field set.
  Future<Profile> insertRow(
    _i1.DatabaseSession session,
    Profile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Profile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Profile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Profile>> update(
    _i1.DatabaseSession session,
    List<Profile> rows, {
    _i1.ColumnSelections<ProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Profile>(
      rows,
      columns: columns?.call(Profile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Profile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Profile> updateRow(
    _i1.DatabaseSession session,
    Profile row, {
    _i1.ColumnSelections<ProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Profile>(
      row,
      columns: columns?.call(Profile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Profile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Profile?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProfileUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Profile>(
      id,
      columnValues: columnValues(Profile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Profile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Profile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProfileUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProfileTable>? orderBy,
    _i1.OrderByListBuilder<ProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Profile>(
      columnValues: columnValues(Profile.t.updateTable),
      where: where(Profile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Profile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Profile>> delete(
    _i1.DatabaseSession session,
    List<Profile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Profile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Profile].
  Future<Profile> deleteRow(
    _i1.DatabaseSession session,
    Profile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Profile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Profile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Profile>(
      where: where(Profile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Profile>(
      where: where?.call(Profile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Profile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProfileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Profile>(
      where: where(Profile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
