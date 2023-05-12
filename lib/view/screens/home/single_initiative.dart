import 'package:cfl/view/screens/home/home_screen.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:cfl/view/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleInitiative extends StatefulWidget {
  const SingleInitiative({super.key});

  @override
  State<SingleInitiative> createState() => _SingleInitiativeState();
}

class _SingleInitiativeState extends State<SingleInitiative> {
  bool isFullDesc = false;
  bool isFullInstNameDesc = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: AppColors.whiteBgGradient),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              foregroundColor: AppColors.accentColor,
              backgroundColor: AppColors.white,
              floating: true,
              pinned: true,
              centerTitle: true,
              snap: true,
              expandedHeight: 350,
              title: Text(
                'initiative_name'.tr(),
                style: GoogleFonts.dmSans(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          AppAssets.fishBg,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      color: AppColors.black.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            InitiativeProgress(progress: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${'sustainable_development_goals'.tr()}:',
                            style: GoogleFonts.dmSans(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: const [
                              ActivityBadge(
                                count: 3,
                                title: 'Climate Action',
                                icon: Icons.cloud,
                                color: AppColors.cabbageGreen,
                              ),
                              SizedBox(width: 6),
                              ActivityBadge(
                                count: 3,
                                title: 'Climate Action',
                                icon: Icons.cloud,
                                color: AppColors.blueGrey,
                              ),
                              SizedBox(width: 6),
                              ActivityBadge(
                                  count: 3,
                                  title: 'Climate Action',
                                  icon: Icons.cloud),
                            ],
                          ),
                          const SizedBox(height: 42),
                          Text(
                            '${'about_initiative'.tr()}:',
                            style: GoogleFonts.dmSans(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            height: isFullDesc == true ? 100 : 50,
                            width: double.infinity,
                            child: Text(
                              'Purus sit amet luctus venenatis, lectus magna fringilla urna, porttitor rhoncus dolor purus non enim praesent elementum facilisis leo.Faucibus faucibus lectus nibh hendrerit. Et cursus egestas blandit nibh vitae risus rhonc dolor tellus',
                              overflow: TextOverflow.ellipsis,
                              maxLines: isFullDesc == true ? 100 : 5,
                              style: GoogleFonts.dmSans(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton.icon(
                            onPressed: () {
                              isFullDesc = !isFullDesc;
                              setState(() {});
                            },
                            icon: Text(
                                isFullDesc == true ? 'Read Less' : 'Read More'),
                            label: Icon(
                              isFullDesc == true
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              size: 15,
                            ),
                          ),
                          const SizedBox(height: 42),
                          Text(
                            'Institution Name:',
                            style: GoogleFonts.dmSans(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.tertiaryColor,
                            ),
                            width: double.infinity,
                            height: 140,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.home_repair_service),
                                const SizedBox(width: 20),
                                Text(
                                  'lisboa'.toUpperCase(),
                                  style: GoogleFonts.dmSans(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: isFullInstNameDesc == true ? 100 : 50,
                            width: double.infinity,
                            child: Text(
                              'Purus sit amet luctus venenatis, lectus magna fringilla urna, porttitor rhoncus dolor purus non enim praesent elementum facilisis leo. Faucibus faucibus lectus nibh hendrerit. Et cursus egestas blandit nibh vitae risus rhonc dolor tellus',
                              overflow: TextOverflow.ellipsis,
                              maxLines: isFullInstNameDesc == true ? 100 : 5,
                              style: GoogleFonts.dmSans(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton.icon(
                            onPressed: () {
                              isFullInstNameDesc = !isFullInstNameDesc;
                              setState(() {});
                            },
                            icon: Text(isFullInstNameDesc == true
                                ? 'Read Less'
                                : 'Read More'),
                            label: Icon(
                              isFullDesc == true
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              size: 15,
                            ),
                          ),
                          const SizedBox(height: 42),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(height: 42),
                          Text(
                            '${'sponsors'.tr()}:',
                            style: GoogleFonts.dmSans(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(AppAssets.shopify),
                              const SizedBox(width: 30),
                              SvgPicture.asset(AppAssets.loom),
                              const SizedBox(width: 30),
                              SvgPicture.asset(AppAssets.unsplash),
                            ],
                          ),
                          const SizedBox(height: 42),
                          SizedBox(
                            width: double.infinity,
                            height: 49,
                            child: ElevatedButton(
                              style: AppComponentThemes.elevatedButtonTheme(),
                              onPressed: () {},
                              child: Text(
                                'support_initiative'.tr(),
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
