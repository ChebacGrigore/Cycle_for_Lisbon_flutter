import 'package:cfl/bloc/app/bloc/app_bloc.dart';
import 'package:cfl/routes/app_route.dart';
import 'package:cfl/shared/global/global_var.dart';
// import 'package:cfl/view/screens/home/single_initiative.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:cfl/view/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_route_paths.dart';

class InitiativeScreen extends StatefulWidget {
  const InitiativeScreen({super.key});

  @override
  State<InitiativeScreen> createState() => _InitiativeScreenState();
}

class _InitiativeScreenState extends State<InitiativeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppBloc>().add(AppListOfInitiatives(token: accessToken));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.status.isError) {
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
        }
      },
      builder: (context, state) {
        return BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status.isError) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.empty,
                      height: 150,
                    ),
                    const Center(
                      child: Text(
                        'No Initiative added yet!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.status.isAllInitiativesLoaded) {
              return state.initiatives.isEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.empty,
                            height: 150,
                          ),
                          const Center(
                            child: Text(
                              'No Initiative added yet!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          gradient: AppColors.whiteBgGradient),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 100,
                            top: 54,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 22),
                              Text(
                                'available_initiatives'.tr(),
                                style: GoogleFonts.dmSans(
                                  fontSize: 24,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.initiatives.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        // context.push(SingleInitiative(
                                        //   initiative: state.initiatives[index],
                                        // ));
                                        appRoutes.push(
                                            AppRoutePath.singleInitiative,
                                            extra: state.initiatives[index]);
                                      },
                                      child: InitiativeCard(
                                        initiative: state.initiatives[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            }
            return Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              height: MediaQuery.of(context).size.height,
              decoration:
                  const BoxDecoration(gradient: AppColors.whiteBgGradient),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 100,
                    top: 54,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 22),
                      Text(
                        'available_initiatives'.tr(),
                        style: GoogleFonts.dmSans(
                          fontSize: 24,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                // context.push(SingleInitiative(
                                //   initiative: state.initiatives[index],
                                // ));
                                appRoutes.push(AppRoutePath.singleInitiative,
                                    extra: state.initiatives[index]);
                              },
                              child: InitiativeCard(
                                initiative: state.initiatives[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
