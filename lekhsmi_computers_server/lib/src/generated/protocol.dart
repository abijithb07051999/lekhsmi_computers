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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'features/accounts/accounts_report/accounts_report.dart' as _i5;
import 'features/accounts/accounts_report/month_report.dart' as _i6;
import 'features/accounts/expense/expense.dart' as _i7;
import 'features/accounts/income/income.dart' as _i8;
import 'features/inventory/brands/brand.dart' as _i9;
import 'features/inventory/categories/category.dart' as _i10;
import 'features/inventory/products/product.dart' as _i11;
import 'features/inventory/purchase/purchase.dart' as _i12;
import 'features/inventory/purchase/purchase_item.dart' as _i13;
import 'features/inventory/suppliers/supplier.dart' as _i14;
import 'features/orders/order.dart' as _i15;
import 'features/orders/order_history.dart' as _i16;
import 'features/profile/profile.dart' as _i17;
import 'package:lekhsmi_computers_server/src/generated/features/accounts/accounts_report/accounts_report.dart'
    as _i18;
import 'package:lekhsmi_computers_server/src/generated/features/accounts/expense/expense.dart'
    as _i19;
import 'package:lekhsmi_computers_server/src/generated/features/accounts/income/income.dart'
    as _i20;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/suppliers/supplier.dart'
    as _i21;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/products/product.dart'
    as _i22;
import 'package:lekhsmi_computers_server/src/generated/features/orders/order_history.dart'
    as _i23;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/brands/brand.dart'
    as _i24;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/categories/category.dart'
    as _i25;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/purchase/purchase.dart'
    as _i26;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/purchase/purchase_item.dart'
    as _i27;
import 'package:lekhsmi_computers_server/src/generated/features/orders/order.dart'
    as _i28;
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

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'brand',
      dartName: 'Brand',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'brand_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'brand_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'category',
      dartName: 'Category',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'category_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'category_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'expense',
      dartName: 'Expense',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'expense_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'expense_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'income',
      dartName: 'Income',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'income_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'income_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'orderhistory',
      dartName: 'OrderHistory',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'orderhistory_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'order',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:Orders',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'orderhistory_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'orders',
      dartName: 'Orders',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'orders_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'orderId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'customerName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'contact1',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'contact2',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'address',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'complaints',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'orders_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'product',
      dartName: 'Product',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'product_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'brandId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'quality',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'buyPrice',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sellPrice',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'product_fk_0',
          columns: ['categoryId'],
          referenceTable: 'category',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'product_fk_1',
          columns: ['brandId'],
          referenceTable: 'brand',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'product_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'profile',
      dartName: 'Profile',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'profile_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'storeName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'website',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'address',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'profile_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'purchase',
      dartName: 'Purchase',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'purchase_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'invoiceNo',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'supplierId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'totalAmount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'paidAmount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'dueAmount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'paymentStatus',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'purchase_fk_0',
          columns: ['supplierId'],
          referenceTable: 'supplier',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'purchase_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'purchase_item',
      dartName: 'PurchaseItem',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'purchase_item_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'purchaseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'unitPrice',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'purchase_item_fk_0',
          columns: ['purchaseId'],
          referenceTable: 'purchase',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'purchase_item_fk_1',
          columns: ['productId'],
          referenceTable: 'product',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'purchase_item_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'supplier',
      dartName: 'Supplier',
      schema: 'public',
      module: 'lekhsmi_computers',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'supplier_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'address',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'contact1',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'contact2',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'supplier_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

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

    if (t == _i5.AccountsReportEntry) {
      return _i5.AccountsReportEntry.fromJson(data) as T;
    }
    if (t == _i6.MonthDetailReport) {
      return _i6.MonthDetailReport.fromJson(data) as T;
    }
    if (t == _i7.Expense) {
      return _i7.Expense.fromJson(data) as T;
    }
    if (t == _i8.Income) {
      return _i8.Income.fromJson(data) as T;
    }
    if (t == _i9.Brand) {
      return _i9.Brand.fromJson(data) as T;
    }
    if (t == _i10.Category) {
      return _i10.Category.fromJson(data) as T;
    }
    if (t == _i11.Product) {
      return _i11.Product.fromJson(data) as T;
    }
    if (t == _i12.Purchase) {
      return _i12.Purchase.fromJson(data) as T;
    }
    if (t == _i13.PurchaseItem) {
      return _i13.PurchaseItem.fromJson(data) as T;
    }
    if (t == _i14.Supplier) {
      return _i14.Supplier.fromJson(data) as T;
    }
    if (t == _i15.Orders) {
      return _i15.Orders.fromJson(data) as T;
    }
    if (t == _i16.OrderHistory) {
      return _i16.OrderHistory.fromJson(data) as T;
    }
    if (t == _i17.Profile) {
      return _i17.Profile.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AccountsReportEntry?>()) {
      return (data != null ? _i5.AccountsReportEntry.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.MonthDetailReport?>()) {
      return (data != null ? _i6.MonthDetailReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Expense?>()) {
      return (data != null ? _i7.Expense.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Income?>()) {
      return (data != null ? _i8.Income.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Brand?>()) {
      return (data != null ? _i9.Brand.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Category?>()) {
      return (data != null ? _i10.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Product?>()) {
      return (data != null ? _i11.Product.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Purchase?>()) {
      return (data != null ? _i12.Purchase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.PurchaseItem?>()) {
      return (data != null ? _i13.PurchaseItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Supplier?>()) {
      return (data != null ? _i14.Supplier.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Orders?>()) {
      return (data != null ? _i15.Orders.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.OrderHistory?>()) {
      return (data != null ? _i16.OrderHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Profile?>()) {
      return (data != null ? _i17.Profile.fromJson(data) : null) as T;
    }
    if (t == List<_i8.Income>) {
      return (data as List).map((e) => deserialize<_i8.Income>(e)).toList()
          as T;
    }
    if (t == List<_i7.Expense>) {
      return (data as List).map((e) => deserialize<_i7.Expense>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i18.AccountsReportEntry>) {
      return (data as List)
              .map((e) => deserialize<_i18.AccountsReportEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.Expense>) {
      return (data as List).map((e) => deserialize<_i19.Expense>(e)).toList()
          as T;
    }
    if (t == List<_i20.Income>) {
      return (data as List).map((e) => deserialize<_i20.Income>(e)).toList()
          as T;
    }
    if (t == List<_i21.Supplier>) {
      return (data as List).map((e) => deserialize<_i21.Supplier>(e)).toList()
          as T;
    }
    if (t == List<_i22.Product>) {
      return (data as List).map((e) => deserialize<_i22.Product>(e)).toList()
          as T;
    }
    if (t == List<_i23.OrderHistory>) {
      return (data as List)
              .map((e) => deserialize<_i23.OrderHistory>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.Brand>) {
      return (data as List).map((e) => deserialize<_i24.Brand>(e)).toList()
          as T;
    }
    if (t == List<_i25.Category>) {
      return (data as List).map((e) => deserialize<_i25.Category>(e)).toList()
          as T;
    }
    if (t == List<_i26.Purchase>) {
      return (data as List).map((e) => deserialize<_i26.Purchase>(e)).toList()
          as T;
    }
    if (t == List<_i27.PurchaseItem>) {
      return (data as List)
              .map((e) => deserialize<_i27.PurchaseItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.Orders>) {
      return (data as List).map((e) => deserialize<_i28.Orders>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AccountsReportEntry => 'AccountsReportEntry',
      _i6.MonthDetailReport => 'MonthDetailReport',
      _i7.Expense => 'Expense',
      _i8.Income => 'Income',
      _i9.Brand => 'Brand',
      _i10.Category => 'Category',
      _i11.Product => 'Product',
      _i12.Purchase => 'Purchase',
      _i13.PurchaseItem => 'PurchaseItem',
      _i14.Supplier => 'Supplier',
      _i15.Orders => 'Orders',
      _i16.OrderHistory => 'OrderHistory',
      _i17.Profile => 'Profile',
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
      case _i5.AccountsReportEntry():
        return 'AccountsReportEntry';
      case _i6.MonthDetailReport():
        return 'MonthDetailReport';
      case _i7.Expense():
        return 'Expense';
      case _i8.Income():
        return 'Income';
      case _i9.Brand():
        return 'Brand';
      case _i10.Category():
        return 'Category';
      case _i11.Product():
        return 'Product';
      case _i12.Purchase():
        return 'Purchase';
      case _i13.PurchaseItem():
        return 'PurchaseItem';
      case _i14.Supplier():
        return 'Supplier';
      case _i15.Orders():
        return 'Orders';
      case _i16.OrderHistory():
        return 'OrderHistory';
      case _i17.Profile():
        return 'Profile';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
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
      return deserialize<_i5.AccountsReportEntry>(data['data']);
    }
    if (dataClassName == 'MonthDetailReport') {
      return deserialize<_i6.MonthDetailReport>(data['data']);
    }
    if (dataClassName == 'Expense') {
      return deserialize<_i7.Expense>(data['data']);
    }
    if (dataClassName == 'Income') {
      return deserialize<_i8.Income>(data['data']);
    }
    if (dataClassName == 'Brand') {
      return deserialize<_i9.Brand>(data['data']);
    }
    if (dataClassName == 'Category') {
      return deserialize<_i10.Category>(data['data']);
    }
    if (dataClassName == 'Product') {
      return deserialize<_i11.Product>(data['data']);
    }
    if (dataClassName == 'Purchase') {
      return deserialize<_i12.Purchase>(data['data']);
    }
    if (dataClassName == 'PurchaseItem') {
      return deserialize<_i13.PurchaseItem>(data['data']);
    }
    if (dataClassName == 'Supplier') {
      return deserialize<_i14.Supplier>(data['data']);
    }
    if (dataClassName == 'Orders') {
      return deserialize<_i15.Orders>(data['data']);
    }
    if (dataClassName == 'OrderHistory') {
      return deserialize<_i16.OrderHistory>(data['data']);
    }
    if (dataClassName == 'Profile') {
      return deserialize<_i17.Profile>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i7.Expense:
        return _i7.Expense.t;
      case _i8.Income:
        return _i8.Income.t;
      case _i9.Brand:
        return _i9.Brand.t;
      case _i10.Category:
        return _i10.Category.t;
      case _i11.Product:
        return _i11.Product.t;
      case _i12.Purchase:
        return _i12.Purchase.t;
      case _i13.PurchaseItem:
        return _i13.PurchaseItem.t;
      case _i14.Supplier:
        return _i14.Supplier.t;
      case _i15.Orders:
        return _i15.Orders.t;
      case _i16.OrderHistory:
        return _i16.OrderHistory.t;
      case _i17.Profile:
        return _i17.Profile.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'lekhsmi_computers';

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
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
