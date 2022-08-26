import 'package:arc/arc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:science_hall/gen/assets.gen.dart';
import 'package:science_hall/presentation/location/location_provider.dart';
import 'package:science_hall/presentation/theme/app_theme.dart';
import 'package:science_hall/route/app_route.dart';
import 'package:science_hall/util/dev_log.dart';

import '../../data/datasource/local/save_user_provider.dart';

enum BottomIndex { HOME, LOCATION, PREVIEW, EVENT }

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);


    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        LocationRoute(),
        PreViewRoute(),
        EventRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: theme.appColors.accent,
          currentIndex: tabsRouter.activeIndex,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) async {
            if (tabsRouter.activeIndex == index) {
              return;
            }

            if (BottomIndex.PREVIEW.index == index) {
              var userInfo = await getUserInfo();
              Log.d(":::userInfo " + userInfo.toString());
              if (userInfo.isNullOrEmpty) {
                context.router.push(const SignupRoute());
                return;
              }
            }
            if (BottomIndex.LOCATION.index == index) {
              ref.read(locationStateProvider.notifier).fetchBeacon();
            }
            tabsRouter.setActiveIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Assets.svgs.nav01.svg(
                width: 28,
                color: tabsRouter.current.name == HomeRoute.name
                    ? theme.appColors.accent
                    : theme.appColors.disabled,
              ),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: Assets.svgs.nav02.svg(
                width: 28,
                color: tabsRouter.current.name == LocationRoute.name
                    ? theme.appColors.accent
                    : theme.appColors.disabled,
              ),
              label: "현재위치",
            ),
            BottomNavigationBarItem(
              icon: Assets.svgs.nav03.svg(
                width: 28,
                color: tabsRouter.current.name == PreViewRoute.name
                    ? theme.appColors.accent
                    : theme.appColors.disabled,
              ),
              label: "관람",
            ),
            BottomNavigationBarItem(
              icon: Assets.svgs.nav04.svg(
                width: 28,
                color: tabsRouter.current.name == EventRoute.name
                    ? theme.appColors.accent
                    : theme.appColors.disabled,
              ),
              label: "이벤트",
            ),
          ],
        );
      },
    );
  }
}
