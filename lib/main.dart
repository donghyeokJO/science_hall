import 'package:arc/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:science_hall/presentation/main/main_page.dart';

import 'package:science_hall/presentation/theme/app_theme.dart';
import 'package:science_hall/route/app_route.dart';

import 'di_container.dart' as dc;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dc.init();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      theme: theme.data,
      darkTheme: AppTheme.light().data,
      themeMode: themeMode,
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
    );

  }
}