import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/expense_data_provider.dart';
import '../usecases/expense_usecase.dart';

final expenseUsecaseProvider = Provider((ref){
  final repository = ref.read(expenseRepositoryProvider);
  return ExpenseUsecase(repository: repository);
});