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

abstract class AccountsReportEntry
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AccountsReportEntry._({
    required this.date,
    required this.income,
    required this.expense,
    required this.profitLoss,
  });

  factory AccountsReportEntry({
    required String date,
    required int income,
    required int expense,
    required int profitLoss,
  }) = _AccountsReportEntryImpl;

  factory AccountsReportEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccountsReportEntry(
      date: jsonSerialization['date'] as String,
      income: jsonSerialization['income'] as int,
      expense: jsonSerialization['expense'] as int,
      profitLoss: jsonSerialization['profitLoss'] as int,
    );
  }

  String date;

  int income;

  int expense;

  int profitLoss;

  /// Returns a shallow copy of this [AccountsReportEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AccountsReportEntry copyWith({
    String? date,
    int? income,
    int? expense,
    int? profitLoss,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccountsReportEntry',
      'date': date,
      'income': income,
      'expense': expense,
      'profitLoss': profitLoss,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccountsReportEntry',
      'date': date,
      'income': income,
      'expense': expense,
      'profitLoss': profitLoss,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AccountsReportEntryImpl extends AccountsReportEntry {
  _AccountsReportEntryImpl({
    required String date,
    required int income,
    required int expense,
    required int profitLoss,
  }) : super._(
         date: date,
         income: income,
         expense: expense,
         profitLoss: profitLoss,
       );

  /// Returns a shallow copy of this [AccountsReportEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AccountsReportEntry copyWith({
    String? date,
    int? income,
    int? expense,
    int? profitLoss,
  }) {
    return AccountsReportEntry(
      date: date ?? this.date,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      profitLoss: profitLoss ?? this.profitLoss,
    );
  }
}
