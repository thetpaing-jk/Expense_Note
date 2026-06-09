import '../../data/models/expense_model.dart';
import '../repositories/expense_repository.dart';

class ExpenseUsecase {
  final ExpenseRepository repository;
  ExpenseUsecase({
    required this.repository
  });
  Future<int> saveExpense(ExpenseModel expense) async{
    return repository.saveExpense(expense);
  }

  Future<int> deleteExpense(int id) async{
    return repository.deleteExpense(id);
  }
  
  Future<List<ExpenseModel>> getAllExpense() async{
    return repository.getAllExpense();
  }
  
  Future<double> getTotalExpenseAmount() async{
    return repository.getTotalExpenseAmount();
  }

  Future<void> editExpense(int id, ExpenseModel expense) async{
    return repository.editExpense(id, expense);
  }
}