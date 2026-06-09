import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/expense_repository.dart';
import '../datasource/expense_local_datasource.dart';
import '../repositories/expense_repository_impl.dart';

final expenseLocalDatasourceProvider = Provider<ExpenseLocalDatasource>((ref){
  return ExpenseLocalDatasourceImpl();
});

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref){
  final localDatasource = ref.read(expenseLocalDatasourceProvider);
  return ExpenseRepositoryImpl(expenseLocalDatasource: localDatasource);
});