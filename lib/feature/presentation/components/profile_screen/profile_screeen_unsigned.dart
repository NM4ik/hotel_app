import 'dart:convert';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:hotel_ma/feature/presentation/widgets/defaut_button_widget.dart';
import 'package:hotel_ma/feature/presentation/widgets/page_animation.dart';

import '../../../data/datasources/shared_preferences_methods.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';
import '../../screens/phone_enter_screen.dart';

class ProfileScreenUnAuth extends StatelessWidget {
  const ProfileScreenUnAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authenticationRepository = AuthenticationRepository();

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      child: Stack(children: [
        Align(
          alignment: Alignment(-1.2, -1.2),
          child: Image.asset(
            'assets/images/un_auth_image.png',
            width: 300,
            height: 300,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   title: Text('Профиль', style: Theme.of(context).textTheme.headline1),
          //   centerTitle: true,
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          // ),
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
                        onPressed: () {
                          try {
                            authenticationRepository.singInWithGoogle();
                          } catch (e) {
                            log('$e', name: 'error auth');
                          }
                        },
                        child: const Text(
                          'Войти',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: "Inter", color: Colors.white),
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
                          Navigator.of(context).push(createRouteAnim(PhoneEnterScreen()));
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
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: kMainBlueColor,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text('Информация', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
