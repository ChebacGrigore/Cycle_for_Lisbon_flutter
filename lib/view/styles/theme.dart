import 'package:flutter/material.dart';

import 'colors.dart';

class AppComponentThemes {
  static appBarTheme() {
    return const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    );
  }

  // static bottomNavigationTheme(BuildContext context, NavigationBar child) {
  //   return NavigationBarTheme(
  //     data: NavigationBarThemeData(
  //       backgroundColor: AppColors.solidWhite,
  //       indicatorColor: AppColors.solidBlack,
  //       labelTextStyle: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.selected)) {
  //           return AppTypography.m3LabelMedium();
  //         }
  //         return AppTypography.m3LabelMedium(color: AppColors.purple);
  //       }),
  //     ),
  //     child: child,
  //   );
  // }

  static textButtonTheme() {
    return ButtonStyle(
      padding: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        }
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      }),
      surfaceTintColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.black;
        }
        return AppColors.secondaryColor;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.black;
        }
        return AppColors.secondaryColor;
      }),
      overlayColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.transparent;
        }
        return AppColors.secondaryColor.withOpacity(0.12);
      }),
    );
  }

  static elevatedButtonTheme({
    Color? color,
    Color? borderColor,
  }) {
    return ButtonStyle(
      side: borderColor != null
          ? MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return const BorderSide(color: AppColors.black);
              }
              return BorderSide(color: borderColor);
            })
          : null,
      elevation: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return 0;
        }
        return 0;
      }),
      shape: MaterialStateProperty.resolveWith((states) {
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        );
      }),
      padding: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const EdgeInsets.symmetric(horizontal: 36, vertical: 8);
        }
        return const EdgeInsets.symmetric(horizontal: 26, vertical: 8);
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.black;
        }
        return color ?? AppColors.secondaryColor;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.black;
        }
        return AppColors.white;
      }),
      overlayColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.transparent;
        }
        return AppColors.white.withOpacity(0.12);
      }),
    );
  }

  static outlinedButtonTheme({
    Color? color,
    Color? borderColor,
  }) {
    return ButtonStyle(
      elevation: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return 0;
        }
        return 0;
      }),
      shape: MaterialStateProperty.resolveWith((states) {
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        );
      }),
      padding: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        }
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      }),
      side: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const BorderSide(color: AppColors.black);
        }
        return BorderSide(color: borderColor ?? AppColors.white);
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.black;
        }
        return color ?? AppColors.white;
      }),
      overlayColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }
          if (color != null) {
            return color.withOpacity(0.12);
          }
          return AppColors.white.withOpacity(0.12);
        },
      ),
    );
  }
}
