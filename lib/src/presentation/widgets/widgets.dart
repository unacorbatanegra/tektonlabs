import 'package:flutter/material.dart' hide YearPicker, MonthPicker, DayPicker;
import 'package:gap/gap.dart';

import 'palette.dart';

export 'package:flutter/cupertino.dart';
export 'package:flutter/material.dart'
    hide RefreshCallback, YearPicker, MonthPicker, DayPicker;

export 'app_bar_widget.dart';
export 'app_theme.dart';
export 'custom_button.dart';
export 'custom_stepper.dart';
export 'custom_text_field.dart';
export 'drawer_widget.dart';
export 'end_drawer/end_drawer.dart';
export 'majes_icons.dart';
export 'palette.dart';

export 'root_widget.dart';
export 'search_widget.dart';

const gap2 = Gap(2);
const gap4 = Gap(4);
const gap6 = Gap(6);
const gap8 = Gap(8);
const gap10 = Gap(10);
const gap12 = Gap(12);
const gap16 = Gap(16);
const gap18 = Gap(18);
const gap32 = Gap(32);
const gap36 = Gap(36);
const gap64 = Gap(64);

const loadingIndicator = Center(
  child: CircularProgressIndicator.adaptive(),
);

const kMobileContentConstraints = BoxConstraints(
  maxWidth: 400,
  maxHeight: double.infinity,
);

Widget? noCounter(
  BuildContext context, {
  required int currentLength,
  required int? maxLength,
  required bool isFocused,
}) =>
    emptyWidget;

const emptyWidget = SizedBox.shrink();
const zero = EdgeInsets.zero;
const always = AlwaysScrollableScrollPhysics();

extension Context on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;

  TextStyle? get h1 => text.headline1;
  TextStyle? get h2 => text.headline2;
  TextStyle? get h3 => text.headline3;
  TextStyle? get h4 => text.headline4;
  TextStyle? get h5 => text.headline5;
  TextStyle? get h6 => text.headline6;
  TextStyle? get h7 => text.headline6?.copyWith(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get s1 => text.subtitle1;
  TextStyle? get s2 => text.subtitle2;
  TextStyle? get s3 => text.subtitle1?.copyWith(
        fontWeight: FontWeight.w700,
        color: Palette.gray2,
      );

  TextStyle? get b => text.button;

  Size get size => MediaQuery.of(this).size;

  double get w => size.width;
  double get h => size.height;
}

extension WidgetPaddingX on Widget {
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(
          padding,
        ),
        child: this,
      );

  Widget paddingSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
          padding: EdgeInsets.only(
              top: top, left: left, right: right, bottom: bottom),
          child: this);

  Widget get paddingZero => Padding(padding: EdgeInsets.zero, child: this);
}
