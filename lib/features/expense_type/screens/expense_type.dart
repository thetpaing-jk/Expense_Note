import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../core/utils/app_color.dart';

class ExpenseTypeScreen extends ConsumerStatefulWidget {
  const ExpenseTypeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpenseTypeScreenState();
}
class _ExpenseTypeScreenState extends ConsumerState<ExpenseTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
            child: Column(
              children: [
                Lottie.asset("assets/coming_soon.json"),
                const SizedBox(height: 8,),
                Text("Coming Soon!!!", style: TextTheme.of(context).displaySmall!.copyWith(
                  color: AppColor.secondaryTextColor,
                  fontSize: 24
                ), textAlign: TextAlign.center,),
              ],
            ),
          );
  }
}