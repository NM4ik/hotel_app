import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:hotel_ma/feature/presentation/screens/information_screen.dart';
import 'package:hotel_ma/feature/presentation/widgets/help_tile_widget.dart';
import 'package:hotel_ma/feature/presentation/widgets/page_animation.dart';

import '../../bloc/office_bloc/office_bloc.dart';
import '../../screens/phone_enter_screen.dart';
import '../../screens/router_screen.dart';
import '../toat_attachments.dart';

class ProfileScreenUnAuth extends StatelessWidget {
  const ProfileScreenUnAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authenticationRepository = AuthenticationRepository();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // if (state is AuthenticatedState) {
        //   toatAuth("Здравствуйте, ${state.userModel.name ?? state.userModel.phoneNumber}", context);
        // }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Давай знакомиться!',
                      style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, fontSize: 21, fontFamily: "Inter")),
                  const SizedBox(
                    height: kEdgeVerticalPadding / 2,
                  ),
                  Text('Войдите, чтобы заказывать услуги, отслеживать посещения и общаться с поддержкой',
                      textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13)),
                  const SizedBox(
                    height: kEdgeVerticalPadding,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kEdgeMainBorder)),
                        // primary: Colors.white,
                        primary: kMainBlueColor,
                        elevation: 2,
                      ),
                      onPressed: () async {
                        try {
                          await authenticationRepository.singInWithGoogle();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const RouterScreen(
                                    page: null,
                                  )),
                                  (route) => false);
                          toatAuth("Успешная авторизация", context);
                        } catch (e) {
                          log('$e', name: 'error auth');
                          toatAuth("Неуспешная авторизация", context);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sign in with Google",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: "Inter", color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/images/google_logo.png",
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kEdgeVerticalPadding / 2,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kEdgeMainBorder)),
                        // primary: Colors.white,
                        primary: kMainBlueColor,
                        elevation: 2,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(createRouteAnimFromBottom(const PhoneEnterScreen()));
                      },
                      child: const Text(
                        'Войти по телефону',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: "Inter", color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kEdgeVerticalPadding,
                  ),
                  const HelpTile(whereTo: InformationScreen(), title: 'Информация', icon: Icons.info_outline_rounded)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
