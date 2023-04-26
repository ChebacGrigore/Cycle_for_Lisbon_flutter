import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello, jane123',
                      style: GoogleFonts.dmSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1616166336303-8e1b0e2e1b1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: PillContainer(
                        title: 'Total Earned',
                        count: 13,
                        icon: Icons.arrow_upward,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: PillContainer(
                        title: 'Total km',
                        count: 50,
                        icon: Icons.arrow_downward,
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
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: InitiativeCard(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InitiativeCard extends StatelessWidget {
  const InitiativeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(AppAssets.bg01Png),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kayaku',
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    color: AppColors.white.withOpacity(0.80),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cycling for a better world',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eget augue nec massa volutpat aliquam fringilla.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: AppColors.white.withOpacity(0.80),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 21),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ActvityCount(
                    count: 13,
                    title: 'Goal',
                  ),
                  SizedBox(height: 4),
                  ActvityCount(
                    count: 13,
                    title: 'Collected',
                  ),
                ],
              ),
              // builder here
              Row(
                children: const [
                  ActivityBadge(
                    count: 13,
                    title: 'Goal',
                    icon: Icons.arrow_upward,
                  ),
                  SizedBox(width: 10),
                  ActivityBadge(
                    count: 3,
                    title: 'Fine',
                    icon: Icons.downhill_skiing,
                    color: AppColors.secondaryColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActivityBadge extends StatelessWidget {
  const ActivityBadge({
    this.color,
    required this.count,
    required this.title,
    required this.icon,
    super.key,
  });
  final Color? color;
  final int count;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color ?? AppColors.tomatoRed,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                count.toString(),
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.dmSans(
                  fontSize: 10,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          Icon(icon, color: AppColors.white, size: 10),
        ],
      ),
    );
  }
}

class ActvityCount extends StatelessWidget {
  const ActvityCount({
    super.key,
    required this.count,
    required this.title,
  });
  final int count;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.monetization_on_sharp,
          color: AppColors.secondaryColor,
          size: 10,
        ),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class PillContainer extends StatelessWidget {
  const PillContainer({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
  });
  final String title;
  final int count;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 27,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: AppColors.tertiaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppColors.primaryColor.withOpacity(0.80),
            ),
          ),
          const SizedBox(width: 6),
          Icon(
            icon,
            color: AppColors.secondaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            count.toString(),
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}