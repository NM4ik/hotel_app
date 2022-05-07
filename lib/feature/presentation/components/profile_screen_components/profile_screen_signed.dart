import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/feature/presentation/components/profile_screen_components/profile_screen_info.dart';
import 'package:hotel_ma/feature/presentation/components/profile_screen_components/profile_screen_visits.dart';

import '../../../../common/app_constants.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';

class ProfileScreenAuth extends StatefulWidget {
  const ProfileScreenAuth({Key? key}) : super(key: key);

  @override
  _ProfileScreenAuthState createState() => _ProfileScreenAuthState();
}

class _ProfileScreenAuthState extends State<ProfileScreenAuth> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  int initPosition = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width / 1.2,
                        decoration: const BoxDecoration(
                          color: kMainBlueColor,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                        ),
                      ),
                      SafeArea(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                // '${state.userModel.displayName}',
                                'Профиль',
                                // '${state.user.email}',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
                              ),
                            ),
                            // const SizedBox(
                            //   height: kEdgeVerticalPadding,
                            // ),
                            // GestureDetector(
                            //   onTap: () async {
                            //     SharedPreferences prefs = await SharedPreferences.getInstance();
                            //     PersonStatus personStatus = PersonStatus(sharedPreferences: prefs);
                            //     personStatus.getPersonFromCache();
                            //     AuthenticationRepository authenticationRepository = AuthenticationRepository();
                            //     // print(authenticationRepository.userModel);
                            //   },
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(99),
                            //       border: Border.all(color: Colors.white, width: 2),
                            //     ),
                            //     child: ClipRRect(
                            //         borderRadius: BorderRadius.circular(99),
                            //         child: Image.network(
                            //           '${state.userModel.photoURL}',
                            //           fit: BoxFit.contain,
                            //         )),
                            //   ),
                            // ),
                            const SizedBox(
                              height: kEdgeVerticalPadding / 2,
                            ),
                            Column(
                              children: [
                                Text(
                                  state.userModel.uid.toString(),
                                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  'Я тут новенький',
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2.5, horizontal: kEdgeHorizontalPadding),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(kEdgeMainBorder * 3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TabBar(
                          indicator: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(kEdgeMainBorder * 3),
                          ),
                          controller: tabController,
                          tabs: [
                            Tab(
                              child: Text(
                                'Информация',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Посещения',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: kEdgeHorizontalPadding),
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          /// info
                          const SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: ProfileScreenInfo(),
                          ),

                          ///visits
                          ProfileScreenVisits(uid: state.userModel.uid),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        } else {
          return Center(
            child: Text(
              "Что-то пошло не так...",
              style: Theme.of(context).textTheme.headline3,
            ),
          );
        }
      },
    );
  }
}
