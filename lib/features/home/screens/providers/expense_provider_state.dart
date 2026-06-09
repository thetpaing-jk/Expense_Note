import '../../data/models/expense_model.dart';

sealed class ExpenseProviderState {}

class ExpenseLoadingState extends ExpenseProviderState{}
class ExpenseIdleState extends ExpenseProviderState{}

class ExpenseSuccessState extends ExpenseProviderState{
  final List<ExpenseModel> expenseList;
  final double totalAmount;
  ExpenseSuccessState({
    required this.expenseList,
    required this.totalAmount,
  });
}

class ExpenseErrorState extends ExpenseProviderState{
  final String errorMessage;
  ExpenseErrorState({
    required this.errorMessage
  });
}

sealed class ExpenseFormProviderState{}

class ExpenseFormState extends ExpenseFormProviderState{}

class ExpenseFormLoadingState extends ExpenseFormProviderState{}

class ExpenseFormSuccessState extends ExpenseFormProviderState{
  final String successMessage;
  ExpenseFormSuccessState({
    required this.successMessage
  });
}

class ExpenseFormErrorState extends ExpenseFormProviderState{
  final String errorMessage;
  ExpenseFormErrorState({
    required this.errorMessage
  });
}
