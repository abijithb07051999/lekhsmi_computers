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
import '../../../features/inventory/categories/category.dart' as _i2;
import '../../../features/inventory/brands/brand.dart' as _i3;
import 'package:lekhsmi_computers_server/src/generated/protocol.dart' as _i4;

abstract class Product
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Product._({
    this.id,
    required this.name,
    required this.categoryId,
    this.category,
    required this.brandId,
    this.brand,
    required this.quality,
    required this.quantity,
    required this.buyPrice,
    required this.sellPrice,
    bool? status,
  }) : status = status ?? true;

  factory Product({
    int? id,
    required String name,
    required int categoryId,
    _i2.Category? category,
    required int brandId,
    _i3.Brand? brand,
    required String quality,
    required int quantity,
    required int buyPrice,
    required int sellPrice,
    bool? status,
  }) = _ProductImpl;

  factory Product.fromJson(Map<String, dynamic> jsonSerialization) {
    return Product(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      categoryId: jsonSerialization['categoryId'] as int,
      category: jsonSerialization['category'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Category>(
              jsonSerialization['category'],
            ),
      brandId: jsonSerialization['brandId'] as int,
      brand: jsonSerialization['brand'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Brand>(jsonSerialization['brand']),
      quality: jsonSerialization['quality'] as String,
      quantity: jsonSerialization['quantity'] as int,
      buyPrice: jsonSerialization['buyPrice'] as int,
      sellPrice: jsonSerialization['sellPrice'] as int,
      status: jsonSerialization['status'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['status']),
    );
  }

  static final t = ProductTable();

  static const db = ProductRepository._();

  @override
  int? id;

  String name;

  int categoryId;

  _i2.Category? category;

  int brandId;

  _i3.Brand? brand;

  String quality;

  int quantity;

  int buyPrice;

  int sellPrice;

  bool status;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Product]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Product copyWith({
    int? id,
    String? name,
    int? categoryId,
    _i2.Category? category,
    int? brandId,
    _i3.Brand? brand,
    String? quality,
    int? quantity,
    int? buyPrice,
    int? sellPrice,
    bool? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Product',
      if (id != null) 'id': id,
      'name': name,
      'categoryId': categoryId,
      if (category != null) 'category': category?.toJson(),
      'brandId': brandId,
      if (brand != null) 'brand': brand?.toJson(),
      'quality': quality,
      'quantity': quantity,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Product',
      if (id != null) 'id': id,
      'name': name,
      'categoryId': categoryId,
      if (category != null) 'category': category?.toJsonForProtocol(),
      'brandId': brandId,
      if (brand != null) 'brand': brand?.toJsonForProtocol(),
      'quality': quality,
      'quantity': quantity,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'status': status,
    };
  }

  static ProductInclude include({
    _i2.CategoryInclude? category,
    _i3.BrandInclude? brand,
  }) {
    return ProductInclude._(
      category: category,
      brand: brand,
    );
  }

  static ProductIncludeList includeList({
    _i1.WhereExpressionBuilder<ProductTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductTable>? orderByList,
    ProductInclude? include,
  }) {
    return ProductIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Product.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Product.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductImpl extends Product {
  _ProductImpl({
    int? id,
    required String name,
    required int categoryId,
    _i2.Category? category,
    required int brandId,
    _i3.Brand? brand,
    required String quality,
    required int quantity,
    required int buyPrice,
    required int sellPrice,
    bool? status,
  }) : super._(
         id: id,
         name: name,
         categoryId: categoryId,
         category: category,
         brandId: brandId,
         brand: brand,
         quality: quality,
         quantity: quantity,
         buyPrice: buyPrice,
         sellPrice: sellPrice,
         status: status,
       );

  /// Returns a shallow copy of this [Product]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Product copyWith({
    Object? id = _Undefined,
    String? name,
    int? categoryId,
    Object? category = _Undefined,
    int? brandId,
    Object? brand = _Undefined,
    String? quality,
    int? quantity,
    int? buyPrice,
    int? sellPrice,
    bool? status,
  }) {
    return Product(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      category: category is _i2.Category?
          ? category
          : this.category?.copyWith(),
      brandId: brandId ?? this.brandId,
      brand: brand is _i3.Brand? ? brand : this.brand?.copyWith(),
      quality: quality ?? this.quality,
      quantity: quantity ?? this.quantity,
      buyPrice: buyPrice ?? this.buyPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      status: status ?? this.status,
    );
  }
}

class ProductUpdateTable extends _i1.UpdateTable<ProductTable> {
  ProductUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<int, int> categoryId(int value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );

  _i1.ColumnValue<int, int> brandId(int value) => _i1.ColumnValue(
    table.brandId,
    value,
  );

  _i1.ColumnValue<String, String> quality(String value) => _i1.ColumnValue(
    table.quality,
    value,
  );

  _i1.ColumnValue<int, int> quantity(int value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<int, int> buyPrice(int value) => _i1.ColumnValue(
    table.buyPrice,
    value,
  );

  _i1.ColumnValue<int, int> sellPrice(int value) => _i1.ColumnValue(
    table.sellPrice,
    value,
  );

  _i1.ColumnValue<bool, bool> status(bool value) => _i1.ColumnValue(
    table.status,
    value,
  );
}

class ProductTable extends _i1.Table<int?> {
  ProductTable({super.tableRelation}) : super(tableName: 'product') {
    updateTable = ProductUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    brandId = _i1.ColumnInt(
      'brandId',
      this,
    );
    quality = _i1.ColumnString(
      'quality',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    buyPrice = _i1.ColumnInt(
      'buyPrice',
      this,
    );
    sellPrice = _i1.ColumnInt(
      'sellPrice',
      this,
    );
    status = _i1.ColumnBool(
      'status',
      this,
      hasDefault: true,
    );
  }

  late final ProductUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnInt categoryId;

  _i2.CategoryTable? _category;

  late final _i1.ColumnInt brandId;

  _i3.BrandTable? _brand;

  late final _i1.ColumnString quality;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnInt buyPrice;

  late final _i1.ColumnInt sellPrice;

  late final _i1.ColumnBool status;

  _i2.CategoryTable get category {
    if (_category != null) return _category!;
    _category = _i1.createRelationTable(
      relationFieldName: 'category',
      field: Product.t.categoryId,
      foreignField: _i2.Category.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CategoryTable(tableRelation: foreignTableRelation),
    );
    return _category!;
  }

  _i3.BrandTable get brand {
    if (_brand != null) return _brand!;
    _brand = _i1.createRelationTable(
      relationFieldName: 'brand',
      field: Product.t.brandId,
      foreignField: _i3.Brand.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.BrandTable(tableRelation: foreignTableRelation),
    );
    return _brand!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    categoryId,
    brandId,
    quality,
    quantity,
    buyPrice,
    sellPrice,
    status,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'category') {
      return category;
    }
    if (relationField == 'brand') {
      return brand;
    }
    return null;
  }
}

class ProductInclude extends _i1.IncludeObject {
  ProductInclude._({
    _i2.CategoryInclude? category,
    _i3.BrandInclude? brand,
  }) {
    _category = category;
    _brand = brand;
  }

  _i2.CategoryInclude? _category;

  _i3.BrandInclude? _brand;

  @override
  Map<String, _i1.Include?> get includes => {
    'category': _category,
    'brand': _brand,
  };

  @override
  _i1.Table<int?> get table => Product.t;
}

class ProductIncludeList extends _i1.IncludeList {
  ProductIncludeList._({
    _i1.WhereExpressionBuilder<ProductTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Product.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Product.t;
}

class ProductRepository {
  const ProductRepository._();

  final attachRow = const ProductAttachRowRepository._();

  /// Returns a list of [Product]s matching the given query parameters.
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
  Future<List<Product>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductTable>? orderByList,
    _i1.Transaction? transaction,
    ProductInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Product>(
      where: where?.call(Product.t),
      orderBy: orderBy?.call(Product.t),
      orderByList: orderByList?.call(Product.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Product] matching the given query parameters.
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
  Future<Product?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProductTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductTable>? orderByList,
    _i1.Transaction? transaction,
    ProductInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Product>(
      where: where?.call(Product.t),
      orderBy: orderBy?.call(Product.t),
      orderByList: orderByList?.call(Product.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Product] by its [id] or null if no such row exists.
  Future<Product?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ProductInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Product>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Product]s in the list and returns the inserted rows.
  ///
  /// The returned [Product]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Product>> insert(
    _i1.DatabaseSession session,
    List<Product> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Product>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Product] and returns the inserted row.
  ///
  /// The returned [Product] will have its `id` field set.
  Future<Product> insertRow(
    _i1.DatabaseSession session,
    Product row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Product>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Product]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Product>> update(
    _i1.DatabaseSession session,
    List<Product> rows, {
    _i1.ColumnSelections<ProductTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Product>(
      rows,
      columns: columns?.call(Product.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Product]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Product> updateRow(
    _i1.DatabaseSession session,
    Product row, {
    _i1.ColumnSelections<ProductTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Product>(
      row,
      columns: columns?.call(Product.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Product] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Product?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProductUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Product>(
      id,
      columnValues: columnValues(Product.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Product]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Product>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProductUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProductTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductTable>? orderBy,
    _i1.OrderByListBuilder<ProductTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Product>(
      columnValues: columnValues(Product.t.updateTable),
      where: where(Product.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Product.t),
      orderByList: orderByList?.call(Product.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Product]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Product>> delete(
    _i1.DatabaseSession session,
    List<Product> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Product>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Product].
  Future<Product> deleteRow(
    _i1.DatabaseSession session,
    Product row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Product>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Product>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Product>(
      where: where(Product.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Product>(
      where: where?.call(Product.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Product] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Product>(
      where: where(Product.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ProductAttachRowRepository {
  const ProductAttachRowRepository._();

  /// Creates a relation between the given [Product] and [Category]
  /// by setting the [Product]'s foreign key `categoryId` to refer to the [Category].
  Future<void> category(
    _i1.DatabaseSession session,
    Product product,
    _i2.Category category, {
    _i1.Transaction? transaction,
  }) async {
    if (product.id == null) {
      throw ArgumentError.notNull('product.id');
    }
    if (category.id == null) {
      throw ArgumentError.notNull('category.id');
    }

    var $product = product.copyWith(categoryId: category.id);
    await session.db.updateRow<Product>(
      $product,
      columns: [Product.t.categoryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Product] and [Brand]
  /// by setting the [Product]'s foreign key `brandId` to refer to the [Brand].
  Future<void> brand(
    _i1.DatabaseSession session,
    Product product,
    _i3.Brand brand, {
    _i1.Transaction? transaction,
  }) async {
    if (product.id == null) {
      throw ArgumentError.notNull('product.id');
    }
    if (brand.id == null) {
      throw ArgumentError.notNull('brand.id');
    }

    var $product = product.copyWith(brandId: brand.id);
    await session.db.updateRow<Product>(
      $product,
      columns: [Product.t.brandId],
      transaction: transaction,
    );
  }
}
