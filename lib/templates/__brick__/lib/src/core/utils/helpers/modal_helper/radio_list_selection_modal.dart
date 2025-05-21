import 'package:flutter/material.dart';
import 'package:{{name}}/src/core/theme/app_theme.dart';
import 'package:{{name}}/src/core/utils/extensions.dart';
import 'package:{{name}}/src/core/utils/helpers/app_bottom_sheet_helper.dart';
import 'package:{{name}}/src/presentation/widgets/app_widgets/app_bottom_navigation_bar.dart';

void callRadioListSelectionModal({
  required BuildContext context,
  required String headerTitle,
  required Widget body,
  required String botNavButtonTitle,
}) {
  return AppBottomSheetHelper.showBottomSheet(
    context,
    header: Text(
      headerTitle,
      style: AppTextStyle.displaySmallBold.copyWith(color: AppColor.brandPrimary800),
    ),
    body: body,
    bottomNavigationBar: AppBottomNavigationBar(
      child: FilledButton(
        onPressed: () {},
        child: Text(
          botNavButtonTitle,
        ),
      ).fillWidth,
    ),
  );
}
