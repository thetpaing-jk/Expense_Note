import 'package:go_router/go_router.dart';

import '../../features/expense_type/screens/expense_type.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/root.dart';
import '../services/app_route_helper.dart';
import 'app_const.dart';

class AppRoutes {
  static GoRouter get router => GoRouter(
        navigatorKey: AppConst.navigatorKey,
        initialLocation: '/',
        routes: [
          StatefulShellRoute.indexedStack(
            branches: [
              StatefulShellBranch(routes: [
                GoRoute(
                  path: AppConst.home,
                  name: AppConst.home,
                  pageBuilder: (context, state){
                    return AppRouteHelper.fadeTransition(
                      child:  HomeScreen(),
                      key: state.pageKey);
                  }
                ),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: AppConst.expenseType,
                  name: AppConst.expenseType,
                  pageBuilder: (context, state){
                    return AppRouteHelper.fadeTransition(
                      child: ExpenseTypeScreen(),
                      key: state.pageKey);
                  }
                )
              ])
            ], builder: (context, state, navigationshellRoute){
              return RootWidget(navigationShell: navigationshellRoute);
            }
          ),
        ],
      );
}