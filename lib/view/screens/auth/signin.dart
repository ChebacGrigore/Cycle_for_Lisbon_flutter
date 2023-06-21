import 'package:cfl/bloc/auth/bloc/auth_bloc.dart';
import 'package:cfl/routes/app_route.dart';
import 'package:cfl/routes/app_route_paths.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/screens/auth/splash.dart';
// import 'package:cfl/view/screens/home/layout.dart';
// import 'package:cfl/view/screens/home/layout.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenArguments {
  final bool? isDeepLink;
  final String? code;

  ScreenArguments(this.isDeepLink, this.code);
}

class SignIn extends StatefulWidget {
  final bool? isDeepLink;
  final String? code;
  const SignIn({super.key, this.isDeepLink = false, this.code});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obsecure = true;
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    // if (widget.isDeepLink == true && widget.code != null) {
    //   print('Code Gotten from go router ${widget.code}');
    // }
  }

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status.isLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state.status.isError) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    Expanded(
                      child: Text(
                        state.exception.toString(),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state.status.isAuthenticated) {
            setState(() {
              isLoading = false;
            });
            appRoutes.pushReplacement(AppRoutePath.home);
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => const Layout(),
            //   ),
            // );
          } else if (state.status.isPasswordReset) {
            setState(() {
              isLoading = false;
            });
          } else if (state.status.isConfirmPasswordReset) {
            setState(() {
              isLoading = false;
            });
          }
        },
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration:
                const BoxDecoration(gradient: AppColors.whiteBgGradient),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.logo2Svg,
                                  width: 25,
                                  height: 25,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Cycle for Lisbon'.toUpperCase(),
                                  style: GoogleFonts.dmSans(
                                    color: AppColors.primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: const Icon(Icons.close)),
                          ],
                        ),
                        const SizedBox(height: 43),
                        Text(
                          'sign_in'.tr(),
                          style: GoogleFonts.dmSans(
                            color: AppColors.primaryColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'login_to_account'.tr(),
                          style: GoogleFonts.dmSans(
                            color: AppColors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 33),
                        AppTextField(
                          prefixIcon: CFLIcons.mail,
                          isObsecure: false,
                          controller: emailController,
                          hint: 'email'.tr(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          isObsecure: obsecure,
                          prefixIcon: CFLIcons.lock,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 8) {
                              return 'Password cannot be less than 8 characters';
                            }
                            return null;
                          },
                          sufixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obsecure = !obsecure;
                              });
                            },
                            child: Icon(
                              obsecure
                                  ? CFLIcons.visibilityOff
                                  : CFLIcons.visibility,
                            ),
                          ),
                          controller: passController,
                          hint: 'password'.tr(),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                useSafeArea: false,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return const RecoverPasswordDialog();
                                },
                              );
                              // context.showAppDialog(const RecoverPasswordDialog());
                            },
                            child: Text(
                              'recover_password'.tr(),
                              style: GoogleFonts.dmSans(
                                color: AppColors.accentColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isLoading == true
                                ? () {}
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                            AuthLogin(
                                              email: emailController.text,
                                              password: passController.text,
                                            ),
                                          );
                                    }
                                  },
                            style: AppComponentThemes.elevatedButtonTheme(),
                            child: isLoading == true
                                ? const CircularProgressIndicator()
                                : Text(
                                    'continue'.tr(),
                                    style: GoogleFonts.dmSans(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 42),
                        const SocialLogins(color: AppColors.black, fill: false),
                        const SizedBox(height: 42),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // context.pop();
                              context.showAppDialog(const SignUp());
                              // context.showAppDialog(const SignUp());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: '${'no_account_sign_up'.tr()} ',
                                style: GoogleFonts.dmSans(
                                  color: AppColors.greyish,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'sign_up'.tr(),
                                    style: GoogleFonts.dmSans(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecoverPasswordDialog extends StatefulWidget {
  const RecoverPasswordDialog({
    super.key,
  });

  @override
  State<RecoverPasswordDialog> createState() => _RecoverPasswordDialogState();
}

class _RecoverPasswordDialogState extends State<RecoverPasswordDialog> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state.status.isError) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Text(
                      state.exception.toString(),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.status.isPasswordReset) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).pop();
          context.showAppDialog(const SuccessDialog());
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: MediaQuery.of(context).size.height * 0.1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColors.white,
            ),
            child: Material(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            color: AppColors.tertiaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.lock,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'recover_password'.tr(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'enter_email_recover'.tr(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.primaryColor.withOpacity(0.80),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    hint: 'Email',
                    isObsecure: false,
                    controller: emailController,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: ElevatedButton(
                      style: AppComponentThemes.elevatedButtonTheme(
                        color: AppColors.white,
                        borderColor: AppColors.secondaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'back_login'.tr(),
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: ElevatedButton(
                      style: AppComponentThemes.elevatedButtonTheme(
                        color: AppColors.secondaryColor,
                        borderColor: Colors.transparent,
                      ),
                      onPressed: isLoading == true
                          ? () {}
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      AuthPasswordReset(
                                        email: emailController.text,
                                      ),
                                    );
                              }
                            },
                      child: isLoading == true
                          ? const CircularProgressIndicator()
                          : Text(
                              '${'send'.tr()} Email',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.primaryColor,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ResetPasswordDialog extends StatefulWidget {
  final String? code;
  const ResetPasswordDialog({
    required this.code,
    super.key,
  });

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  TextEditingController passController = TextEditingController();

  TextEditingController confirmController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state.status.isError) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Text(
                      state.exception.toString(),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.status.isConfirmPasswordReset) {
          setState(() {
            isLoading = false;
          });
          // appRoutes.go('/signin/0?deepLink=true');
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20.0),
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: MediaQuery.of(context).size.height * 0.1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColors.white,
            ),
            child: Material(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            color: AppColors.tertiaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.key,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Reset Password",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Enter your new password below",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.primaryColor.withOpacity(0.80),
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'Password cannot be less than 8 characters';
                      }
                      return null;
                    },
                    hint: 'New Password',
                    controller: passController,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'Password cannot be less than 8 characters';
                      } else if (value != passController.text) {
                        return 'Passwords not matched';
                      }
                      return null;
                    },
                    hint: "Confirm Password",
                    controller: confirmController,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 49,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: AppComponentThemes.elevatedButtonTheme(
                        color: AppColors.secondaryColor,
                        borderColor: Colors.transparent,
                      ),
                      onPressed: isLoading == true
                          ? () {}
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      AuthConfirmPasswordReset(
                                        code: widget.code!,
                                        newPassword: confirmController.text,
                                      ),
                                    );
                              }
                            },
                      child: isLoading == true
                          ? const CircularProgressIndicator()
                          : Text(
                              'Save',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.primaryColor,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: MediaQuery.of(context).size.height * 0.1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.white,
      ),
      child: Material(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      color: AppColors.tertiaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Icon(
                      Icons.done,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Your Email has been",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Sucessfully submitted",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 14),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 49,
              child: ElevatedButton(
                style: AppComponentThemes.elevatedButtonTheme(
                  color: AppColors.secondaryColor,
                  borderColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  // context.showAppDialog(const ResetPasswordDialog());
                },
                child: Text(
                  'Continue',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class RecoverPasswordDialog extends StatefulWidget {
//   const RecoverPasswordDialog({super.key});

//   @override
//   State<RecoverPasswordDialog> createState() => _RecoverPasswordDialog();
// }

// class _RecoverPasswordDialog extends State<RecoverPasswordDialog> {
//   TextEditingController email = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(24.0),
//       ),
//       child: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//           height: MediaQuery.of(context).size.height * 0.65,
//           // width: 500,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 22),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                         color: AppColors.tertiaryColor,
//                         borderRadius: BorderRadius.circular(50)),
//                     child: const Center(
//                       child: Icon(
//                         Icons.lock_outline,
//                         size: 40,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'recover_password'.tr(),
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.dmSans(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 22,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               const SizedBox(height: 14),
//               Text(
//                 'enter_email_recover'.tr(),
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.dmSans(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   color: AppColors.primaryColor.withOpacity(0.80),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               AppTextField(
//                 hint: 'Email',
//                 controller: email,
//                 prefixIcon: Icons.email_outlined,
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 height: 49,
//                 child: ElevatedButton(
//                   style: AppComponentThemes.elevatedButtonTheme(
//                     color: AppColors.white,
//                     borderColor: AppColors.secondaryColor,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                     'Go back To Login',
//                     style: GoogleFonts.dmSans(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                       color: AppColors.black,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//               SizedBox(
//                 width: double.infinity,
//                 height: 49,
//                 child: ElevatedButton(
//                   style: AppComponentThemes.elevatedButtonTheme(
//                     color: AppColors.secondaryColor,
//                     borderColor: Colors.transparent,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     context.showAppDialog(const ResetPasswordDialog());
//                   },
//                   child: Text(
//                     '${'send'.tr()} Email',
//                     style: GoogleFonts.dmSans(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
