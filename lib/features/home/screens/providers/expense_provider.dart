import 'package:expense_note/features/home/domain/providers/expense_usecase_provider.dart' show expenseUsecaseProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/expense_model.dart';
import '../../domain/usecases/expense_usecase.dart';
import 'expense_provider_state.dart';

final expenseProvider = ExpenseProvider((){
  return ExpenseNotifier();
});

typedef ExpenseProvider = NotifierProvider<ExpenseNotifier,ExpenseProviderState>;
class ExpenseNotifier extends Notifier<ExpenseProviderState>{
  ExpenseUsecase get expenseUsecase => ref.read(expenseUsecaseProvider);
  @override
  build() {
    return ExpenseIdleState();
  }
  Future<void> getAllExpense()async{
    try {
      state = ExpenseLoadingState();
      List<ExpenseModel> expenseList = await expenseUsecase.getAllExpense();
      double totalAmount = await expenseUsecase.getTotalExpenseAmount();
      state = ExpenseSuccessState(expenseList: expenseList, totalAmount: totalAmount);
    } catch (e) {
      String errorMessage = e.toString().replaceAll("Exception ", "");
      state = ExpenseErrorState(errorMessage: errorMessage);
    }
  }

  Future<void> deleteExpense(int id) async{
    try {
      // state = ExpenseLoadingState();
      await expenseUsecase.deleteExpense(id);
      List<ExpenseModel> expenseList = await expenseUsecase.getAllExpense();
      double totalAmount = await expenseUsecase.getTotalExpenseAmount();
      state = ExpenseSuccessState(expenseList: expenseList, totalAmount: totalAmount);
    } catch (e) {
      String errorMessage = e.toString().replaceAll("Exception ", "");
      state = ExpenseErrorState(errorMessage: errorMessage);
    }
  }
}

final expenseFormProvider = ExpenseFormProvider(() {
  return ExpenseFormNotifier();
},);
typedef ExpenseFormProvider = NotifierProvider<ExpenseFormNotifier,ExpenseFormProviderState>;
class ExpenseFormNotifier extends Notifier<ExpenseFormProviderState>{
  ExpenseUsecase get expenseUsecase => ref.read(expenseUsecaseProvider);
  @override
  build() {
    return ExpenseFormState();
  }
  Future<void> saveExpense(ExpenseModel expense)async{
    try {
      state = ExpenseFormLoadingState();
      debugPrint("expense data => ${expense.toJson()}");
      await expenseUsecase.saveExpense(expense);
      await Future.delayed(Duration(seconds: 1));
      state = ExpenseFormSuccessState(successMessage: "Successfully Added");
    } catch (e) {
      String errorMessage = e.toString().replaceAll("Exception ", "");
      state = ExpenseFormErrorState(errorMessage: errorMessage);
    }
  }

    Future<void> editExpense(int id, ExpenseModel expense) async{
    try {
      state = ExpenseFormLoadingState();
      await expenseUsecase.editExpense(id, expense);
      state = ExpenseFormSuccessState(successMessage: "Edit Successful");
    } catch (e) {
      String errorMessage = e.toString().replaceAll("Exception ", "");
      state = ExpenseFormErrorState(errorMessage: errorMessage);
    }
  }
}