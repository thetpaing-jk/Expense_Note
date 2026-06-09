import 'package:flutter/foundation.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../../../core/database/database.dart';
import '../../../../core/utils/app_const.dart';
import '../models/expense_model.dart';

abstract class ExpenseLocalDatasource {
  Future<int> saveExpense(ExpenseModel expense);
  Future<List<ExpenseModel>> getAllExpense();
  Future<double> getTotalExpenseAmount();
  Future<int> deleteExpense(int id);
  Future<void> editExpense(int id, ExpenseModel expnese);
}

class ExpenseLocalDatasourceImpl extends ExpenseLocalDatasource{
  final DatabaseService _databaseService;
  ExpenseLocalDatasourceImpl({DatabaseService? databaseService}) :
  _databaseService = databaseService ?? DatabaseService.instance;

  @override
  Future<int> deleteExpense(int id) async{
    try {
      Database db = await _databaseService.database;
      int result = await db.delete(AppConst.expenseTable, where: "id = ?", whereArgs: [id]);
      return result;
    } catch (e) {
      debugPrint("local datasource [delete expense $id] error : $e");
      throw Exception("$e");
    }
  }

  @override
  Future<List<ExpenseModel>> getAllExpense() async{
    try {
      Database db = await _databaseService.database;
      List<Map<String,dynamic>> result = await db.query(AppConst.expenseTable);
      debugPrint("expense Data get => $result");
      if(result.isNotEmpty){
        List<ExpenseModel> expneseList = result.map((expense)=> ExpenseModel.fromJson(expense)).toList();
        return expneseList;
      }
      return [];
    } catch (e) {
      debugPrint("local datasource [get all expnese] error : $e");
      throw Exception("$e");     
    }
  }

  @override
  Future<double> getTotalExpenseAmount() async {
    try {
      Database db = await _databaseService.database;
      List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT COALESCE(SUM(amount), 0) AS totalAmount FROM ${AppConst.expenseTable}',
      );
      num totalAmount = result.first['totalAmount'] as num;
      return totalAmount.toDouble();
    } catch (e) {
      debugPrint("local datasource [get total expense amount] error : $e");
      throw Exception("$e");
    }
  }

  @override
  Future<int> saveExpense(ExpenseModel expense) async{
    try {
      Database db = await _databaseService.database;
      Map<String,dynamic> expenseData = expense.toJson();
      int result = await db.insert(AppConst.expenseTable, expenseData);
      debugPrint("expense Data saved : $expenseData");
      return result;
    } catch (e) {
      debugPrint("local datasource [save expnese] error $e");
      throw Exception("$e");
    }
  }
  
  @override
  Future<void> editExpense(int id, ExpenseModel expnese) async{
    try {
      Database db = await _databaseService.database;
      Map<String,dynamic> expneseData = expnese.toJson();
      await db.update(AppConst.expenseTable, expneseData, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint("local datasource [edit expnese] error $e");
      throw Exception("$e");
    }
  }

}
