import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:synchronized/synchronized.dart';


class CustomProgressDialog extends StatelessWidget {
  const CustomProgressDialog({
    Key? key,
    this.child,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.shape,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget? child;

  /// The duration of the animation to show when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve insetAnimationCurve;

  /// {@template flutter.material.dialog.shape}
  /// The shape of this dialog's border.
  ///
  /// Defines the dialog's [Material.shape].
  ///
  /// The default shape is a [RoundedRectangleBorder] with a radius of 2.0.
  /// {@endtemplate}
  final ShapeBorder? shape;

  Color _getColor(BuildContext context) {
    return Colors.transparent;//Theme.of(context).dialogBackgroundColor;
  }

  static const RoundedRectangleBorder _defaultDialogShape =
  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)));

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets +
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
        duration: insetAnimationDuration,
        curve: insetAnimationCurve,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Material(
                elevation: 0,//24.0,
                color: _getColor(context),
                type: MaterialType.card,
                child: child,
                shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressDialog {
  final BuildContext context;
  bool isDismissed = true;
  var lock = Lock();
  Timer? _timer;

  ProgressDialog(this.context);

  Future<void> dismiss() async {
    _timer?.cancel();
    await lock.synchronized(() async {
      if (isDismissed) {
        return;
      }
      isDismissed = true;

      Navigator.of(context, rootNavigator: true).pop(true);
    });
  }

  void show({
    Color barrierColor = const Color(0x55222222),
    String? textToBeDisplayed,
    Duration dismissAfter =const Duration(seconds: 10),
    Function? onDismiss
  })
  {
    dismiss().then((_){
      isDismissed = false;
      showGeneralDialog(
        context: context,
        barrierColor: barrierColor,
        pageBuilder: (context, animation1, animation2) {
          return CustomProgressDialog(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 60,
                  height: 60,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    strokeWidth: 3,
                    colors: [Colors.lightBlueAccent,Colors.cyanAccent,Colors.orange,],

                  ),
                )
            ),
          );
        },
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 300),
      ).then((dismissed) {
        isDismissed = dismissed as bool;
      });
      if(dismissAfter == null)return;
      _timer = Timer(dismissAfter,() {
        dismiss();
        if (onDismiss != null) onDismiss();
      });
    });

  }

}