import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/expense_add_widget.dart';
import '../data/models/expense_model.dart';
import 'models/expense_tile_model.dart';

class ExpenseDetail extends ConsumerStatefulWidget {
  final ExpenseTileModel expenseTileModel;
  const ExpenseDetail({super.key, required this.expenseTileModel});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpenseDetailState();
}

class _ExpenseDetailState extends ConsumerState<ExpenseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ExpenseAddWidget(
            expenseModel: ExpenseModel(
              id: widget.expenseTileModel.id,
              title: widget.expenseTileModel.title,
              subtitle: widget.expenseTileModel.subtitle,
              amount: widget.expenseTileModel.amount,
              date: widget.expenseTileModel.date,
            ),
          ),
        ],
      ),
    );
  }
}
