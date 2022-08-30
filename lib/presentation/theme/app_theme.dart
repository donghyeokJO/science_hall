
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:science_hall/presentation/theme/app_colors.dart';
import 'package:science_hall/presentation/theme/app_text_theme.dart';
import 'package:science_hall/route/app_route.dart';


final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});
final appThemeModeProvider = StateNotifierProvider<
    StateController<ThemeMode>,
    ThemeMode>((ref) => StateController(ThemeMode.light));

final appThemeProvider = Provider<AppTheme>(
      (ref) {
    final mode = ref.watch(appThemeModeProvider);
    switch (mode) {
      case ThemeMode.dark:
        return AppTheme.dark();
      case ThemeMode.light:
      default:
        return AppTheme.light();
    }
  },
);


class AppTheme {
  AppTheme({
    required this.mode,
    required this.data,
    required this.textTheme,
    required this.appColors,
  });

  factory AppTheme.light() {
    const mode = ThemeMode.light;
    final appColors = AppColors.light();
    final themeData = ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
      scaffoldBackgroundColor: appColors.background,
      textTheme: GoogleFonts.notoSansTextTheme(ThemeData
          .light()
          .textTheme),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      textTheme: AppTextTheme(),
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    const mode = ThemeMode.dark;
    final appColors = AppColors.dark();
    final themeData = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light,),
      scaffoldBackgroundColor: appColors.background,
      textTheme: GoogleFonts.notoSansTextTheme(ThemeData
          .dark()
          .textTheme),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      textTheme: AppTextTheme(),
      appColors: appColors,
    );
  }

  final ThemeMode mode;
  final ThemeData data;
  final AppTextTheme textTheme;
  final AppColors appColors;
}