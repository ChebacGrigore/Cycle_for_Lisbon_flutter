import 'dart:io';

import 'package:cfl/bloc/auth/bloc/auth_bloc.dart';
import 'package:cfl/controller/app/media_service.dart';
import 'package:cfl/models/user.model.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/screens/auth/signup.dart';

import 'package:cfl/view/screens/home/layout.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';

class SetupProfile extends ConsumerStatefulWidget {
  const SetupProfile({
    required this.email,
    required this.id,
    super.key,
  });
  final String email;
  final String id;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetupProfile2State();
}

class _SetupProfile2State extends ConsumerState<SetupProfile> {
  @override
  void initState() {
    email = TextEditingController(text: widget.email);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    super.initState();
  }

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    super.dispose();
  }

  TextEditingController email = TextEditingController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController nickName = TextEditingController();
  bool isCheked = false;
  bool isLoading = false;
  String profilePic = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text(state.exception.toString()),
                  ],
                ),
              ),
            );
          } else if (state.status.isProfileUpdated) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                    Text('Profile has been updated'),
                  ],
                ),
              ),
            );
            context.push(const Layout());
          }
        },
        builder: (context, state) {
          return Container(
            decoration:
                const BoxDecoration(gradient: AppColors.whiteBgGradient),
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 57,
                    bottom: 67,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'complete_profile_heading'.tr(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 32),
                      profilePic == ''
                          ? const CircleAvatar(
                              radius: 40,
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundImage: FileImage(File(profilePic)),
                            ),
                      TextButton(
                        onPressed: () async {
                          final image = await MediaService().pickImage();
                          setState(() {
                            profilePic = image!;
                          });
                        },
                        child: Text('change_avatar'.tr()),
                      ),
                      const SizedBox(height: 32),
                      AppTextField(
                        hint: 'first_name'.tr(),
                        controller: fName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'First name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        hint: 'last_name'.tr(),
                        controller: lName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Last name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        hint: 'nickname'.tr(),
                        controller: nickName,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        hint: 'email'.tr(),
                        controller: email,
                        sufixIcon: const Icon(Icons.check),
                        enabled: false,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Checkbox(
                              value: isCheked,
                              onChanged: (val) {
                                isCheked = val ?? false;
                                setState(() {});
                              },
                              activeColor: AppColors.accentColor,
                              checkColor: Colors.white,
                            ),
                          ),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              text: TextSpan(
                                style: GoogleFonts.dmSans(
                                  color: AppColors.primaryColor,
                                  fontSize: 13,
                                ),
                                text: '${'agree'.tr()} ',
                                children: [
                                  TextSpan(
                                    text: '${'terms'.tr()} ',
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.accentColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                  TextSpan(
                                    text: '${'and'.tr()} ',
                                  ),
                                  TextSpan(
                                    text: 'privacy'.tr(),
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.accentColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 49,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: AppComponentThemes.elevatedButtonTheme(),
                          onPressed: isLoading == true
                              ? () {}
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (profilePic == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Row(
                                            children: [
                                              Icon(
                                                Icons.warning,
                                                color: Colors.yellow,
                                              ),
                                              Text(
                                                'Please select a profile pciture',
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      if (isCheked == true) {
                                        context.read<AuthBloc>().add(
                                              AuthProfileUpdate(
                                                token: accessToken,
                                                id: widget.id,
                                                userProfile: UserUpdate(
                                                  birthday: '1999-01-01',
                                                  email: widget.email,
                                                  gender: 'M',
                                                  name: '$fName $lName',
                                                  profilePic: '',
                                                  username: nickName.text,
                                                ),
                                              ),
                                            );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(
                                                  Icons.warning,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  'Please agree with the terms and condition',
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                          child: isLoading == true
                              ? const CircularProgressIndicator()
                              : Text(
                                  'save'.tr(),
                                  style: GoogleFonts.dmSans(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                        ),
                      )
                    ],
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
