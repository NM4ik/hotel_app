import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/login_phone_cubit/login_phone_cubit.dart';
import 'package:hotel_ma/feature/presentation/bloc/login_phone_cubit/login_phone_cubit.dart';
import 'package:hotel_ma/feature/presentation/screens/router_screen.dart';

import '../../../common/app_constants.dart';

class GetUserInfoScreen extends StatefulWidget {
  const GetUserInfoScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  _GetUserInfoScreenState createState() => _GetUserInfoScreenState();
}

class _GetUserInfoScreenState extends State<GetUserInfoScreen> {
  TextEditingController nameController = TextEditingController();
  String name = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginPhoneCubit, LoginPhoneState>(
      listener: (context, state) {
        if (state is LoginPhoneLoggedInState) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const RouterScreen(
                        page: null,
                      )),
              (route) => false);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
          child: SafeArea(
            child: Column(children: [
              Align(
                child: GestureDetector(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: kMainBlueColor,
                      ),
                      Text(
                        'назад',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  onTap: () async {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RouterScreen(page: null)), (route) => false);
                  },
                ),
                alignment: Alignment.centerLeft,
              ),
              TextField(
                onChanged: (inputValue) {
                  name = inputValue;
                  log(name, name: "NAME");
                },
                decoration: const InputDecoration(
                  label: Text("Имя"),
                  labelStyle: TextStyle(color: kMainGreyColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (inputValue) {
                  email = inputValue;
                  log(email, name: "NAME");
                },
                decoration: const InputDecoration(
                  label: Text("Почта"),
                  labelStyle: TextStyle(color: kMainGreyColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  locator.get<AuthenticationRepository>().setUpAccount(widget.user.uid, email, name);
                  context.read<LoginPhoneCubit>().updateUser(widget.user);
                },
                child: const Text('Далее'),
                style: ElevatedButton.styleFrom(primary: kMainBlueColor),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
