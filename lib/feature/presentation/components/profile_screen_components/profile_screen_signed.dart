import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';
import 'package:hotel_ma/feature/presentation/components/profile_screen_components/profile_screen_visits.dart';
import 'package:hotel_ma/feature/presentation/screens/information_screen.dart';
import 'package:hotel_ma/feature/presentation/widgets/profile_text_field_widget.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../common/app_constants.dart';
import '../../../data/datasources/sql_methods.dart';
import '../../../data/repositories/firestore_repository.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/office_bloc/office_bloc.dart';
import '../../widgets/defaut_button_widget.dart';
import '../../widgets/help_tile_widget.dart';

class ProfileScreenAuth extends StatefulWidget {
  const ProfileScreenAuth({Key? key}) : super(key: key);

  @override
  _ProfileScreenAuthState createState() => _ProfileScreenAuthState();
}

class _ProfileScreenAuthState extends State<ProfileScreenAuth> with SingleTickerProviderStateMixin {
  late bool isNotifications;
  late TabController tabController;
  UserModel userModel = UserModel.empty;
  final _nameController = TextEditingController();

  bool validateName = false;

  @override
  void initState() {
    userModel = locator.get<SqlRepository>().getUserFromSql();
    isNotifications = userModel.isNotifications ?? true;
    tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500),
    );

    setState(() {});
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileTextFieldWidget(
                        title: 'Имя',
                        uid: state.userModel.uid,
                        fieldName: 'name',
                        fieldValue: userModel.name ?? "",
                        enable: true,
                      ),
                      ProfileTextFieldWidget(
                        title: 'Почта',
                        uid: state.userModel.uid,
                        fieldName: 'email',
                        fieldValue: userModel.email ?? "",
                        enable: true,
                      ),
                      ProfileTextFieldWidget(
                        title: 'Телефон',
                        uid: state.userModel.uid,
                        fieldName: 'phoneNumber',
                        fieldValue: state.userModel.phoneNumber ?? "",
                        enable: true,
                      ),
                      const SizedBox(
                        height: kEdgeVerticalPadding / 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Уведомления',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Сообщать о бонусах, акцих и новых продуктах',
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 11),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Пуш-уведомления, эл.почта, смс',
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 11, color: kMainGreyColor),
                                  ),
                                ],
                              )),
                          const SizedBox(
                            width: kEdgeHorizontalPadding,
                          ),
                          FlutterSwitch(
                            width: 70,
                            height: 30,
                            valueFontSize: 9,
                            toggleSize: 14.0,
                            value: isNotifications,
                            borderRadius: 30.0,
                            padding: 8.0,
                            activeColor: kMainBlueColor,
                            inactiveColor: kMainGreyColor,
                            showOnOff: true,
                            activeText: "Вкл",
                            inactiveText: "Выкл",
                            onToggle: (value) {
                              setState(() {
                                isNotifications = !isNotifications;
                                locator.get<FirestoreRepository>().updateField(value, 'isNotifications', userModel.uid);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: kEdgeVerticalPadding,
                      ),
                      const HelpTile(whereTo: InformationScreen(), title: 'Информация', icon: Icons.info_outline_rounded),
                      HelpTile(whereTo: ProfileScreenVisits(uid: state.userModel.uid), title: 'Посещения', icon: Icons.event_available_rounded),
                      const Divider(
                        color: kMainGreyColor,
                      ),
                      TextButton(
                          onPressed: _logoutModal,
                          child: Text(
                            "Выход",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16, color: kMainBlueColor, fontWeight: FontWeight.w500),
                          )),
                      // ElevatedButton(onPressed: () => print(locator.get<SqlRepository>().getUserFromSql()), child: Text('fetch')),
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       final user = await locator.get<FirestoreRepository>().getUserFromUserCollection(state.userModel.uid);
                      //       print(user.toString());
                      //     },
                      //     child: Text('getUser')),
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

  void _logoutModal() {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kEdgeMainBorder),
                color: Theme.of(context).primaryColorLight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Вы действительно хотите выйти?',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Timer(const Duration(milliseconds: 400), () => context.read<AuthBloc>().add(AuthLogoutEvent()));
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'Выйти',
                        style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.red),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kEdgeVerticalPadding / 2,
            ),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kEdgeMainBorder),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: Center(
                    child: Text(
                      'Отменить',
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: kMainBlueColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
