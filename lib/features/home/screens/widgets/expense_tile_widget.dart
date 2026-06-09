import 'package:expense_note/features/home/screens/providers/expense_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/services/app_number_formatter.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/expense_btnsheet_widget.dart';
import '../../data/models/expense_model.dart';
import '../models/expense_tile_model.dart' show ExpenseTileModel;
import '../providers/expense_provider.dart';

class ExpenseTileWidget extends ConsumerWidget {
  final ExpenseTileModel expenseTileModel;
  const ExpenseTileWidget({
    super.key, required this.expenseTileModel
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(expenseProvider);
    return Slidable(
      endActionPane: ActionPane(motion: ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) async{
            showModalBottomSheet(
              useRootNavigator: true,
              isScrollControlled: true,
              context: context, builder: (context){
              ExpenseModel expenseModel = ExpenseModel(id: expenseTileModel.id, title: expenseTileModel.title, subtitle: expenseTileModel.subtitle, amount: expenseTileModel.amount, date: expenseTileModel.date);
              return ExpenseBottomSheetWidget(expneseModel: expenseModel,);
            });
          },
          icon: Icons.edit,
          label: "Edit",
          backgroundColor: AppColor.warrningColor,
        ),
        SlidableAction(
          onPressed: (context) async{
            await ref.read(expenseProvider.notifier).deleteExpense(expenseTileModel.id!);
            if(expenseState is ExpenseSuccessState){
              if(context.mounted){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Delete Successfully")));
              }
            }else if(expenseState is ExpenseErrorState){
              String error = expenseState.errorMessage.replaceAll("Exception ", "");
              if(context.mounted){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
              }
            }
          },
          icon: Icons.delete,
          backgroundColor: AppColor.dangerColor,
          label: "Remove",
        )
      ]),
      
      child: ListTile(
        title: Text(expenseTileModel.title, style: TextTheme.of(context).titleMedium,),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expenseTileModel.subtitle,
              style: TextTheme.of(context).labelMedium,
            ),
            const SizedBox(height: 4,),
            Text(expenseTileModel.date,
              style: TextTheme.of(context).labelSmall,
            ),
          ],
        ),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.inputBackgroundColor
          ),
          child: Icon(Icons.wallet),
        ),
        trailing: Text(NumberFormatService.formatCurrency(expenseTileModel.amount, symbol: "RM "),
          style: TextTheme.of(context).titleMedium,
        ),
      ),
    );
  }

}