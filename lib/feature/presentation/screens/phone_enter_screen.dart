import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../bloc/login_phone_cubit/login_phone_cubit.dart';
import '../widgets/page_animation.dart';
import 'otp_screen.dart';

class PhoneEnterScreen extends StatefulWidget {
  const PhoneEnterScreen({Key? key}) : super(key: key);

  @override
  _PhoneEnterScreenState createState() => _PhoneEnterScreenState();
}

class _PhoneEnterScreenState extends State<PhoneEnterScreen> {
  late String phoneNumber;
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  String verificationIDReceived = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginPhoneCubit, LoginPhoneState>(
      listener: (context, state) {
        print('$state STATETETE');
        if (state is LoginPhoneLoadingState) {
          setState(() {
            loading = true;
          });
        }
        if (state is LoginPhoneCodeSentState) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).push(createRouteAnim(const OtpScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    child: GestureDetector(
                      child: const Icon(
                        Icons.close,
                        color: kMainBlueColor,
                      ),
                      onTap: Navigator.of(context).pop,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Text(
                    'Укажите телефон',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'RU',
                    onChanged: (phone) {
                      phoneNumber = phone.completeNumber;
                      print('$phoneNumber');
                    },
                    onSubmitted: (phone) async {
                      if (phone.length == 10) {
                        context.read<LoginPhoneCubit>().verifyNumber(phoneNumber);
                      }
                    },
                  ),
                  loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
