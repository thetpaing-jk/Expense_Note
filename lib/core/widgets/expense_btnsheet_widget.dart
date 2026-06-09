import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/data/models/expense_model.dart';
import 'expense_add_widget.dart';

class ExpenseBottomSheetWidget extends StatefulWidget {
  final ExpenseModel? expneseModel;
  const ExpenseBottomSheetWidget({
    super.key,
    this.expneseModel
  });

  @override
  State<ExpenseBottomSheetWidget> createState() => _ExpenseBottomSheetWidgetState();
}

class _ExpenseBottomSheetWidgetState extends State<ExpenseBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add Expense", style: TextTheme.of(context).titleLarge,),
                IconButton(onPressed: (){
                  context.pop();
                }, icon: Icon(Icons.close))
              ],
            ),
          ),
          const Divider(),
          ExpenseAddWidget(expenseModel: widget.expneseModel,)
        ],
      ),
    );
  }
}