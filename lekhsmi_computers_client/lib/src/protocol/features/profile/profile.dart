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

abstract class Profile implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String storeName;

  String phone;

  String email;

  String? website;

  String address;

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
