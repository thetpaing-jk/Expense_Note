import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/app_color.dart';
import '../core/widgets/expense_btnsheet_widget.dart';


class RootWidget extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  const RootWidget({super.key, required this.navigationShell});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootWidgetState();
}
class _RootWidgetState extends ConsumerState<RootWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.cardBackgroundColor,
        title: Text(widget.navigationShell.currentIndex == 0 ? "Expneses" : "Expnese Types", style: TextTheme.of(context).headlineSmall,),
      ),
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (value){
          widget.navigationShell.goBranch(value, initialLocation: value == widget.navigationShell.currentIndex);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet), 
            label: "Expnese",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined), 
            label: "Types"
          ),
        ],
        elevation: 0,
      ),

      floatingActionButton:GestureDetector(
        onTap: () {
          _expenseBottomSheet(context);
        },
        child: Hero(
          tag: "addBtn",
          child: Material(
            color: AppColor.buttonColor,
            borderRadius: BorderRadius.circular(16),
            elevation: 6,
            shadowColor: AppColor.buttonColor.withValues(alpha: 0.4),
            child: const SizedBox(
              width: 56,
              height: 56,
              child: Icon(Icons.add, color: Colors.black, size: 28),
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<dynamic> _expenseBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context){
          return ExpenseBottomSheetWidget();
        });
  }
}


