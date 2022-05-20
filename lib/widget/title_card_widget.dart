import 'package:flutter/material.dart';

class TitleCardWidget extends StatefulWidget {
  final double? height;
  final double width;
  final double titleHeight;
  final Widget? titleChild;
  final Widget? contentChild;
  final Color? titleColor;
  final Color? contentColor;
  final double borderRadiusCircular;
  final double elevation;
  final GestureTapCallback? onTap;

  TitleCardWidget({
    this.height = 200,
    this.width = 0,
    this.titleHeight = 30,
    this.titleChild,
    this.contentChild,
    this.titleColor,
    this.contentColor,
    this.borderRadiusCircular = 10,
    this.elevation = 5,
    this.onTap
  });

  @override
  _TitleCardWidgetState createState() => _TitleCardWidgetState();
}

class _TitleCardWidgetState extends State<TitleCardWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withAlpha(50),
            offset: Offset(0.0, 0.0),
            blurRadius: widget.elevation)
      ], borderRadius: BorderRadius.circular(widget.borderRadiusCircular)),
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.titleChild ?? Container(),
                      ],
                    ),
                    width: double.infinity,
                    height: widget.titleHeight,
                    decoration: BoxDecoration(
                      color: widget.titleColor ?? themeData.colorScheme.primary,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      child: widget.contentChild,
                      decoration: BoxDecoration(
                          color: widget.contentColor ?? themeData.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)))),
                ),
              ],
            ),
          ),
            if(widget.onTap!=null)
           Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadiusCircular),
                child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: widget.onTap,
            ),
          ),
              ))
        ],
      ),
    );
  }
}
