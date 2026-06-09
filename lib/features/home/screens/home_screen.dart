import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../core/services/app_number_formatter.dart';
import '../../../core/utils/app_color.dart';
import '../data/models/expense_model.dart';
import 'models/expense_tile_model.dart';
import 'providers/expense_provider.dart';
import 'providers/expense_provider_state.dart';
import 'widgets/expense_tile_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      ref.read(expenseProvider.notifier).getAllExpense();
    });
  }
  @override
  Widget build(BuildContext context) {
    final expenseState = ref.watch(expenseProvider);
    return 
     switch (expenseState) {
       ExpenseIdleState() => SizedBox(),
       ExpenseLoadingState() => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 25, width: 25, 
            child: CircularProgressIndicator.adaptive(),
          ),
          const SizedBox(height: 8,),
          Text("Fetching Expenses...", style: TextTheme.of(context).labelLarge,)
        ],
       ),
       ExpenseSuccessState(expenseList: List<ExpenseModel> expenseList, totalAmount: double totalAmount) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: expenseList.isEmpty ? Center(
            child: Column(
              children: [
                Lottie.asset("assets/no_item.json"),
                const SizedBox(height: 8,),
                Text("Add your expenses and track easily!!!", style: TextTheme.of(context).displaySmall!.copyWith(
                  color: AppColor.secondaryTextColor,
                  fontSize: 24
                ), textAlign: TextAlign.center,),
              ],
            ),
          )
          : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Expnese",
                  style: TextTheme.of(context).labelLarge!.copyWith(
                    color: AppColor.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  NumberFormatService.formatCurrency(totalAmount, symbol: "RM "),
                  style: TextTheme.of(
                    context,
                  ).titleLarge!.copyWith(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.cardBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      for(ExpenseModel expense in expenseList)...[
                        ExpenseTileWidget(
                          expenseTileModel: ExpenseTileModel(
                            id: expense.id,
                            title: expense.title,
                            subtitle: expense.subtitle,
                            date: expense.date,
                            amount: expense.amount,
                          ),
                        ),
                        expenseList.last != expense ? const Divider() : const SizedBox(),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
       ExpenseErrorState(errorMessage: String errorMessage) => Text(errorMessage, style: TextTheme.of(context).labelLarge,),
     };
  }
}
