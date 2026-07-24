import 'package:serverpod/serverpod.dart';

import 'package:lekhsmi_computers_server/src/generated/features/accounts/income/income.dart';

class IncomeEndpoint extends Endpoint{
  Future<List<Income>> getAllIncomes(Session session) async {
    return await Income.db.find(session);
  }

  Future<List<Income>> getIncomesByDate(
    Session session, 
    DateTime date
  ) async {
    return await Income.db.find(
      session,
      where: (t) => t.date.equals(DateTime(date.year, date.month, date.day)),
    );
  }

  Future<Income> addNewIncome(Session session, Income income) async {
    return await Income.db.insertRow(session, income);
  }

  Future<Income> updateExistingIncome(Session session, Income income) async {
    return await Income.db.updateRow(session, income);
  }

  Future<Income> deleteExistingIncome(Session session, Income income) async {
    return await Income.db.deleteRow(session, income);
  }
}