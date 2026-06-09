import '../../data/models/expense_model.dart';

abstract class ExpenseRepository {
  Future<int> saveExpense(ExpenseModel expense);
  Future<int> deleteExpense(int id);
  Future<List<ExpenseModel>> getAllExpense();
  Future<double> getTotalExpenseAmount();
  Future<void> editExpense(int id, ExpenseModel expense);
}