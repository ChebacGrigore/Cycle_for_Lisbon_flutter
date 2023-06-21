// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';

import 'package:cfl/bloc/auth/bloc/auth_bloc.dart';
import 'package:cfl/controller/app/media_service.dart';
import 'package:cfl/shared/app_bar_clip.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../../../controller/app/media_service.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  ScrollController scrollController = ScrollController();
  TextEditingController email = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController nickName = TextEditingController();
  Color appbarColor = AppColors.white;
  bool isLoading = false;
  String profilePic = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      fName = TextEditingController(text: currentUser.name.split(' ')[0]);
      lName = TextEditingController(text: currentUser.name.split(' ')[1]);
      nickName = TextEditingController(text: currentUser.username);
    });
    scrollController.addListener(() {
      setState(
        () {
          if (scrollController.offset > 70) {
            appbarColor = AppColors.primaryColor;
          } else {
            appbarColor = AppColors.white;
          }
        },
      );
    });
  }

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
            fName.clear();
            lName.clear();
            nickName.clear();

            context
                .read<AuthBloc>()
                .add(AuthGetProfile(id: currentUser.id, token: accessToken));
            context.pop();
          }else if (state.status.isProfilePicture) {
            setState(() {
              isLoading = false;
            });
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.background,
                foregroundColor: appbarColor,
                floating: true,
                pinned: true,
                snap: true,
                centerTitle: true,
                expandedHeight: 175,
                title: Text(
                  'profile_settings'.tr(),
                  style: GoogleFonts.dmSans(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      const MyArc(
                        diameter: double.infinity,
                        color: AppColors.primaryColor,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 108,
                          height: 108,
                          child: Stack(
                            children: [
                              // profilePic == ''
                              //     ? const CircleAvatar(
                              //         radius: 85,
                              //       )
                              //     :
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  if (state.status.isLoading) {
                                    return const CircleAvatar(
                                      radius: 85,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  } else if (state.status.isError) {
                                    return const CircleAvatar(
                                      radius: 85,
                                    );
                                  } else if (state.status.isProfilePicture) {
                                    CircleAvatar(
                                      radius: 85,
                                      backgroundImage:
                                      FileImage(File(profilePic)),
                                    );
                                  }
                                  return profilePic == '' ?  CircleAvatar(
                                    radius: 85,
                                      backgroundImage:
                                      NetworkImage(state.profilePic!)
                                  )
                                      : CircleAvatar(
                                    radius: 85,
                                    backgroundImage:
                                        FileImage(File(profilePic)),
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final imagePath =
                                      await mediaService.pickImage();
                                  setState(() {
                                    profilePic = imagePath!;
                                  });
                                  final imageBytes = await mediaService
                                      .fileToBytes(File(imagePath!));

                                  context.read<AuthBloc>().add(
                                        AuthProfilePictureUpload(
                                          token: accessToken,
                                          id: currentUser.id,
                                          imageByte: imageBytes,
                                        ),
                                      );
                                },
                                child: const Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.secondaryColor,
                                    child: Icon(
                                      Icons.photo_camera_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(height: 42),
                            AppTextField(
                              hint: 'first_name'.tr(),
                              controller: fName,
                              // initialValue: currentUser.name.split(' ')[0],
                            ),
                            const SizedBox(height: 19),
                            AppTextField(
                              hint: 'last_name'.tr(),
                              controller: lName,
                              // initialValue: currentUser.name.split(' ')[1],
                            ),
                            const SizedBox(height: 19),
                            AppTextField(
                              hint: 'nickname'.tr(),
                              controller: nickName,
                              // initialValue: currentUser.username,
                            ),
                            const SizedBox(height: 19),
                            AppTextField(
                              hint: currentUser.email,
                              controller: email,
                              enabled: false,
                            ),
                            const SizedBox(height: 29),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: AppColors.primaryColor
                                        .withOpacity(0.10),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'change_password'.tr().toUpperCase(),
                                  style: GoogleFonts.dmSans(
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Divider(
                                    color: AppColors.primaryColor
                                        .withOpacity(0.10),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 29),
                            AppTextField(
                              hint: 'old_password'.tr(),
                              controller: TextEditingController(),
                            ),
                            const SizedBox(height: 19),
                            AppTextField(
                              hint: 'new_password'.tr(),
                              controller: TextEditingController(),
                            ),
                            const SizedBox(height: 19),
                            AppTextField(
                              hint: 'confirm_password'.tr(),
                              controller: TextEditingController(),
                            ),
                            const SizedBox(height: 44),
                            SizedBox(
                              width: double.infinity,
                              height: 49,
                              child: ElevatedButton(
                                style: AppComponentThemes.elevatedButtonTheme(),
                                onPressed: isLoading == true
                                    ? () {}
                                    : () async {
                                        if (profilePic != '') {
                                          final imageBytes = await mediaService
                                              .fileToBytes(File(profilePic));
                                          print(imageBytes);
                                        }
                                        // print(profilePic);
                                        // context.read<AuthBloc>().add(
                                        //       AuthProfileUpdate(
                                        //         token: accessToken,
                                        //         userProfile: UserUpdate(
                                        //           birthday: '1999-01-01',
                                        //           email: currentUser.email,
                                        //           gender: 'M',
                                        //           name:
                                        //               '${fName.text == '' ? currentUser.name.split(' ')[0] : fName.text} ${lName.text == '' ? currentUser.name.split(' ')[1] : lName.text}',
                                        //           profilePic: '',
                                        //           username: nickName.text == ''
                                        //               ? currentUser.username
                                        //               : nickName.text,
                                        //         ),
                                        //         id: currentUser.id,
                                        //       ),
                                        //     );
                                      },
                                child: isLoading == false
                                    ? Text(
                                        'save_changes'.tr(),
                                      )
                                    : const CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(height: 44),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  HeaderClipper({@required this.avatarRadius});

  final avatarRadius;

  @override
  getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height - 100)
      ..quadraticBezierTo(size.width / 4, (size.height - avatarRadius),
          size.width / 2, (size.height - avatarRadius))
      ..quadraticBezierTo(size.width - (size.width / 4),
          (size.height - avatarRadius), size.width, size.height - 100)
      ..lineTo(size.width, 0.0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class HeaderPainter extends CustomPainter {
  HeaderPainter({required this.color, required this.avatarRadius});

  final Color color;
  final double avatarRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds =
        Rect.fromLTRB(0, 0, size.width, size.height - avatarRadius);
    final centerAvatar = Offset(shapeBounds.center.dx, shapeBounds.bottom);
    final avatarBounds =
        Rect.fromCircle(center: centerAvatar, radius: avatarRadius).inflate(3);
    _drawBackground(canvas, shapeBounds, avatarBounds);
  }

  @override
  bool shouldRepaint(HeaderPainter oldDelegate) {
    return color != oldDelegate.color;
  }

  void _drawBackground(Canvas canvas, Rect shapeBounds, Rect avatarBounds) {
    final paint = Paint()..color = color;

    final backgroundPath = Path()
      ..moveTo(shapeBounds.left, shapeBounds.top)
      ..lineTo(shapeBounds.bottomLeft.dx, shapeBounds.bottomLeft.dy)
      ..arcTo(avatarBounds, -pi, pi, false)
      ..lineTo(shapeBounds.bottomRight.dx, shapeBounds.bottomRight.dy)
      ..lineTo(shapeBounds.topRight.dx, shapeBounds.topRight.dy)
      ..lineTo(0.0, shapeBounds.height - 100)
      ..quadraticBezierTo(shapeBounds.width / 4, shapeBounds.height,
          shapeBounds.width / 2, shapeBounds.height)
      ..quadraticBezierTo(shapeBounds.width - shapeBounds.width / 4,
          shapeBounds.height, shapeBounds.width, shapeBounds.height - 100)
      ..lineTo(shapeBounds.width, 0.0)
      ..close();

    canvas.drawPath(backgroundPath, paint);
  }
}
