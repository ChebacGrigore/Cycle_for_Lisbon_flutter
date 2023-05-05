// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:cfl/view/screens/auth/signin.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.accentColor,
            floating: true,
            pinned: true,
            snap: true,
            expandedHeight: 240,
            title: Text(
              'Profile Settings',
              style: GoogleFonts.dmSans(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: HeaderClipper(
                      avatarRadius: 0,
                    ),
                    child: CustomPaint(
                      size: const Size.fromHeight(220),
                      painter: HeaderPainter(
                          color: AppColors.primaryColor, avatarRadius: 0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: const [
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: AppColors.tertiaryColor,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: AppColors.secondaryColor,
                              child: Icon(
                                Icons.photo_camera_outlined,
                                color: AppColors.primaryColor,
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
                          hint: 'First Name',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(height: 19),
                        AppTextField(
                          hint: 'Last Name',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(height: 19),
                        AppTextField(
                          hint: 'Nickname',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(height: 19),
                        AppTextField(
                          hint: 'Email',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(height: 29),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.primaryColor.withOpacity(0.10),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'CHANGE PASSWORD',
                              style: GoogleFonts.dmSans(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Divider(
                                color: AppColors.primaryColor.withOpacity(0.10),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 29),
                        AppTextField(
                          hint: 'Old Password',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(height: 19),
                        AppTextField(
                          hint: 'New Password',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(height: 19),
                        AppTextField(
                          hint: 'Confirm Password',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(height: 44),
                        SizedBox(
                          width: double.infinity,
                          height: 49,
                          child: ElevatedButton(
                              style: AppComponentThemes.elevatedButtonTheme(),
                              onPressed: () {},
                              child: const Text('Save Changes')),
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
