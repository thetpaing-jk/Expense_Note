import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';

void main() {
  runApp(ProviderScope(child: const ExpneseNote()));
}

class ExpneseNote extends StatefulWidget {
  const ExpneseNote({super.key});

  @override
  State<ExpneseNote> createState() => _ExpneseNoteState();
}

class _ExpneseNoteState extends State<ExpneseNote> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Expense Note',
      theme: AppTheme.darkTheme,
      routerConfig: AppRoutes.router,
    );
  }
}