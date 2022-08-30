import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:science_hall/data/datasource/remote/mock_data_store.dart';
import 'package:science_hall/data/datasource/repositoryimpl/repository_provider.dart';
import 'package:science_hall/presentation/theme/app_theme.dart';
import 'di_container.dart' as ic;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MockDataStore(context);
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final appRouter = ref.watch(appRouterProvider);

    ref.read(tokenProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp.router(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
          theme: theme.data,
          darkTheme: AppTheme.light().data,
          themeMode: themeMode,
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
        );
      },
    );
  }
}
