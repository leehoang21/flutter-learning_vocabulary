import 'package:flutter/material.dart';

import '../../../common/constants/layout_constants.dart';
import '../../../themes/theme_color.dart';
import '../appbar_widget/appbar_widget.dart';

class ScaffoldWidget extends StatelessWidget {
  final AppBarWidget? appbar;
  final Widget body;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;

  const ScaffoldWidget({
    Key? key,
    required this.body,
    this.appbar,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.ebonyClay,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: LayoutConstants.paddingTop24),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                    horizontal: LayoutConstants.paddingHorizontalApp)
                .copyWith(bottom: LayoutConstants.paddingVerticalApp),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LayoutConstants.scaffoldRadius),
                topRight: Radius.circular(LayoutConstants.scaffoldRadius),
              ),
            ),
            child: body,
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
