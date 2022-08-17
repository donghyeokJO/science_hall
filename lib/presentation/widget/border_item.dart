import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:science_hall/gen/assets.gen.dart';
import 'package:science_hall/presentation/theme/app_theme.dart';

class BorderBoxItem extends ConsumerWidget {
  const BorderBoxItem({
    Key? key,
    required this.img,
    required this.title,
    required this.onTab,
  }) : super(key: key);

  final Function onTab;
  final String title;
  final AssetGenImage img;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return InkWell(
      onTap: () => {onTab()},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.appColors.background,
          border: Border.all(color: theme.appColors.divider),

        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 100.h,
        width: double.infinity,
        child: Row(
          children: [
            img.image(),
            const Gap(16),
            Expanded(child: Text(title, style: theme.textTheme.h30)),
          ],
        ),
      ),
    );
  }
}

class QuickImage extends StatelessWidget {
  const QuickImage({
    Key? key,
    required this.img,
  }) : super(key: key);
  final AssetGenImage img;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: img.image().image,
    );
  }
}
