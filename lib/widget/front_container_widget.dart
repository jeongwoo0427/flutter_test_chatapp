import 'package:flutter/material.dart';

class FrontContainerWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final int? shadowAlpha;
  final double? shadowElevation;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPressed;
  final Color? backgroundColor;

  FrontContainerWidget(
      {required this.child,
      this.width,
      this.height,
        this.shadowAlpha,
        this.shadowElevation,
        this.borderRadius,
        this.padding,
      this.onTap,
        this.onLongPressed,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(shadowAlpha??30), offset: Offset(0.0, 2.0), blurRadius: shadowElevation??14.0)],
          borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: backgroundColor??Colors.white,
        borderRadius: borderRadius??BorderRadius.circular(10),
        child: InkWell(
          borderRadius: borderRadius??BorderRadius.circular(10),
          onTap: onTap,
          onLongPress: onLongPressed,
          child: Container(
            padding: padding,
              child: child),
        ),
      ),
    );
  }
}
