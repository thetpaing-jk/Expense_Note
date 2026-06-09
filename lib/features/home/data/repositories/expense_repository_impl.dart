import 'package:expense_note/features/home/data/models/expense_model.dart';
import 'package:flutter/rendering.dart';

import '../../domain/repositories/expense_repository.dart';
import '../datasource/expense_local_datasource.dart';

class ExpenseRepositoryImpl extends ExpenseRepository{
  final ExpenseLocalDatasource expenseLocalDatasource;
  ExpenseRepositoryImpl({
    required this.expenseLocalDatasource
  });
  @override
  Future<int> deleteExpense(int id) async{
    try {
      int result = await expenseLocalDatasource.deleteExpense(id);
      return result;
    } catch (e) {
      debugPrint("Expense Repositroy Impl [delete expense] error : $e");
      throw Exception("$e");
    }
  }

  @override
  Future<List<ExpenseModel>> getAllExpense() async{
    try {
      List<ExpenseModel> expenseList = await expenseLocalDatasource.getAllExpense();
      return expenseList;
    } catch (e) {
      debugPrint("Expense Repositroy Impl [get all expense] error : $e");
      throw Exception("$e");
    }
  }

  @override
  Future<int> saveExpense(ExpenseModel expense) async{
    try {
      int result = await expenseLocalDatasource.saveExpense(expense);
      return result;
    } catch (e) {
      debugPrint("Expense Repositroy Impl [save expense] error : $e");
      throw Exception("$e");
    }
  }
  
  @override
  Future<double> getTotalExpenseAmount() async{
    try {
      double amountTotal = await expenseLocalDatasource.getTotalExpenseAmount();
      return amountTotal;
    } catch (e) {
      debugPrint("Expense Repositroy Impl [get total expense] error : $e");
      throw Exception("$e");
    }
  }
  
  @override
  Future<void> editExpense(int id, ExpenseModel expense) async{
    try {
      await expenseLocalDatasource.editExpense(id, expense);
    } catch (e) {
      debugPrint("Expense Repositroy Impl [edit expense] error : $e");
      throw Exception("$e");
    }
  }

}