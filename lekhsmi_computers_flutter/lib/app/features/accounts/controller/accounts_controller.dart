import 'package:get/get.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';

class AccountsController extends GetxController {
  final Client _client = Get.find<Client>();

  final incomes = <Income>[].obs;
  final expenses = <Expense>[].obs;
  final isLoading = false.obs;

  int get totalIncome => incomes.fold(0, (sum, i) => sum + i.amount);
  int get totalExpense => expenses.fold(0, (sum, e) => sum + e.amount);
  int get netBalance => totalIncome - totalExpense;

  String get currentMonthName {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    final now = DateTime.now();
    return '${months[now.month - 1]} ${now.year}';
  }

  final annualReportList = <MonthlyReportItem>[].obs;
  final allIncomes = <Income>[].obs;
  final allExpenses = <Expense>[].obs;

  final selectedReportYear = DateTime.now().year.obs;
  final availableYears = <int>[].obs;

  int get ytdTotalIncome => annualReportList.fold(0, (sum, i) => sum + i.income);
  int get ytdTotalExpense => annualReportList.fold(0, (sum, e) => sum + e.expense);
  int get ytdNetProfit => ytdTotalIncome - ytdTotalExpense;

  @override
  void onInit() {
    super.onInit();
    fetchAccounts();
    fetchAnnualReport();
  }

  Future<void> fetchAccounts() async {
    try {
      isLoading.value = true;
      final res = await Future.wait([
        _client.income.getAllIncomes(),
        _client.expense.getAllExpenses(),
      ]);

      final incListAll = res[0] as List<Income>;
      final expListAll = res[1] as List<Expense>;

      allIncomes.assignAll(incListAll);
      allExpenses.assignAll(expListAll);

      final now = DateTime.now();
      final incList = incListAll
          .where((i) => i.date.year == now.year && i.date.month == now.month)
          .toList();
      final expList = expListAll
          .where((e) => e.date.year == now.year && e.date.month == now.month)
          .toList();

      // Sort newest insertion first
      incList.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
      expList.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));

      incomes.assignAll(incList);
      expenses.assignAll(expList);
    } catch (e) {
      AppNotification.error('Error', 'Failed to load accounting data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  final Map<int, AccountsReportEntry> _reportLookup = {};

  Future<void> fetchAnnualReport() async {
    try {
      final res = await _client.accountsReport.getMonthlyReport();

      _reportLookup.clear();
      const monthNames = ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december'];

      int minYear = DateTime.now().year;

      for (final e in res) {
        final parts = e.date.split(',');
        if (parts.length == 2) {
          final mStr = parts[0].trim().toLowerCase();
          final yStr = parts[1].trim();
          final mIdx = monthNames.indexOf(mStr) + 1;
          final yVal = int.tryParse(yStr) ?? 0;
          if (mIdx > 0 && yVal > 0) {
            _reportLookup[yVal * 100 + mIdx] = e;
            if (yVal < minYear) minYear = yVal;
          }
        }
      }

      for (final i in allIncomes) {
        if (i.date.year < minYear) minYear = i.date.year;
      }
      for (final e in allExpenses) {
        if (e.date.year < minYear) minYear = e.date.year;
      }

      final nowYear = DateTime.now().year;
      if (minYear > nowYear) minYear = nowYear;

      final List<int> years = [];
      for (int y = nowYear; y >= minYear; y--) {
        years.add(y);
      }
      if (years.isEmpty) years.add(nowYear);
      availableYears.assignAll(years);

      if (!availableYears.contains(selectedReportYear.value)) {
        selectedReportYear.value = nowYear;
      }

      _rebuildAnnualReportList();
    } catch (e) {
      AppNotification.error('Error', 'Failed to load annual accounts report: $e');
    }
  }

  void changeReportYear(int newYear) {
    selectedReportYear.value = newYear;
    _rebuildAnnualReportList();
  }

  void _rebuildAnnualReportList() {
    const capitalMonthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    final now = DateTime.now();
    final targetYear = selectedReportYear.value;
    final currentYear = now.year;
    final currentMonth = now.month;

    int getInc(int y, int m) => _reportLookup[y * 100 + m]?.income ?? 0;
    int getExp(int y, int m) => _reportLookup[y * 100 + m]?.expense ?? 0;
    int getProf(int y, int m) => getInc(y, m) - getExp(y, m);

    PercentageResult calcChange(int current, int previous, {required bool isFuture}) {
      if (isFuture) {
        return PercentageResult('—', isIncrease: false, isZero: true, isFuture: true);
      }
      if (previous == 0) {
        if (current == 0) return PercentageResult('0.0%', isIncrease: false, isZero: true, isFuture: false);
        return PercentageResult(current > 0 ? '+100.0%' : '-100.0%', isIncrease: current > 0, isZero: false, isFuture: false);
      }
      final double change = ((current - previous) / previous.abs()) * 100.0;
      final bool isInc = change > 0;
      final bool isZ = change == 0.0;
      final String sign = isInc ? '+' : '';
      return PercentageResult('$sign${change.toStringAsFixed(1)}%', isIncrease: isInc, isZero: isZ, isFuture: false);
    }

    final List<MonthlyReportItem> list = [];
    final int maxMonth = (targetYear == currentYear)
        ? currentMonth
        : (targetYear > currentYear ? 0 : 12);

    for (int m = maxMonth; m >= 1; m--) {
      final inc = getInc(targetYear, m);
      final exp = getExp(targetYear, m);
      final prof = getProf(targetYear, m);

      final int prevY = (m == 1) ? targetYear - 1 : targetYear;
      final int prevM = (m == 1) ? 12 : m - 1;

      final pInc = getInc(prevY, prevM);
      final pExp = getExp(prevY, prevM);
      final pProf = getProf(prevY, prevM);

      final bool isFuture = (targetYear > currentYear) || (targetYear == currentYear && m > currentMonth);

      list.add(
        MonthlyReportItem(
          year: targetYear,
          monthNumber: m,
          monthName: '${capitalMonthNames[m - 1]} $targetYear',
          income: inc,
          expense: exp,
          netProfit: prof,
          incomeChange: calcChange(inc, pInc, isFuture: isFuture),
          expenseChange: calcChange(exp, pExp, isFuture: isFuture),
          profitChange: calcChange(prof, pProf, isFuture: isFuture),
          isCurrentMonth: (targetYear == currentYear && m == currentMonth),
          isFutureMonth: isFuture,
        ),
      );
    }

    annualReportList.assignAll(list);
  }

  List<Income> getIncomesForMonth(int year, int month) {
    return allIncomes
        .where((i) => i.date.year == year && i.date.month == month)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<Expense> getExpensesForMonth(int year, int month) {
    return allExpenses
        .where((e) => e.date.year == year && e.date.month == month)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<bool> addEntry({
    required String type,
    required int amount,
    required DateTime date,
    required String reason,
  }) async {
    try {
      if (type == 'Income') {
        final item = Income(
          amount: amount,
          date: date,
          reason: reason,
        );
        await _client.income.addNewIncome(item);
      } else {
        final item = Expense(
          amount: amount,
          date: date,
          reason: reason,
        );
        await _client.expense.addNewExpense(item);
      }

      await fetchAccounts();
      await fetchAnnualReport();
      return true;
    } catch (e) {
      AppNotification.error('Error', 'Failed to save record: $e');
      return false;
    }
  }

  Future<void> deleteIncome(Income income) async {
    try {
      await _client.income.deleteExistingIncome(income);
      await fetchAccounts();
      await fetchAnnualReport();
    } catch (e) {
      AppNotification.error('Error', 'Failed to delete income: $e');
    }
  }

  Future<void> deleteExpense(Expense expense) async {
    try {
      await _client.expense.deleteExistingExpense(expense);
      await fetchAccounts();
      await fetchAnnualReport();
    } catch (e) {
      AppNotification.error('Error', 'Failed to delete expense: $e');
    }
  }
}

class PercentageResult {
  final String text;
  final bool isIncrease;
  final bool isZero;
  final bool isFuture;

  PercentageResult(
    this.text, {
    required this.isIncrease,
    required this.isZero,
    this.isFuture = false,
  });
}

class MonthlyReportItem {
  final int year;
  final int monthNumber;
  final String monthName;
  final int income;
  final int expense;
  final int netProfit;
  final PercentageResult incomeChange;
  final PercentageResult expenseChange;
  final PercentageResult profitChange;
  final bool isCurrentMonth;
  final bool isFutureMonth;

  MonthlyReportItem({
    required this.year,
    required this.monthNumber,
    required this.monthName,
    required this.income,
    required this.expense,
    required this.netProfit,
    required this.incomeChange,
    required this.expenseChange,
    required this.profitChange,
    required this.isCurrentMonth,
    required this.isFutureMonth,
  });
}
