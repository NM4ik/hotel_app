import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';
import 'package:hotel_ma/feature/presentation/components/profile_screen_components/profile_screen_info.dart';
import 'package:hotel_ma/feature/presentation/components/profile_screen_components/profile_screen_visits.dart';
import 'package:hotel_ma/feature/presentation/widgets/profile_text_filed_widget.dart';

import '../../../../common/app_constants.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';

class ProfileScreenAuth extends StatefulWidget {
  const ProfileScreenAuth({Key? key}) : super(key: key);

  @override
  _ProfileScreenAuthState createState() => _ProfileScreenAuthState();
}

class _ProfileScreenAuthState extends State<ProfileScreenAuth> with SingleTickerProviderStateMixin {
  late TabController tabController;
  UserModel userModel = UserModel.empty;
  final _nameController = TextEditingController();

  bool validateName = false;

  @override
  void initState() {
    userModel = locator.get<SqlRepository>().userFromSql();
    tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500),
    );
    super.initState();
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
              appBar: AppBar(
                title: Text(
                  'Профиль',
                  style: Theme.of(context).textTheme.headline1,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
                  child: Column(
                    children: [
                      ProfileTextFieldWidget(
                        title: 'Имя',
                        uid: state.userModel.uid,
                        fieldName: 'displayName',
                        fieldValue: userModel.displayName.toString(),
                        enable: true,
                      ),
                      ProfileTextFieldWidget(
                        title: 'Почта',
                        uid: state.userModel.uid,
                        fieldName: 'email',
                        fieldValue: userModel.email.toString(),
                        enable: true,
                      ),
                      ProfileTextFieldWidget(
                        title: 'Телефон',
                        uid: state.userModel.uid,
                        fieldName: 'phoneNumber',
                        fieldValue: userModel.phoneNumber.toString(),
                        enable: false,
                      ),

                      ElevatedButton(onPressed: () => print(locator.get<SqlRepository>().userFromSql()), child: Text('fetch')),
                      ElevatedButton(
                          onPressed: () async {
                            final user = await locator.get<FirestoreRepository>().getUserFromUserCollection(state.userModel.uid);
                            print(user.toString());
                          },
                          child: Text('getUser')),
                      ElevatedButton(onPressed: () => locator.get<AuthenticationRepository>().logOut(), child: Text('log')),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2.5, horizontal: kEdgeHorizontalPadding),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).primaryColorLight,
                      //       borderRadius: BorderRadius.circular(kEdgeMainBorder * 3),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(2.0),
                      //       child: TabBar(
                      //         indicator: BoxDecoration(
                      //           color: Theme.of(context).scaffoldBackgroundColor,
                      //           borderRadius: BorderRadius.circular(kEdgeMainBorder * 3),
                      //         ),
                      //         controller: tabController,
                      //         tabs: [
                      //           Tab(
                      //             child: Text(
                      //               'Информация',
                      //               style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                      //             ),
                      //           ),
                      //           Tab(
                      //             child: Text(
                      //               'Посещения',
                      //               style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: kEdgeHorizontalPadding),
                      //     child: TabBarView(
                      //       controller: tabController,
                      //       children: [
                      //         /// info
                      //         const SingleChildScrollView(
                      //           physics: BouncingScrollPhysics(),
                      //           child: ProfileScreenInfo(),
                      //         ),
                      //
                      //         ///visits
                      //         ProfileScreenVisits(uid: state.userModel.uid),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )));
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
