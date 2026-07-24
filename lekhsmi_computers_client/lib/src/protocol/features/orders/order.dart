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
import 'package:lekhsmi_computers_client/src/protocol/protocol.dart' as _i2;

abstract class Orders implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String orderId;

  String customerName;

  int contact1;

  int? contact2;

  String? email;

  String address;

  DateTime date;

  List<String> complaints;

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
