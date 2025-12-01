import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:flutter/material.dart';

class CustomPageBody extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CustomPageBody({
    super.key,
    required this.children,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    const defaultPadding =
        EdgeInsets.symmetric(horizontal: AppDimens.kDefaultPadding);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: padding ?? defaultPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight -
                    (padding?.vertical ?? defaultPadding.vertical),
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
