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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../features/inventory/categories/category.dart' as _i2;
import '../../../features/inventory/brands/brand.dart' as _i3;
import 'package:lekhsmi_computers_client/src/protocol/protocol.dart' as _i4;

abstract class Product implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
