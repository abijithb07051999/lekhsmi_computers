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
import 'features/accounts/accounts_report/accounts_report.dart' as _i2;
import 'features/accounts/accounts_report/month_report.dart' as _i3;
import 'features/accounts/expense/expense.dart' as _i4;
import 'features/accounts/income/income.dart' as _i5;
import 'features/inventory/brands/brand.dart' as _i6;
import 'features/inventory/categories/category.dart' as _i7;
import 'features/inventory/products/product.dart' as _i8;
import 'features/inventory/purchase/purchase.dart' as _i9;
import 'features/inventory/purchase/purchase_item.dart' as _i10;
import 'features/inventory/suppliers/supplier.dart' as _i11;
import 'features/orders/order.dart' as _i12;
import 'features/orders/order_history.dart' as _i13;
import 'features/profile/profile.dart' as _i14;
import 'package:lekhsmi_computers_client/src/protocol/features/accounts/accounts_report/accounts_report.dart'
    as _i15;
import 'package:lekhsmi_computers_client/src/protocol/features/accounts/expense/expense.dart'
    as _i16;
import 'package:lekhsmi_computers_client/src/protocol/features/accounts/income/income.dart'
    as _i17;
import 'package:lekhsmi_computers_client/src/protocol/features/inventory/suppliers/supplier.dart'
    as _i18;
import 'package:lekhsmi_computers_client/src/protocol/features/inventory/products/product.dart'
    as _i19;
import 'package:lekhsmi_computers_client/src/protocol/features/orders/order_history.dart'
    as _i20;
import 'package:lekhsmi_computers_client/src/protocol/features/inventory/brands/brand.dart'
    as _i21;
import 'package:lekhsmi_computers_client/src/protocol/features/inventory/categories/category.dart'
    as _i22;
import 'package:lekhsmi_computers_client/src/protocol/features/inventory/purchase/purchase.dart'
    as _i23;
import 'package:lekhsmi_computers_client/src/protocol/features/inventory/purchase/purchase_item.dart'
    as _i24;
import 'package:lekhsmi_computers_client/src/protocol/features/orders/order.dart'
    as _i25;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i26;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i27;
export 'features/accounts/accounts_report/accounts_report.dart';
export 'features/accounts/accounts_report/month_report.dart';
export 'features/accounts/expense/expense.dart';
export 'features/accounts/income/income.dart';
export 'features/inventory/brands/brand.dart';
export 'features/inventory/categories/category.dart';
export 'features/inventory/products/product.dart';
export 'features/inventory/purchase/purchase.dart';
export 'features/inventory/purchase/purchase_item.dart';
export 'features/inventory/suppliers/supplier.dart';
export 'features/orders/order.dart';
export 'features/orders/order_history.dart';
export 'features/profile/profile.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AccountsReportEntry) {
      return _i2.AccountsReportEntry.fromJson(data) as T;
    }
    if (t == _i3.MonthDetailReport) {
      return _i3.MonthDetailReport.fromJson(data) as T;
    }
    if (t == _i4.Expense) {
      return _i4.Expense.fromJson(data) as T;
    }
    if (t == _i5.Income) {
      return _i5.Income.fromJson(data) as T;
    }
    if (t == _i6.Brand) {
      return _i6.Brand.fromJson(data) as T;
    }
    if (t == _i7.Category) {
      return _i7.Category.fromJson(data) as T;
    }
    if (t == _i8.Product) {
      return _i8.Product.fromJson(data) as T;
    }
    if (t == _i9.Purchase) {
      return _i9.Purchase.fromJson(data) as T;
    }
    if (t == _i10.PurchaseItem) {
      return _i10.PurchaseItem.fromJson(data) as T;
    }
    if (t == _i11.Supplier) {
      return _i11.Supplier.fromJson(data) as T;
    }
    if (t == _i12.Orders) {
      return _i12.Orders.fromJson(data) as T;
    }
    if (t == _i13.OrderHistory) {
      return _i13.OrderHistory.fromJson(data) as T;
    }
    if (t == _i14.Profile) {
      return _i14.Profile.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AccountsReportEntry?>()) {
      return (data != null ? _i2.AccountsReportEntry.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i3.MonthDetailReport?>()) {
      return (data != null ? _i3.MonthDetailReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Expense?>()) {
      return (data != null ? _i4.Expense.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Income?>()) {
      return (data != null ? _i5.Income.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Brand?>()) {
      return (data != null ? _i6.Brand.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Category?>()) {
      return (data != null ? _i7.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Product?>()) {
      return (data != null ? _i8.Product.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Purchase?>()) {
      return (data != null ? _i9.Purchase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.PurchaseItem?>()) {
      return (data != null ? _i10.PurchaseItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Supplier?>()) {
      return (data != null ? _i11.Supplier.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Orders?>()) {
      return (data != null ? _i12.Orders.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.OrderHistory?>()) {
      return (data != null ? _i13.OrderHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Profile?>()) {
      return (data != null ? _i14.Profile.fromJson(data) : null) as T;
    }
    if (t == List<_i5.Income>) {
      return (data as List).map((e) => deserialize<_i5.Income>(e)).toList()
          as T;
    }
    if (t == List<_i4.Expense>) {
      return (data as List).map((e) => deserialize<_i4.Expense>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i15.AccountsReportEntry>) {
      return (data as List)
              .map((e) => deserialize<_i15.AccountsReportEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.Expense>) {
      return (data as List).map((e) => deserialize<_i16.Expense>(e)).toList()
          as T;
    }
    if (t == List<_i17.Income>) {
      return (data as List).map((e) => deserialize<_i17.Income>(e)).toList()
          as T;
    }
    if (t == List<_i18.Supplier>) {
      return (data as List).map((e) => deserialize<_i18.Supplier>(e)).toList()
          as T;
    }
    if (t == List<_i19.Product>) {
      return (data as List).map((e) => deserialize<_i19.Product>(e)).toList()
          as T;
    }
    if (t == List<_i20.OrderHistory>) {
      return (data as List)
              .map((e) => deserialize<_i20.OrderHistory>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.Brand>) {
      return (data as List).map((e) => deserialize<_i21.Brand>(e)).toList()
          as T;
    }
    if (t == List<_i22.Category>) {
      return (data as List).map((e) => deserialize<_i22.Category>(e)).toList()
          as T;
    }
    if (t == List<_i23.Purchase>) {
      return (data as List).map((e) => deserialize<_i23.Purchase>(e)).toList()
          as T;
    }
    if (t == List<_i24.PurchaseItem>) {
      return (data as List)
              .map((e) => deserialize<_i24.PurchaseItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.Orders>) {
      return (data as List).map((e) => deserialize<_i25.Orders>(e)).toList()
          as T;
    }
    try {
      return _i26.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i27.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AccountsReportEntry => 'AccountsReportEntry',
      _i3.MonthDetailReport => 'MonthDetailReport',
      _i4.Expense => 'Expense',
      _i5.Income => 'Income',
      _i6.Brand => 'Brand',
      _i7.Category => 'Category',
      _i8.Product => 'Product',
      _i9.Purchase => 'Purchase',
      _i10.PurchaseItem => 'PurchaseItem',
      _i11.Supplier => 'Supplier',
      _i12.Orders => 'Orders',
      _i13.OrderHistory => 'OrderHistory',
      _i14.Profile => 'Profile',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'lekhsmi_computers.',
        '',
      );
    }

    switch (data) {
      case _i2.AccountsReportEntry():
        return 'AccountsReportEntry';
      case _i3.MonthDetailReport():
        return 'MonthDetailReport';
      case _i4.Expense():
        return 'Expense';
      case _i5.Income():
        return 'Income';
      case _i6.Brand():
        return 'Brand';
      case _i7.Category():
        return 'Category';
      case _i8.Product():
        return 'Product';
      case _i9.Purchase():
        return 'Purchase';
      case _i10.PurchaseItem():
        return 'PurchaseItem';
      case _i11.Supplier():
        return 'Supplier';
      case _i12.Orders():
        return 'Orders';
      case _i13.OrderHistory():
        return 'OrderHistory';
      case _i14.Profile():
        return 'Profile';
    }
    className = _i26.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i27.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AccountsReportEntry') {
      return deserialize<_i2.AccountsReportEntry>(data['data']);
    }
    if (dataClassName == 'MonthDetailReport') {
      return deserialize<_i3.MonthDetailReport>(data['data']);
    }
    if (dataClassName == 'Expense') {
      return deserialize<_i4.Expense>(data['data']);
    }
    if (dataClassName == 'Income') {
      return deserialize<_i5.Income>(data['data']);
    }
    if (dataClassName == 'Brand') {
      return deserialize<_i6.Brand>(data['data']);
    }
    if (dataClassName == 'Category') {
      return deserialize<_i7.Category>(data['data']);
    }
    if (dataClassName == 'Product') {
      return deserialize<_i8.Product>(data['data']);
    }
    if (dataClassName == 'Purchase') {
      return deserialize<_i9.Purchase>(data['data']);
    }
    if (dataClassName == 'PurchaseItem') {
      return deserialize<_i10.PurchaseItem>(data['data']);
    }
    if (dataClassName == 'Supplier') {
      return deserialize<_i11.Supplier>(data['data']);
    }
    if (dataClassName == 'Orders') {
      return deserialize<_i12.Orders>(data['data']);
    }
    if (dataClassName == 'OrderHistory') {
      return deserialize<_i13.OrderHistory>(data['data']);
    }
    if (dataClassName == 'Profile') {
      return deserialize<_i14.Profile>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i26.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i27.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i26.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i27.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
