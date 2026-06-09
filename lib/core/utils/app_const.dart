import 'package:flutter/material.dart';

class AppConst {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String home = '/';
  static const String expenseType = '/expenseType';
  static const String expenseDetail = '/expenseDetail';

  //--- database table ----------------
  static const String expenseTable = "expenseTable";
  static const String expenseTypeTable = "expneseTypeTable";
}
