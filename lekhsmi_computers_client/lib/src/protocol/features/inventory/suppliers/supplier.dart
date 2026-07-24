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

abstract class Supplier implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String address;

  int contact1;

  int contact2;

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
