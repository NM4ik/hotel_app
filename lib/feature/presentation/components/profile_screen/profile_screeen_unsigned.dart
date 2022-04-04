import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/presentation/widgets/defaut_button_widget.dart';

import '../../../data/datasources/shared_preferences_methods.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';

class ProfileScreenUnAuth extends StatelessWidget {
  const ProfileScreenUnAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
  listener: (context, state) {
    if(state is ProfileAuthenticatedState){
      print('LogIn');
    }
    if(state is ProfileUnAuthenticatedState){
      print('LogOut');
    }
  },
  child: Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: Theme.of(context).textTheme.headline1),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/un_auth_image.png'),
                const SizedBox(height: kEdgeVerticalPadding/2,),
                Text('Давай знакомиться!', style: Theme.of(context).textTheme.headline1),
                const SizedBox(height: kEdgeVerticalPadding,),

                SizedBox(width: 300, child: DefaultButtonWidget(press: () {}, title: 'Войти по номеру телефона')),
                const SizedBox(height: kEdgeVerticalPadding/2,),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                        primary: Colors.white,
                        elevation: 2,
                      ),
                      onPressed: () {
                        locator.get<PersonStatus>().setStatus(true);
                        context.read<ProfileBloc>().add(ProfileAuthEvent());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google_logo.png', width: 30),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Sign in with google',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: "Inter", color: Colors.black),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    ),
);
  }
}