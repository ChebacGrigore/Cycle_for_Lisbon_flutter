import 'package:flutter/material.dart';

extension BuidContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  bool get mounted {
    try {
      widget;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<T?> showAppDialog<T>(Widget dialog) => showDialog<T>(
        useSafeArea: false,
        barrierDismissible: true,
        context: this,
        builder: (context) => dialog,
      );

  Future<T?> showBottomSheet<T>(Widget sheet) => showModalBottomSheet<T>(
        useRootNavigator: true,
        isScrollControlled: true,
        context: this,
        builder: (context) => sheet,
      );

  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  void popUntil<T>(Widget page) =>
      Navigator.of(this).popUntil((page) => page.isFirst);
  //push navigation
  Future<T?> push<T>(Widget page) => Navigator.of(this).push<T>(
        MaterialPageRoute<T>(
          builder: (context) => page,
        ),
      );

  //push replacement navigation
  Future<T?> pushReplacement<T, TO>(Widget page) =>
      Navigator.of(this).pushReplacement<T, TO>(
        MaterialPageRoute<T>(
          builder: (context) => page,
        ),
      );
}
