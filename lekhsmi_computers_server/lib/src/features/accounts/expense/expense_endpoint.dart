import 'package:serverpod/serverpod.dart';

import 'package:lekhsmi_computers_server/src/generated/features/accounts/expense/expense.dart';

class ExpenseEndpoint extends Endpoint {
  Future<List<Expense>> getAllExpenses(Session session) async {
    return await Expense.db.find(session);
  }

  Future<List<Expense>> getExpensesByDate(
    Session session,
    DateTime date,
  ) async {
    return await Expense.db.find(
      session,
      where: (t) => t.date.equals(DateTime(date.year, date.month, date.day)),
    );
  }

  Future<Expense> addNewExpense(Session session, Expense expense) async {
    return await Expense.db.insertRow(session, expense);
  }

  Future<Expense> updateExistingExpense(Session session, Expense expense) async {
    return await Expense.db.updateRow(session, expense);
  }

  Future<Expense> deleteExistingExpense(Session session, Expense expense) async {
    return await Expense.db.deleteRow(session, expense);
  }
}