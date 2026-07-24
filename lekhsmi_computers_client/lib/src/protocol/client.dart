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
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:lekhsmi_computers_client/src/protocol/features/accounts/accounts_report/accounts_report.dart'
    as _i5;
import 'package:lekhsmi_computers_client/src/protocol/features/accounts/accounts_report/month_report.dart'
    as _i6;
import 'package:lekhsmi_computers_client/src/protocol/features/accounts/expense/expense.dart'
    as _i7;
import 'package:lekhsmi_computers_client/src/protocol/features/accounts/income/income.dart'
    as _i8;
import 'package:lekhsmi_computers_client/src/protocol/features/inventory/suppliers/supplier.dart'
    as _i9;
import 'package:lekhsmi_computers_client/src/protocol/features/inventory/products/product.dart'
    as _i10;
import 'package:lekhsmi_computers_client/src/protocol/features/orders/order_history.dart'
    as _i11;
import 'package:lekhsmi_computers_client/src/protocol/features/inventory/brands/brand.dart'
    as _i12;
import 'package:lekhsmi_computers_client/src/protocol/features/inventory/categories/category.dart'
    as _i13;
import 'package:lekhsmi_computers_client/src/protocol/features/orders/order.dart'
    as _i14;
import 'protocol.dart' as _i15;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointAccountsReport extends _i2.EndpointRef {
  EndpointAccountsReport(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'accountsReport';

  _i3.Future<List<_i5.AccountsReportEntry>> getMonthlyReport() =>
      caller.callServerEndpoint<List<_i5.AccountsReportEntry>>(
        'accountsReport',
        'getMonthlyReport',
        {},
      );

  _i3.Future<_i6.MonthDetailReport> getMonthDetail({
    required int year,
    required int month,
  }) => caller.callServerEndpoint<_i6.MonthDetailReport>(
    'accountsReport',
    'getMonthDetail',
    {
      'year': year,
      'month': month,
    },
  );
}

/// {@category Endpoint}
class EndpointExpense extends _i2.EndpointRef {
  EndpointExpense(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'expense';

  _i3.Future<List<_i7.Expense>> getAllExpenses() =>
      caller.callServerEndpoint<List<_i7.Expense>>(
        'expense',
        'getAllExpenses',
        {},
      );

  _i3.Future<List<_i7.Expense>> getExpensesByDate(DateTime date) =>
      caller.callServerEndpoint<List<_i7.Expense>>(
        'expense',
        'getExpensesByDate',
        {'date': date},
      );

  _i3.Future<_i7.Expense> addNewExpense(_i7.Expense expense) =>
      caller.callServerEndpoint<_i7.Expense>(
        'expense',
        'addNewExpense',
        {'expense': expense},
      );

  _i3.Future<_i7.Expense> updateExistingExpense(_i7.Expense expense) =>
      caller.callServerEndpoint<_i7.Expense>(
        'expense',
        'updateExistingExpense',
        {'expense': expense},
      );

  _i3.Future<_i7.Expense> deleteExistingExpense(_i7.Expense expense) =>
      caller.callServerEndpoint<_i7.Expense>(
        'expense',
        'deleteExistingExpense',
        {'expense': expense},
      );
}

/// {@category Endpoint}
class EndpointIncome extends _i2.EndpointRef {
  EndpointIncome(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'income';

  _i3.Future<List<_i8.Income>> getAllIncomes() =>
      caller.callServerEndpoint<List<_i8.Income>>(
        'income',
        'getAllIncomes',
        {},
      );

  _i3.Future<List<_i8.Income>> getIncomesByDate(DateTime date) =>
      caller.callServerEndpoint<List<_i8.Income>>(
        'income',
        'getIncomesByDate',
        {'date': date},
      );

  _i3.Future<_i8.Income> addNewIncome(_i8.Income income) =>
      caller.callServerEndpoint<_i8.Income>(
        'income',
        'addNewIncome',
        {'income': income},
      );

  _i3.Future<_i8.Income> updateExistingIncome(_i8.Income income) =>
      caller.callServerEndpoint<_i8.Income>(
        'income',
        'updateExistingIncome',
        {'income': income},
      );

  _i3.Future<_i8.Income> deleteExistingIncome(_i8.Income income) =>
      caller.callServerEndpoint<_i8.Income>(
        'income',
        'deleteExistingIncome',
        {'income': income},
      );
}

/// {@category Endpoint}
class EndpointDashboard extends _i2.EndpointRef {
  EndpointDashboard(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  _i3.Future<List<_i9.Supplier>> getFirstFiveSupplires() =>
      caller.callServerEndpoint<List<_i9.Supplier>>(
        'dashboard',
        'getFirstFiveSupplires',
        {},
      );

  _i3.Future<int> getTotalOfThisMonthIncome(DateTime date) =>
      caller.callServerEndpoint<int>(
        'dashboard',
        'getTotalOfThisMonthIncome',
        {'date': date},
      );

  _i3.Future<int> totalBrandCountrs() => caller.callServerEndpoint<int>(
    'dashboard',
    'totalBrandCountrs',
    {},
  );

  _i3.Future<int> totalSupplierCount() => caller.callServerEndpoint<int>(
    'dashboard',
    'totalSupplierCount',
    {},
  );

  _i3.Future<int> totalCategoryCount() => caller.callServerEndpoint<int>(
    'dashboard',
    'totalCategoryCount',
    {},
  );

  _i3.Future<List<_i10.Product>> getFirstFiveOutOfStockProduct() =>
      caller.callServerEndpoint<List<_i10.Product>>(
        'dashboard',
        'getFirstFiveOutOfStockProduct',
        {},
      );

  _i3.Future<List<_i11.OrderHistory>> getFirstFiveOrderHistory() =>
      caller.callServerEndpoint<List<_i11.OrderHistory>>(
        'dashboard',
        'getFirstFiveOrderHistory',
        {},
      );
}

/// {@category Endpoint}
class EndpointBrand extends _i2.EndpointRef {
  EndpointBrand(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'brand';

  _i3.Future<List<_i12.Brand>> getAllBrands() =>
      caller.callServerEndpoint<List<_i12.Brand>>(
        'brand',
        'getAllBrands',
        {},
      );

  _i3.Future<_i12.Brand> addNewBrand({required _i12.Brand brand}) =>
      caller.callServerEndpoint<_i12.Brand>(
        'brand',
        'addNewBrand',
        {'brand': brand},
      );

  _i3.Future<_i12.Brand> updateExistingBrand({required _i12.Brand brand}) =>
      caller.callServerEndpoint<_i12.Brand>(
        'brand',
        'updateExistingBrand',
        {'brand': brand},
      );

  _i3.Future<_i12.Brand> deteleExistingRow({required _i12.Brand brand}) =>
      caller.callServerEndpoint<_i12.Brand>(
        'brand',
        'deteleExistingRow',
        {'brand': brand},
      );
}

/// {@category Endpoint}
class EndpointCategory extends _i2.EndpointRef {
  EndpointCategory(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'category';

  _i3.Future<List<_i13.Category>> getAllCategories() =>
      caller.callServerEndpoint<List<_i13.Category>>(
        'category',
        'getAllCategories',
        {},
      );

  _i3.Future<_i13.Category> addNewCategory({required _i13.Category category}) =>
      caller.callServerEndpoint<_i13.Category>(
        'category',
        'addNewCategory',
        {'category': category},
      );

  _i3.Future<_i13.Category> updateExistingCategory({
    required _i13.Category category,
  }) => caller.callServerEndpoint<_i13.Category>(
    'category',
    'updateExistingCategory',
    {'category': category},
  );

  _i3.Future<_i13.Category> deleteExistingCategory({
    required _i13.Category category,
  }) => caller.callServerEndpoint<_i13.Category>(
    'category',
    'deleteExistingCategory',
    {'category': category},
  );
}

/// {@category Endpoint}
class EndpointProduct extends _i2.EndpointRef {
  EndpointProduct(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'product';

  _i3.Future<List<_i10.Product>> getAllProducts() =>
      caller.callServerEndpoint<List<_i10.Product>>(
        'product',
        'getAllProducts',
        {},
      );

  _i3.Future<_i10.Product> addNewProduct({required _i10.Product product}) =>
      caller.callServerEndpoint<_i10.Product>(
        'product',
        'addNewProduct',
        {'product': product},
      );

  _i3.Future<_i10.Product> updateExistingProduct({
    required _i10.Product product,
  }) => caller.callServerEndpoint<_i10.Product>(
    'product',
    'updateExistingProduct',
    {'product': product},
  );

  _i3.Future<_i10.Product> deleteExistingProduct({
    required _i10.Product product,
  }) => caller.callServerEndpoint<_i10.Product>(
    'product',
    'deleteExistingProduct',
    {'product': product},
  );
}

/// {@category Endpoint}
class EndpointSupplier extends _i2.EndpointRef {
  EndpointSupplier(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'supplier';

  _i3.Future<List<_i9.Supplier>> getAllSuppliers() =>
      caller.callServerEndpoint<List<_i9.Supplier>>(
        'supplier',
        'getAllSuppliers',
        {},
      );

  _i3.Future<_i9.Supplier> addNewSupplier({required _i9.Supplier supplier}) =>
      caller.callServerEndpoint<_i9.Supplier>(
        'supplier',
        'addNewSupplier',
        {'supplier': supplier},
      );

  _i3.Future<_i9.Supplier> updateExistingSupplier({
    required _i9.Supplier supplier,
  }) => caller.callServerEndpoint<_i9.Supplier>(
    'supplier',
    'updateExistingSupplier',
    {'supplier': supplier},
  );

  _i3.Future<_i9.Supplier> deleteExistingSupplier({
    required _i9.Supplier supplier,
  }) => caller.callServerEndpoint<_i9.Supplier>(
    'supplier',
    'deleteExistingSupplier',
    {'supplier': supplier},
  );
}

/// {@category Endpoint}
class EndpointOrder extends _i2.EndpointRef {
  EndpointOrder(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'order';

  _i3.Future<List<_i14.Orders>> getAllOrders() =>
      caller.callServerEndpoint<List<_i14.Orders>>(
        'order',
        'getAllOrders',
        {},
      );

  _i3.Future<_i14.Orders> addNewOrder({required _i14.Orders order}) =>
      caller.callServerEndpoint<_i14.Orders>(
        'order',
        'addNewOrder',
        {'order': order},
      );

  _i3.Future<_i14.Orders> updateExistingOrder({required _i14.Orders order}) =>
      caller.callServerEndpoint<_i14.Orders>(
        'order',
        'updateExistingOrder',
        {'order': order},
      );

  _i3.Future<_i14.Orders> deleteExistingOrder({required _i14.Orders order}) =>
      caller.callServerEndpoint<_i14.Orders>(
        'order',
        'deleteExistingOrder',
        {'order': order},
      );

  _i3.Future<List<_i11.OrderHistory>> getAllOrderStatus() =>
      caller.callServerEndpoint<List<_i11.OrderHistory>>(
        'order',
        'getAllOrderStatus',
        {},
      );

  _i3.Future<_i11.OrderHistory> addNewOrderStatus(
    _i11.OrderHistory orderHistory,
  ) => caller.callServerEndpoint<_i11.OrderHistory>(
    'order',
    'addNewOrderStatus',
    {'orderHistory': orderHistory},
  );

  _i3.Future<_i11.OrderHistory> deleteOrderStatus(
    _i11.OrderHistory orderHistory,
  ) => caller.callServerEndpoint<_i11.OrderHistory>(
    'order',
    'deleteOrderStatus',
    {'orderHistory': orderHistory},
  );

  _i3.Future<_i11.OrderHistory> updateOrderStatus(
    _i11.OrderHistory orderHistory,
  ) => caller.callServerEndpoint<_i11.OrderHistory>(
    'order',
    'updateOrderStatus',
    {'orderHistory': orderHistory},
  );

  _i3.Future<List<_i11.OrderHistory>> getAllOngoingAndPendingOrders() =>
      caller.callServerEndpoint<List<_i11.OrderHistory>>(
        'order',
        'getAllOngoingAndPendingOrders',
        {},
      );

  _i3.Future<List<_i11.OrderHistory>> getAllCompletedAndConcelledOrders() =>
      caller.callServerEndpoint<List<_i11.OrderHistory>>(
        'order',
        'getAllCompletedAndConcelledOrders',
        {},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i15.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    accountsReport = EndpointAccountsReport(this);
    expense = EndpointExpense(this);
    income = EndpointIncome(this);
    dashboard = EndpointDashboard(this);
    brand = EndpointBrand(this);
    category = EndpointCategory(this);
    product = EndpointProduct(this);
    supplier = EndpointSupplier(this);
    order = EndpointOrder(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAccountsReport accountsReport;

  late final EndpointExpense expense;

  late final EndpointIncome income;

  late final EndpointDashboard dashboard;

  late final EndpointBrand brand;

  late final EndpointCategory category;

  late final EndpointProduct product;

  late final EndpointSupplier supplier;

  late final EndpointOrder order;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'accountsReport': accountsReport,
    'expense': expense,
    'income': income,
    'dashboard': dashboard,
    'brand': brand,
    'category': category,
    'product': product,
    'supplier': supplier,
    'order': order,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
