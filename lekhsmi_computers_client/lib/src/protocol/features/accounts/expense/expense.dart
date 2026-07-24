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

abstract class Expense implements _i1.SerializableModel {
  Expense._({
    this.id,
    required this.date,
    required this.reason,
    required this.amount,
  });

  factory Expense({
    int? id,
    required DateTime date,
    required String reason,
    required int amount,
  }) = _ExpenseImpl;

  factory Expense.fromJson(Map<String, dynamic> jsonSerialization) {
    return Expense(
      id: jsonSerialization['id'] as int?,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      reason: jsonSerialization['reason'] as String,
      amount: jsonSerialization['amount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime date;

  String reason;

  int amount;

  /// Returns a shallow copy of this [Expense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Expense copyWith({
    int? id,
    DateTime? date,
    String? reason,
    int? amount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Expense',
      if (id != null) 'id': id,
      'date': date.toJson(),
      'reason': reason,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExpenseImpl extends Expense {
  _ExpenseImpl({
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

  /// Returns a shallow copy of this [Expense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Expense copyWith({
    Object? id = _Undefined,
    DateTime? date,
    String? reason,
    int? amount,
  }) {
    return Expense(
      id: id is int? ? id : this.id,
      date: date ?? this.date,
      reason: reason ?? this.reason,
      amount: amount ?? this.amount,
    );
  }
}
