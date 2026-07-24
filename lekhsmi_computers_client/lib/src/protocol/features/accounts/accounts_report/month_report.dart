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
import '../../../features/accounts/income/income.dart' as _i2;
import '../../../features/accounts/expense/expense.dart' as _i3;
import 'package:lekhsmi_computers_client/src/protocol/protocol.dart' as _i4;

abstract class MonthDetailReport implements _i1.SerializableModel {
  MonthDetailReport._({
    required this.incomes,
    required this.expenses,
  });

  factory MonthDetailReport({
    required List<_i2.Income> incomes,
    required List<_i3.Expense> expenses,
  }) = _MonthDetailReportImpl;

  factory MonthDetailReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return MonthDetailReport(
      incomes: _i4.Protocol().deserialize<List<_i2.Income>>(
        jsonSerialization['incomes'],
      ),
      expenses: _i4.Protocol().deserialize<List<_i3.Expense>>(
        jsonSerialization['expenses'],
      ),
    );
  }

  List<_i2.Income> incomes;

  List<_i3.Expense> expenses;

  /// Returns a shallow copy of this [MonthDetailReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MonthDetailReport copyWith({
    List<_i2.Income>? incomes,
    List<_i3.Expense>? expenses,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MonthDetailReport',
      'incomes': incomes.toJson(valueToJson: (v) => v.toJson()),
      'expenses': expenses.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MonthDetailReportImpl extends MonthDetailReport {
  _MonthDetailReportImpl({
    required List<_i2.Income> incomes,
    required List<_i3.Expense> expenses,
  }) : super._(
         incomes: incomes,
         expenses: expenses,
       );

  /// Returns a shallow copy of this [MonthDetailReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MonthDetailReport copyWith({
    List<_i2.Income>? incomes,
    List<_i3.Expense>? expenses,
  }) {
    return MonthDetailReport(
      incomes: incomes ?? this.incomes.map((e0) => e0.copyWith()).toList(),
      expenses: expenses ?? this.expenses.map((e0) => e0.copyWith()).toList(),
    );
  }
}
