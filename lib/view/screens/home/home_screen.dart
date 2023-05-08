import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/home/map.dart';
import 'package:cfl/view/screens/profile/profile_screen.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:cfl/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InitiativeState state = InitiativeState.initial;
  bool showProfile = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16, right: 16, top: 16, bottom: 200),
            child: homeBuilder(),
          ),
        ),
      ),
    );
  }

  Widget homeBuilder() {
    if (state == InitiativeState.initial) {
      return _buildInitialInitiative();
    }
    if (state == InitiativeState.selected) {
      return _buildSelectedInitiative();
    }
    if (state == InitiativeState.completed) {
      return _buildCompletedInitiative();
    }
    return const SizedBox();
  }

  Widget _buildInitialInitiative() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileButton(
          onTap: () {
            context.push(const ProfileScreen());
          },
          greeting: 'Hello',
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(
              child: PillContainer(
                title: 'Total Earned',
                count: 13,
                icon: CFLIcons.coin1,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: PillContainer(
                title: 'Total km',
                count: 50,
                icon: CFLIcons.roadhz,
              ),
            ),
          ],
        ),
        const SizedBox(height: 42),
        Text(
          'Let\'s start cycling?',
          style: GoogleFonts.dmSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Choose your initiative',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.primaryColor.withOpacity(0.80),
          ),
        ),
        const SizedBox(height: 24),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    state = InitiativeState.completed;
                    //pass selected initiative
                  });
                },
                child: const InitiativeCard(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSelectedInitiative() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileButton(
          onTap: () {
            context.push(const ProfileScreen());
          },
          greeting: 'Welcome Back',
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(
              child: PillContainer(
                title: 'Total Earned',
                count: 13,
                icon: CFLIcons.coin1,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: PillContainer(
                title: 'Total km',
                count: 50,
                icon: CFLIcons.roadhz,
              ),
            ),
          ],
        ),
        const SizedBox(height: 42),
        const SelectedInitiativeCard(progress: 0.4),
        const SizedBox(height: 32),
        Text(
          'Your Contribution for All Time:',
          style: GoogleFonts.dmSans(
            color: AppColors.primaryColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            ContributionCard(
              icon: CFLIcons.roadhz,
              count: 12,
              title: 'km',
            ),
            ContributionCard(
              icon: CFLIcons.clock,
              count: 5,
              title: 'h',
            ),
            ContributionCard(
              icon: CFLIcons.coin1,
              count: 20,
              title: 'Coins',
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'Your Last Ride:',
          style: GoogleFonts.dmSans(
            color: AppColors.primaryColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.black.withOpacity(.05),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const MapScreen()),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            ContributionCard(
              icon: CFLIcons.roadhz,
              count: 12,
              title: 'km',
            ),
            ContributionCard(
              icon: CFLIcons.clock,
              count: 5,
              title: 'h',
            ),
            ContributionCard(
              icon: CFLIcons.coin1,
              count: 20,
              title: 'Coins',
            ),
          ],
        ),
        const SizedBox(height: 42),
        SizedBox(
          width: double.infinity,
          height: 49,
          child: ElevatedButton(
            style: AppComponentThemes.elevatedButtonTheme(
              color: AppColors.cabbageGreen,
            ),
            onPressed: () {},
            child: Text(
              'Start/Stop',
              style: GoogleFonts.dmSans(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                state = InitiativeState.initial;
              });
            },
            child: Text(
              'Change Initiative',
              style: GoogleFonts.dmSans(
                decoration: TextDecoration.underline,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedInitiative() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileButton(
          onTap: () {
            context.push(const ProfileScreen());
          },
          greeting: 'Hello',
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(
              child: PillContainer(
                title: 'Total Earned',
                count: 13,
                icon: CFLIcons.coin1,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: PillContainer(
                title: 'Total km',
                count: 50,
                icon: CFLIcons.roadhz,
              ),
            ),
          ],
        ),
        const SizedBox(height: 42),
        const SelectedInitiativeCard(
          progress: 1,
        ),
        const SizedBox(height: 32),
        RichText(
          text: TextSpan(
            text: 'Thank you for your support! This goal was completed. ',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.primaryColor,
            ),
            children: [
              TextSpan(
                text: ' Want to select a new one?',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 42),
        Text(
          'Available Initiatives',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    state = InitiativeState.selected;
                    //pass selected initiative
                  });
                },
                child: const InitiativeCard(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    this.onTap,
    super.key,
    required this.greeting,
  });
  final VoidCallback? onTap;
  final String greeting;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            greeting.contains('Welcome')
                ? '$greeting,\n jane123'
                : '$greeting, Jane123',
            style: GoogleFonts.dmSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: const CircleAvatar(
              radius: 23,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1616166336303-8e1b0e2e1b1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
            ),
          ),
        ],
      ),
    );
  }
}

class ContributionCard extends StatelessWidget {
  const ContributionCard({
    super.key,
    required this.icon,
    required this.count,
    required this.title,
  });
  final IconData icon;

  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: AppColors.tertiaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppColors.accentColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$count $title',
          style: GoogleFonts.dmSans(),
        ),
      ],
    );
  }
}

class SelectedInitiativeCard extends StatelessWidget {
  const SelectedInitiativeCard({required this.progress, Key? key})
      : super(key: key);
  final double progress;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage(AppAssets.bg01Png),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name of cause',
            style: GoogleFonts.dmSans(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          InitiativeProgress(progress: progress),
        ],
      ),
    );
  }
}

class InitiativeProgress extends StatelessWidget {
  const InitiativeProgress({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            progress != 1
                ? const InitiativeCounter2(
                    title: 'Collected',
                    count: 24,
                  )
                : Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.accentColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Completed',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
            const InitiativeCounter2(
              title: 'Goal',
              count: 1230,
            ),
          ],
        ),
        const SizedBox(height: 9),
        SizedBox(
          height: 16,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.tertiaryColor.withOpacity(0.20),
            ),
          ),
        ),
      ],
    );
  }
}

class InitiativeCounter2 extends StatelessWidget {
  const InitiativeCounter2({
    required this.count,
    required this.title,
    super.key,
  });
  final String title;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.dmSans(
            color: AppColors.white.withOpacity(0.50),
            fontSize: 12,
          ),
        ),
        Row(
          children: [
            const Icon(
              CFLIcons.coin1,
              color: AppColors.accentColor,
            ),
            const SizedBox(width: 4),
            Text(
              count.toString(),
              style: GoogleFonts.dmSans(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}

enum InitiativeState {
  selected,
  completed,
  initial,
}
