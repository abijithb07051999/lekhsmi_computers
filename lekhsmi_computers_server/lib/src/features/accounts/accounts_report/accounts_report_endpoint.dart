import 'package:serverpod/serverpod.dart';
import 'package:lekhsmi_computers_server/src/generated/protocol.dart';

class AccountsReportEndpoint extends Endpoint {
  Future<List<AccountsReportEntry>> getMonthlyReport(Session session) async {
    final incomes = await Income.db.find(session);
    final expenses = await Expense.db.find(session);

    final Map<int, int> incomeByKey = {};
    final Map<int, int> expenseByKey = {};

    for (final income in incomes) {
      final key = income.date.year * 100 + income.date.month;
      incomeByKey[key] = (incomeByKey[key] ?? 0) + income.amount;
    }

    for (final expense in expenses) {
      final key = expense.date.year * 100 + expense.date.month;
      expenseByKey[key] = (expenseByKey[key] ?? 0) + expense.amount;
    }

    final allKeys = {...incomeByKey.keys, ...expenseByKey.keys}.toList()
      ..sort((a, b) => b.compareTo(a)); // most recent first

    return allKeys.map((key) {
      final year = key ~/ 100;
      final month = key % 100;
      final income = incomeByKey[key] ?? 0;
      final expense = expenseByKey[key] ?? 0;

      return AccountsReportEntry(
        date: '${_monthName(month)}, $year',
        income: income,
        expense: expense,
        profitLoss: income - expense,
      );
    }).toList();
  }

  String _monthName(int month) {
    const names = [
      'january', 'february', 'march', 'april', 'may', 'june',
      'july', 'august', 'september', 'october', 'november', 'december'
    ];
    return names[month - 1];
  }

  Future<MonthDetailReport> getMonthDetail(
  Session session, {
  required int year,
  required int month,
}) async {
  final startOfMonth = DateTime(year, month, 1);
  final startOfNextMonth = DateTime(year, month + 1, 1);

  final incomes = await Income.db.find(
    session,
    where: (t) => t.date.between(startOfMonth, startOfNextMonth),
    orderBy: (t) => t.date,
    orderDescending: true,
  );

  final expenses = await Expense.db.find(
    session,
    where: (t) => t.date.between(startOfMonth, startOfNextMonth),
    orderBy: (t) => t.date,
    orderDescending: true,
  );

  return MonthDetailReport(
    incomes: incomes,
    expenses: expenses,
  );
}  
}