/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../features/inventory/purchase/purchase.dart' as _i2;
import '../../../features/inventory/products/product.dart' as _i3;
import 'package:lekhsmi_computers_server/src/generated/protocol.dart' as _i4;

abstract class PurchaseItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = PurchaseItemTable();

  static const db = PurchaseItemRepository._();

  @override
  int? id;

  int purchaseId;

  _i2.Purchase? purchase;

  int productId;

  _i3.Product? product;

  int quantity;

  int unitPrice;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PurchaseItem',
      if (id != null) 'id': id,
      'purchaseId': purchaseId,
      if (purchase != null) 'purchase': purchase?.toJsonForProtocol(),
      'productId': productId,
      if (product != null) 'product': product?.toJsonForProtocol(),
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  static PurchaseItemInclude include({
    _i2.PurchaseInclude? purchase,
    _i3.ProductInclude? product,
  }) {
    return PurchaseItemInclude._(
      purchase: purchase,
      product: product,
    );
  }

  static PurchaseItemIncludeList includeList({
    _i1.WhereExpressionBuilder<PurchaseItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PurchaseItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PurchaseItemTable>? orderByList,
    PurchaseItemInclude? include,
  }) {
    return PurchaseItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PurchaseItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PurchaseItem.t),
      include: include,
    );
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

class PurchaseItemUpdateTable extends _i1.UpdateTable<PurchaseItemTable> {
  PurchaseItemUpdateTable(super.table);

  _i1.ColumnValue<int, int> purchaseId(int value) => _i1.ColumnValue(
    table.purchaseId,
    value,
  );

  _i1.ColumnValue<int, int> productId(int value) => _i1.ColumnValue(
    table.productId,
    value,
  );

  _i1.ColumnValue<int, int> quantity(int value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<int, int> unitPrice(int value) => _i1.ColumnValue(
    table.unitPrice,
    value,
  );
}

class PurchaseItemTable extends _i1.Table<int?> {
  PurchaseItemTable({super.tableRelation}) : super(tableName: 'purchase_item') {
    updateTable = PurchaseItemUpdateTable(this);
    purchaseId = _i1.ColumnInt(
      'purchaseId',
      this,
    );
    productId = _i1.ColumnInt(
      'productId',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    unitPrice = _i1.ColumnInt(
      'unitPrice',
      this,
    );
  }

  late final PurchaseItemUpdateTable updateTable;

  late final _i1.ColumnInt purchaseId;

  _i2.PurchaseTable? _purchase;

  late final _i1.ColumnInt productId;

  _i3.ProductTable? _product;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnInt unitPrice;

  _i2.PurchaseTable get purchase {
    if (_purchase != null) return _purchase!;
    _purchase = _i1.createRelationTable(
      relationFieldName: 'purchase',
      field: PurchaseItem.t.purchaseId,
      foreignField: _i2.Purchase.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PurchaseTable(tableRelation: foreignTableRelation),
    );
    return _purchase!;
  }

  _i3.ProductTable get product {
    if (_product != null) return _product!;
    _product = _i1.createRelationTable(
      relationFieldName: 'product',
      field: PurchaseItem.t.productId,
      foreignField: _i3.Product.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ProductTable(tableRelation: foreignTableRelation),
    );
    return _product!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    purchaseId,
    productId,
    quantity,
    unitPrice,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'purchase') {
      return purchase;
    }
    if (relationField == 'product') {
      return product;
    }
    return null;
  }
}

class PurchaseItemInclude extends _i1.IncludeObject {
  PurchaseItemInclude._({
    _i2.PurchaseInclude? purchase,
    _i3.ProductInclude? product,
  }) {
    _purchase = purchase;
    _product = product;
  }

  _i2.PurchaseInclude? _purchase;

  _i3.ProductInclude? _product;

  @override
  Map<String, _i1.Include?> get includes => {
    'purchase': _purchase,
    'product': _product,
  };

  @override
  _i1.Table<int?> get table => PurchaseItem.t;
}

class PurchaseItemIncludeList extends _i1.IncludeList {
  PurchaseItemIncludeList._({
    _i1.WhereExpressionBuilder<PurchaseItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PurchaseItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PurchaseItem.t;
}

class PurchaseItemRepository {
  const PurchaseItemRepository._();

  final attachRow = const PurchaseItemAttachRowRepository._();

  /// Returns a list of [PurchaseItem]s matching the given query parameters.
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
  Future<List<PurchaseItem>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PurchaseItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PurchaseItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PurchaseItemTable>? orderByList,
    _i1.Transaction? transaction,
    PurchaseItemInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PurchaseItem>(
      where: where?.call(PurchaseItem.t),
      orderBy: orderBy?.call(PurchaseItem.t),
      orderByList: orderByList?.call(PurchaseItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PurchaseItem] matching the given query parameters.
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
  Future<PurchaseItem?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PurchaseItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<PurchaseItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PurchaseItemTable>? orderByList,
    _i1.Transaction? transaction,
    PurchaseItemInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PurchaseItem>(
      where: where?.call(PurchaseItem.t),
      orderBy: orderBy?.call(PurchaseItem.t),
      orderByList: orderByList?.call(PurchaseItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PurchaseItem] by its [id] or null if no such row exists.
  Future<PurchaseItem?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    PurchaseItemInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PurchaseItem>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PurchaseItem]s in the list and returns the inserted rows.
  ///
  /// The returned [PurchaseItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PurchaseItem>> insert(
    _i1.DatabaseSession session,
    List<PurchaseItem> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PurchaseItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PurchaseItem] and returns the inserted row.
  ///
  /// The returned [PurchaseItem] will have its `id` field set.
  Future<PurchaseItem> insertRow(
    _i1.DatabaseSession session,
    PurchaseItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PurchaseItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PurchaseItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PurchaseItem>> update(
    _i1.DatabaseSession session,
    List<PurchaseItem> rows, {
    _i1.ColumnSelections<PurchaseItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PurchaseItem>(
      rows,
      columns: columns?.call(PurchaseItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PurchaseItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PurchaseItem> updateRow(
    _i1.DatabaseSession session,
    PurchaseItem row, {
    _i1.ColumnSelections<PurchaseItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PurchaseItem>(
      row,
      columns: columns?.call(PurchaseItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PurchaseItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PurchaseItem?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PurchaseItemUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PurchaseItem>(
      id,
      columnValues: columnValues(PurchaseItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PurchaseItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PurchaseItem>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PurchaseItemUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PurchaseItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PurchaseItemTable>? orderBy,
    _i1.OrderByListBuilder<PurchaseItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PurchaseItem>(
      columnValues: columnValues(PurchaseItem.t.updateTable),
      where: where(PurchaseItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PurchaseItem.t),
      orderByList: orderByList?.call(PurchaseItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PurchaseItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PurchaseItem>> delete(
    _i1.DatabaseSession session,
    List<PurchaseItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PurchaseItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PurchaseItem].
  Future<PurchaseItem> deleteRow(
    _i1.DatabaseSession session,
    PurchaseItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PurchaseItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PurchaseItem>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PurchaseItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PurchaseItem>(
      where: where(PurchaseItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PurchaseItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PurchaseItem>(
      where: where?.call(PurchaseItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PurchaseItem] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PurchaseItemTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PurchaseItem>(
      where: where(PurchaseItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PurchaseItemAttachRowRepository {
  const PurchaseItemAttachRowRepository._();

  /// Creates a relation between the given [PurchaseItem] and [Purchase]
  /// by setting the [PurchaseItem]'s foreign key `purchaseId` to refer to the [Purchase].
  Future<void> purchase(
    _i1.DatabaseSession session,
    PurchaseItem purchaseItem,
    _i2.Purchase purchase, {
    _i1.Transaction? transaction,
  }) async {
    if (purchaseItem.id == null) {
      throw ArgumentError.notNull('purchaseItem.id');
    }
    if (purchase.id == null) {
      throw ArgumentError.notNull('purchase.id');
    }

    var $purchaseItem = purchaseItem.copyWith(purchaseId: purchase.id);
    await session.db.updateRow<PurchaseItem>(
      $purchaseItem,
      columns: [PurchaseItem.t.purchaseId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PurchaseItem] and [Product]
  /// by setting the [PurchaseItem]'s foreign key `productId` to refer to the [Product].
  Future<void> product(
    _i1.DatabaseSession session,
    PurchaseItem purchaseItem,
    _i3.Product product, {
    _i1.Transaction? transaction,
  }) async {
    if (purchaseItem.id == null) {
      throw ArgumentError.notNull('purchaseItem.id');
    }
    if (product.id == null) {
      throw ArgumentError.notNull('product.id');
    }

    var $purchaseItem = purchaseItem.copyWith(productId: product.id);
    await session.db.updateRow<PurchaseItem>(
      $purchaseItem,
      columns: [PurchaseItem.t.productId],
      transaction: transaction,
    );
  }
}
