import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../features/home/data/models/expense_model.dart';
import '../../features/home/screens/providers/expense_provider.dart';
import '../../features/home/screens/providers/expense_provider_state.dart';
import '../utils/app_color.dart';

class ExpenseAddWidget extends ConsumerStatefulWidget {
  final ExpenseModel? expenseModel;
  const ExpenseAddWidget({super.key, this.expenseModel});

  @override
  ConsumerState<ExpenseAddWidget> createState() => _ExpenseAddWidgetState();
}

class _ExpenseAddWidgetState extends ConsumerState<ExpenseAddWidget> {
  final TextEditingController titleC = TextEditingController();
  final TextEditingController amountC = TextEditingController();
  final TextEditingController subtitleC = TextEditingController();
  final FocusNode titleF = FocusNode();
  final FocusNode amountF = FocusNode();
  final FocusNode subtitleF = FocusNode();
  final GlobalKey<FormState> gkey = GlobalKey();
  String btnName = "Add Expense";
  @override
  void initState() {
    super.initState();
    prepareData();
  }

  @override
  void dispose() {
    titleF.dispose();
    amountF.dispose();
    subtitleF.dispose();
    titleC.dispose();
    amountC.dispose();
    subtitleC.dispose();
    super.dispose();
  }

  void prepareData() {
    if (widget.expenseModel != null) {
      ExpenseModel expense = widget.expenseModel!;
      titleC.text = expense.title;
      amountC.text = expense.amount.toString();
      subtitleC.text = expense.subtitle;
      btnName = "Edit Expense";
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenseState = ref.watch(expenseFormProvider);
    expenseListener();
    return Form(
      key: gkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title", style: TextTheme.of(context).labelMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: titleC,
              focusNode: titleF,
              onFieldSubmitted: (value) {
                amountF.requestFocus();
              },
              onTapOutside: (event) {
                titleF.unfocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title is required";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title),
                hint: Text(
                  "Food...",
                  style: TextTheme.of(
                    context,
                  ).labelMedium!.copyWith(color: AppColor.placeholderColor),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Text("Amount", style: TextTheme.of(context).labelMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: amountC,
              focusNode: amountF,
              onFieldSubmitted: (value) {
                subtitleF.requestFocus();
              },
              onTapOutside: (event) {
                amountF.unfocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Amount is required";
                }
                return null;
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.money),
                suffix: Text("RM"),
                hint: Text(
                  "e.g: 10.0",
                  style: TextTheme.of(
                    context,
                  ).labelMedium!.copyWith(color: AppColor.placeholderColor),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Text("Subtitle", style: TextTheme.of(context).labelMedium),
            const SizedBox(height: 8),
            TextFormField(
              controller: subtitleC,
              focusNode: subtitleF,
              onFieldSubmitted: (value) {
                // amountF.requestFocus();
              },
              onTapOutside: (event) {
                subtitleF.unfocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Subtitle is required";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.subtitles),
                hint: Text(
                  "Lunch with Friends...",
                  style: TextTheme.of(
                    context,
                  ).labelMedium!.copyWith(color: AppColor.placeholderColor),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Hero(
              tag: "addBtn",
              child: ElevatedButton.icon(
                onPressed: () {
                  if (gkey.currentState!.validate() == true) {
                    ExpenseModel expense = ExpenseModel(
                      title: titleC.text,
                      subtitle: subtitleC.text,
                      amount: double.parse(amountC.text),
                      date: DateFormat("dd-MMM-yyyy").format(DateTime.now()),
                    );
                    if(widget.expenseModel != null){
                      ref.read(expenseFormProvider.notifier).editExpense(widget.expenseModel!.id!, expense);
                      return;
                    }
                    ref.read(expenseFormProvider.notifier).saveExpense(expense);
                  }
                },
                label: switch (expenseState) {
                  ExpenseFormState() => Text(btnName),
                  ExpenseFormLoadingState() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.expenseModel != null
                          ? Text("Editing Expense...")
                          : Text("Adding Expense..."),
                      const SizedBox(width: 4),
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: AppColor.onButton,
                        ),
                      ),
                    ],
                  ),
                  ExpenseFormSuccessState() => Text(btnName),
                  ExpenseFormErrorState() => Text(btnName),
                },
                icon: widget.expenseModel != null
                    ? Icon(Icons.edit)
                    : Icon(Icons.save),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void expenseListener() {
    ref.listen(expenseFormProvider, (p, next) async {
      if (next is ExpenseFormSuccessState) {
        await ref.read(expenseProvider.notifier).getAllExpense();
        String message = next.successMessage;
        if (mounted) {
          context.pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
      } else if (next is ExpenseFormErrorState) {
        String message = next.errorMessage;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });
  }
}
