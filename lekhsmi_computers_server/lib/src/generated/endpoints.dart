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
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../features/accounts/accounts_report/accounts_report_endpoint.dart'
    as _i4;
import '../features/accounts/expense/expense_endpoint.dart' as _i5;
import '../features/accounts/income/income_endpoint.dart' as _i6;
import '../features/dashboard/dashboard_endpoint.dart' as _i7;
import '../features/inventory/brands/brand_endpoint.dart' as _i8;
import '../features/inventory/categories/category_endpoint.dart' as _i9;
import '../features/inventory/products/product_endpoint.dart' as _i10;
import '../features/inventory/purchase/purchase_endpoint.dart' as _i11;
import '../features/inventory/suppliers/supplier_endpoint.dart' as _i12;
import '../features/orders/order_endpoint.dart' as _i13;
import '../features/profile/profile_endpoint.dart' as _i14;
import 'package:lekhsmi_computers_server/src/generated/features/accounts/expense/expense.dart'
    as _i15;
import 'package:lekhsmi_computers_server/src/generated/features/accounts/income/income.dart'
    as _i16;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/brands/brand.dart'
    as _i17;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/categories/category.dart'
    as _i18;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/products/product.dart'
    as _i19;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/purchase/purchase.dart'
    as _i20;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/purchase/purchase_item.dart'
    as _i21;
import 'package:lekhsmi_computers_server/src/generated/features/inventory/suppliers/supplier.dart'
    as _i22;
import 'package:lekhsmi_computers_server/src/generated/features/orders/order.dart'
    as _i23;
import 'package:lekhsmi_computers_server/src/generated/features/orders/order_history.dart'
    as _i24;
import 'package:lekhsmi_computers_server/src/generated/features/profile/profile.dart'
    as _i25;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i26;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i27;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'accountsReport': _i4.AccountsReportEndpoint()
        ..initialize(
          server,
          'accountsReport',
          null,
        ),
      'expense': _i5.ExpenseEndpoint()
        ..initialize(
          server,
          'expense',
          null,
        ),
      'income': _i6.IncomeEndpoint()
        ..initialize(
          server,
          'income',
          null,
        ),
      'dashboard': _i7.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'brand': _i8.BrandEndpoint()
        ..initialize(
          server,
          'brand',
          null,
        ),
      'category': _i9.CategoryEndpoint()
        ..initialize(
          server,
          'category',
          null,
        ),
      'product': _i10.ProductEndpoint()
        ..initialize(
          server,
          'product',
          null,
        ),
      'purchase': _i11.PurchaseEndpoint()
        ..initialize(
          server,
          'purchase',
          null,
        ),
      'supplier': _i12.SupplierEndpoint()
        ..initialize(
          server,
          'supplier',
          null,
        ),
      'order': _i13.OrderEndpoint()
        ..initialize(
          server,
          'order',
          null,
        ),
      'profile': _i14.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['accountsReport'] = _i1.EndpointConnector(
      name: 'accountsReport',
      endpoint: endpoints['accountsReport']!,
      methodConnectors: {
        'getMonthlyReport': _i1.MethodConnector(
          name: 'getMonthlyReport',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accountsReport'] as _i4.AccountsReportEndpoint)
                      .getMonthlyReport(session),
        ),
        'getMonthDetail': _i1.MethodConnector(
          name: 'getMonthDetail',
          params: {
            'year': _i1.ParameterDescription(
              name: 'year',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'month': _i1.ParameterDescription(
              name: 'month',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accountsReport'] as _i4.AccountsReportEndpoint)
                      .getMonthDetail(
                        session,
                        year: params['year'],
                        month: params['month'],
                      ),
        ),
      },
    );
    connectors['expense'] = _i1.EndpointConnector(
      name: 'expense',
      endpoint: endpoints['expense']!,
      methodConnectors: {
        'getAllExpenses': _i1.MethodConnector(
          name: 'getAllExpenses',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['expense'] as _i5.ExpenseEndpoint)
                  .getAllExpenses(session),
        ),
        'getExpensesByDate': _i1.MethodConnector(
          name: 'getExpensesByDate',
          params: {
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['expense'] as _i5.ExpenseEndpoint)
                  .getExpensesByDate(
                    session,
                    params['date'],
                  ),
        ),
        'addNewExpense': _i1.MethodConnector(
          name: 'addNewExpense',
          params: {
            'expense': _i1.ParameterDescription(
              name: 'expense',
              type: _i1.getType<_i15.Expense>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['expense'] as _i5.ExpenseEndpoint).addNewExpense(
                    session,
                    params['expense'],
                  ),
        ),
        'updateExistingExpense': _i1.MethodConnector(
          name: 'updateExistingExpense',
          params: {
            'expense': _i1.ParameterDescription(
              name: 'expense',
              type: _i1.getType<_i15.Expense>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['expense'] as _i5.ExpenseEndpoint)
                  .updateExistingExpense(
                    session,
                    params['expense'],
                  ),
        ),
        'deleteExistingExpense': _i1.MethodConnector(
          name: 'deleteExistingExpense',
          params: {
            'expense': _i1.ParameterDescription(
              name: 'expense',
              type: _i1.getType<_i15.Expense>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['expense'] as _i5.ExpenseEndpoint)
                  .deleteExistingExpense(
                    session,
                    params['expense'],
                  ),
        ),
      },
    );
    connectors['income'] = _i1.EndpointConnector(
      name: 'income',
      endpoint: endpoints['income']!,
      methodConnectors: {
        'getAllIncomes': _i1.MethodConnector(
          name: 'getAllIncomes',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['income'] as _i6.IncomeEndpoint)
                  .getAllIncomes(session),
        ),
        'getIncomesByDate': _i1.MethodConnector(
          name: 'getIncomesByDate',
          params: {
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['income'] as _i6.IncomeEndpoint).getIncomesByDate(
                    session,
                    params['date'],
                  ),
        ),
        'addNewIncome': _i1.MethodConnector(
          name: 'addNewIncome',
          params: {
            'income': _i1.ParameterDescription(
              name: 'income',
              type: _i1.getType<_i16.Income>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['income'] as _i6.IncomeEndpoint).addNewIncome(
                    session,
                    params['income'],
                  ),
        ),
        'updateExistingIncome': _i1.MethodConnector(
          name: 'updateExistingIncome',
          params: {
            'income': _i1.ParameterDescription(
              name: 'income',
              type: _i1.getType<_i16.Income>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['income'] as _i6.IncomeEndpoint)
                  .updateExistingIncome(
                    session,
                    params['income'],
                  ),
        ),
        'deleteExistingIncome': _i1.MethodConnector(
          name: 'deleteExistingIncome',
          params: {
            'income': _i1.ParameterDescription(
              name: 'income',
              type: _i1.getType<_i16.Income>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['income'] as _i6.IncomeEndpoint)
                  .deleteExistingIncome(
                    session,
                    params['income'],
                  ),
        ),
      },
    );
    connectors['dashboard'] = _i1.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'getFirstFiveSupplires': _i1.MethodConnector(
          name: 'getFirstFiveSupplires',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getFirstFiveSupplires(session),
        ),
        'getTotalOfThisMonthIncome': _i1.MethodConnector(
          name: 'getTotalOfThisMonthIncome',
          params: {
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getTotalOfThisMonthIncome(
                    session,
                    params['date'],
                  ),
        ),
        'totalBrandCountrs': _i1.MethodConnector(
          name: 'totalBrandCountrs',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .totalBrandCountrs(session),
        ),
        'totalSupplierCount': _i1.MethodConnector(
          name: 'totalSupplierCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .totalSupplierCount(session),
        ),
        'totalCategoryCount': _i1.MethodConnector(
          name: 'totalCategoryCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .totalCategoryCount(session),
        ),
        'getFirstFiveOutOfStockProduct': _i1.MethodConnector(
          name: 'getFirstFiveOutOfStockProduct',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getFirstFiveOutOfStockProduct(session),
        ),
        'getFirstFiveLiveOrder': _i1.MethodConnector(
          name: 'getFirstFiveLiveOrder',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getFirstFiveLiveOrder(session),
        ),
      },
    );
    connectors['brand'] = _i1.EndpointConnector(
      name: 'brand',
      endpoint: endpoints['brand']!,
      methodConnectors: {
        'getAllBrands': _i1.MethodConnector(
          name: 'getAllBrands',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['brand'] as _i8.BrandEndpoint).getAllBrands(
                session,
              ),
        ),
        'addNewBrand': _i1.MethodConnector(
          name: 'addNewBrand',
          params: {
            'brand': _i1.ParameterDescription(
              name: 'brand',
              type: _i1.getType<_i17.Brand>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['brand'] as _i8.BrandEndpoint).addNewBrand(
                session,
                brand: params['brand'],
              ),
        ),
        'updateExistingBrand': _i1.MethodConnector(
          name: 'updateExistingBrand',
          params: {
            'brand': _i1.ParameterDescription(
              name: 'brand',
              type: _i1.getType<_i17.Brand>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['brand'] as _i8.BrandEndpoint).updateExistingBrand(
                    session,
                    brand: params['brand'],
                  ),
        ),
        'deteleExistingRow': _i1.MethodConnector(
          name: 'deteleExistingRow',
          params: {
            'brand': _i1.ParameterDescription(
              name: 'brand',
              type: _i1.getType<_i17.Brand>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['brand'] as _i8.BrandEndpoint).deteleExistingRow(
                    session,
                    brand: params['brand'],
                  ),
        ),
      },
    );
    connectors['category'] = _i1.EndpointConnector(
      name: 'category',
      endpoint: endpoints['category']!,
      methodConnectors: {
        'getAllCategories': _i1.MethodConnector(
          name: 'getAllCategories',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['category'] as _i9.CategoryEndpoint)
                  .getAllCategories(session),
        ),
        'addNewCategory': _i1.MethodConnector(
          name: 'addNewCategory',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i18.Category>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['category'] as _i9.CategoryEndpoint)
                  .addNewCategory(
                    session,
                    category: params['category'],
                  ),
        ),
        'updateExistingCategory': _i1.MethodConnector(
          name: 'updateExistingCategory',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i18.Category>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['category'] as _i9.CategoryEndpoint)
                  .updateExistingCategory(
                    session,
                    category: params['category'],
                  ),
        ),
        'deleteExistingCategory': _i1.MethodConnector(
          name: 'deleteExistingCategory',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i18.Category>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['category'] as _i9.CategoryEndpoint)
                  .deleteExistingCategory(
                    session,
                    category: params['category'],
                  ),
        ),
      },
    );
    connectors['product'] = _i1.EndpointConnector(
      name: 'product',
      endpoint: endpoints['product']!,
      methodConnectors: {
        'getAllProducts': _i1.MethodConnector(
          name: 'getAllProducts',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _i10.ProductEndpoint)
                  .getAllProducts(session),
        ),
        'addNewProduct': _i1.MethodConnector(
          name: 'addNewProduct',
          params: {
            'product': _i1.ParameterDescription(
              name: 'product',
              type: _i1.getType<_i19.Product>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['product'] as _i10.ProductEndpoint).addNewProduct(
                    session,
                    product: params['product'],
                  ),
        ),
        'updateExistingProduct': _i1.MethodConnector(
          name: 'updateExistingProduct',
          params: {
            'product': _i1.ParameterDescription(
              name: 'product',
              type: _i1.getType<_i19.Product>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _i10.ProductEndpoint)
                  .updateExistingProduct(
                    session,
                    product: params['product'],
                  ),
        ),
        'deleteExistingProduct': _i1.MethodConnector(
          name: 'deleteExistingProduct',
          params: {
            'product': _i1.ParameterDescription(
              name: 'product',
              type: _i1.getType<_i19.Product>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _i10.ProductEndpoint)
                  .deleteExistingProduct(
                    session,
                    product: params['product'],
                  ),
        ),
      },
    );
    connectors['purchase'] = _i1.EndpointConnector(
      name: 'purchase',
      endpoint: endpoints['purchase']!,
      methodConnectors: {
        'getAllPurchases': _i1.MethodConnector(
          name: 'getAllPurchases',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['purchase'] as _i11.PurchaseEndpoint)
                  .getAllPurchases(session),
        ),
        'getPurchaseItems': _i1.MethodConnector(
          name: 'getPurchaseItems',
          params: {
            'purchaseId': _i1.ParameterDescription(
              name: 'purchaseId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['purchase'] as _i11.PurchaseEndpoint)
                  .getPurchaseItems(
                    session,
                    purchaseId: params['purchaseId'],
                  ),
        ),
        'createPurchase': _i1.MethodConnector(
          name: 'createPurchase',
          params: {
            'purchase': _i1.ParameterDescription(
              name: 'purchase',
              type: _i1.getType<_i20.Purchase>(),
              nullable: false,
            ),
            'items': _i1.ParameterDescription(
              name: 'items',
              type: _i1.getType<List<_i21.PurchaseItem>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['purchase'] as _i11.PurchaseEndpoint)
                  .createPurchase(
                    session,
                    purchase: params['purchase'],
                    items: params['items'],
                  ),
        ),
        'updatePurchase': _i1.MethodConnector(
          name: 'updatePurchase',
          params: {
            'purchase': _i1.ParameterDescription(
              name: 'purchase',
              type: _i1.getType<_i20.Purchase>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['purchase'] as _i11.PurchaseEndpoint)
                  .updatePurchase(
                    session,
                    purchase: params['purchase'],
                  ),
        ),
        'deletePurchase': _i1.MethodConnector(
          name: 'deletePurchase',
          params: {
            'purchase': _i1.ParameterDescription(
              name: 'purchase',
              type: _i1.getType<_i20.Purchase>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['purchase'] as _i11.PurchaseEndpoint)
                  .deletePurchase(
                    session,
                    purchase: params['purchase'],
                  ),
        ),
      },
    );
    connectors['supplier'] = _i1.EndpointConnector(
      name: 'supplier',
      endpoint: endpoints['supplier']!,
      methodConnectors: {
        'getAllSuppliers': _i1.MethodConnector(
          name: 'getAllSuppliers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['supplier'] as _i12.SupplierEndpoint)
                  .getAllSuppliers(session),
        ),
        'addNewSupplier': _i1.MethodConnector(
          name: 'addNewSupplier',
          params: {
            'supplier': _i1.ParameterDescription(
              name: 'supplier',
              type: _i1.getType<_i22.Supplier>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['supplier'] as _i12.SupplierEndpoint)
                  .addNewSupplier(
                    session,
                    supplier: params['supplier'],
                  ),
        ),
        'updateExistingSupplier': _i1.MethodConnector(
          name: 'updateExistingSupplier',
          params: {
            'supplier': _i1.ParameterDescription(
              name: 'supplier',
              type: _i1.getType<_i22.Supplier>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['supplier'] as _i12.SupplierEndpoint)
                  .updateExistingSupplier(
                    session,
                    supplier: params['supplier'],
                  ),
        ),
        'deleteExistingSupplier': _i1.MethodConnector(
          name: 'deleteExistingSupplier',
          params: {
            'supplier': _i1.ParameterDescription(
              name: 'supplier',
              type: _i1.getType<_i22.Supplier>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['supplier'] as _i12.SupplierEndpoint)
                  .deleteExistingSupplier(
                    session,
                    supplier: params['supplier'],
                  ),
        ),
      },
    );
    connectors['order'] = _i1.EndpointConnector(
      name: 'order',
      endpoint: endpoints['order']!,
      methodConnectors: {
        'getAllOrders': _i1.MethodConnector(
          name: 'getAllOrders',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i13.OrderEndpoint)
                  .getAllOrders(session),
        ),
        'addNewOrder': _i1.MethodConnector(
          name: 'addNewOrder',
          params: {
            'order': _i1.ParameterDescription(
              name: 'order',
              type: _i1.getType<_i23.Orders>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i13.OrderEndpoint).addNewOrder(
                session,
                order: params['order'],
              ),
        ),
        'updateExistingOrder': _i1.MethodConnector(
          name: 'updateExistingOrder',
          params: {
            'order': _i1.ParameterDescription(
              name: 'order',
              type: _i1.getType<_i23.Orders>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i13.OrderEndpoint)
                  .updateExistingOrder(
                    session,
                    order: params['order'],
                  ),
        ),
        'deleteExistingOrder': _i1.MethodConnector(
          name: 'deleteExistingOrder',
          params: {
            'order': _i1.ParameterDescription(
              name: 'order',
              type: _i1.getType<_i23.Orders>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i13.OrderEndpoint)
                  .deleteExistingOrder(
                    session,
                    order: params['order'],
                  ),
        ),
        'getAllOrderStatus': _i1.MethodConnector(
          name: 'getAllOrderStatus',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i13.OrderEndpoint)
                  .getAllOrderStatus(session),
        ),
        'addNewOrderStatus': _i1.MethodConnector(
          name: 'addNewOrderStatus',
          params: {
            'orderHistory': _i1.ParameterDescription(
              name: 'orderHistory',
              type: _i1.getType<_i24.OrderHistory>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i13.OrderEndpoint).addNewOrderStatus(
                    session,
                    params['orderHistory'],
                  ),
        ),
        'deleteOrderStatus': _i1.MethodConnector(
          name: 'deleteOrderStatus',
          params: {
            'orderHistory': _i1.ParameterDescription(
              name: 'orderHistory',
              type: _i1.getType<_i24.OrderHistory>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i13.OrderEndpoint).deleteOrderStatus(
                    session,
                    params['orderHistory'],
                  ),
        ),
        'updateOrderStatus': _i1.MethodConnector(
          name: 'updateOrderStatus',
          params: {
            'orderHistory': _i1.ParameterDescription(
              name: 'orderHistory',
              type: _i1.getType<_i24.OrderHistory>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i13.OrderEndpoint).updateOrderStatus(
                    session,
                    params['orderHistory'],
                  ),
        ),
        'getAllOngoingAndPendingOrders': _i1.MethodConnector(
          name: 'getAllOngoingAndPendingOrders',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i13.OrderEndpoint)
                  .getAllOngoingAndPendingOrders(session),
        ),
        'getAllCompletedAndConcelledOrders': _i1.MethodConnector(
          name: 'getAllCompletedAndConcelledOrders',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i13.OrderEndpoint)
                  .getAllCompletedAndConcelledOrders(session),
        ),
      },
    );
    connectors['profile'] = _i1.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'getProfile': _i1.MethodConnector(
          name: 'getProfile',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i14.ProfileEndpoint)
                  .getProfile(session),
        ),
        'saveProfile': _i1.MethodConnector(
          name: 'saveProfile',
          params: {
            'profile': _i1.ParameterDescription(
              name: 'profile',
              type: _i1.getType<_i25.Profile>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['profile'] as _i14.ProfileEndpoint).saveProfile(
                    session,
                    profile: params['profile'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i26.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i27.Endpoints()
      ..initializeEndpoints(server);
  }
}
