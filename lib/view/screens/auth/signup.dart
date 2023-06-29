import 'package:cfl/bloc/auth/bloc/auth_bloc.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/setup_profile.dart';
import 'package:cfl/view/screens/auth/signin.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    super.initState();
  }

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    super.dispose();
  }

  bool obsecure = true;
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state.status.isRegistered) {
            setState(() {
              isLoading = false;
            });
            context.pushReplacement(
              SetupProfile(
                id: state.user!.id,
                email: state.user!.email,
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration:
                const BoxDecoration(gradient: AppColors.whiteBgGradient),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 43),
                        Text(
                          'sign_up'.tr(),
                          style: GoogleFonts.dmSans(
                            color: AppColors.primaryColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'enter_email_sign_up'.tr(),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 8) {
                              return 'Password cannot be less than 8 characters';
                            }
                            return null;
                          },
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
                                            AuthRegister(
                                                name: '',
                                                subject: '',
                                                email: emailController.text,
                                                password: passController.text),
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
                        // const SocialLogins(color: AppColors.black, fill: false),
                        // const SizedBox(height: 42),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.pop();
                              context.showAppDialog(const SignIn());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: '${'already_have_account_sign_in'.tr()} ',
                                style: GoogleFonts.dmSans(
                                  color: AppColors.greyish,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'sign_in'.tr(),
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

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.hint,
    required this.controller,
    this.validator,
    this.prefixIcon,
    this.sufixIcon,
    this.onChanged,
    this.enabled,
    this.initialValue,
    this.isObsecure = false,
    super.key,
  });
  final String hint;
  final IconData? prefixIcon;
  final Widget? sufixIcon;
  final bool isObsecure;
  final bool? enabled;
  final String? initialValue;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint.contains('_') ? hint.tr() : hint,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          enabled: enabled,
          obscureText: isObsecure,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          initialValue: initialValue,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: sufixIcon,
            hintText: '${'enter'.tr()} $hint',
            hintStyle: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.primaryColor.withOpacity(0.50),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
