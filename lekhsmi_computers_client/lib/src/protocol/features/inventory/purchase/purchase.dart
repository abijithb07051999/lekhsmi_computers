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
import '../../../features/inventory/suppliers/supplier.dart' as _i2;
import 'package:lekhsmi_computers_client/src/protocol/protocol.dart' as _i3;

abstract class Purchase implements _i1.SerializableModel {
  Purchase._({
    this.id,
    required this.invoiceNo,
    required this.date,
    required this.supplierId,
    this.supplier,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.paymentStatus,
  });

  factory Purchase({
    int? id,
    required String invoiceNo,
    required DateTime date,
    required int supplierId,
    _i2.Supplier? supplier,
    required int totalAmount,
    required int paidAmount,
    required int dueAmount,
    required String paymentStatus,
  }) = _PurchaseImpl;

  factory Purchase.fromJson(Map<String, dynamic> jsonSerialization) {
    return Purchase(
      id: jsonSerialization['id'] as int?,
      invoiceNo: jsonSerialization['invoiceNo'] as String,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      supplierId: jsonSerialization['supplierId'] as int,
      supplier: jsonSerialization['supplier'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Supplier>(
              jsonSerialization['supplier'],
            ),
      totalAmount: jsonSerialization['totalAmount'] as int,
      paidAmount: jsonSerialization['paidAmount'] as int,
      dueAmount: jsonSerialization['dueAmount'] as int,
      paymentStatus: jsonSerialization['paymentStatus'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String invoiceNo;

  DateTime date;

  int supplierId;

  _i2.Supplier? supplier;

  int totalAmount;

  int paidAmount;

  int dueAmount;

  String paymentStatus;

  /// Returns a shallow copy of this [Purchase]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Purchase copyWith({
    int? id,
    String? invoiceNo,
    DateTime? date,
    int? supplierId,
    _i2.Supplier? supplier,
    int? totalAmount,
    int? paidAmount,
    int? dueAmount,
    String? paymentStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Purchase',
      if (id != null) 'id': id,
      'invoiceNo': invoiceNo,
      'date': date.toJson(),
      'supplierId': supplierId,
      if (supplier != null) 'supplier': supplier?.toJson(),
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'paymentStatus': paymentStatus,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PurchaseImpl extends Purchase {
  _PurchaseImpl({
    int? id,
    required String invoiceNo,
    required DateTime date,
    required int supplierId,
    _i2.Supplier? supplier,
    required int totalAmount,
    required int paidAmount,
    required int dueAmount,
    required String paymentStatus,
  }) : super._(
         id: id,
         invoiceNo: invoiceNo,
         date: date,
         supplierId: supplierId,
         supplier: supplier,
         totalAmount: totalAmount,
         paidAmount: paidAmount,
         dueAmount: dueAmount,
         paymentStatus: paymentStatus,
       );

  /// Returns a shallow copy of this [Purchase]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Purchase copyWith({
    Object? id = _Undefined,
    String? invoiceNo,
    DateTime? date,
    int? supplierId,
    Object? supplier = _Undefined,
    int? totalAmount,
    int? paidAmount,
    int? dueAmount,
    String? paymentStatus,
  }) {
    return Purchase(
      id: id is int? ? id : this.id,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      date: date ?? this.date,
      supplierId: supplierId ?? this.supplierId,
      supplier: supplier is _i2.Supplier?
          ? supplier
          : this.supplier?.copyWith(),
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }
}
