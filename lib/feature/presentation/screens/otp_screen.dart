import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/presentation/components/toat_attachments.dart';
import 'package:hotel_ma/feature/presentation/screens/get_user_info_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/router_screen.dart';
import 'package:pinput/pinput.dart';

import '../../data/repositories/auth_repository.dart';
import '../bloc/login_phone_cubit/login_phone_cubit.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);
  final String phoneNumber;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthenticationRepository authenticationRepository = AuthenticationRepository();

  bool loading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: Theme.of(context).textTheme.headline1,
      decoration: BoxDecoration(
        // color: Color.fromRGBO(232, 235, 241, 0.37),
        color: kMainBlueColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: kMainBlueColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return BlocConsumer<LoginPhoneCubit, LoginPhoneState>(
      listener: (context, state) {
        if (state is LoginPhoneFirstState) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GetUserInfoScreen(
                    user: state.user,
                  )));
        } else if (state is LoginPhoneLoggedInState) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const RouterScreen(
                        page: 4,
                      )),
              (route) => false);
        } else if (state is LoginPhoneLoadingState) {
          setState(() {
            loading = true;
          });
        } else if (state is LoginPhoneErrorState) {
          errorOtpCode('Вы ввели неверный смс-код', context);
          setState(() {
            loading = false;
          });
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
                      onTap: Navigator.of(context, rootNavigator: true).pop,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(
                    height: kEdgeVerticalPadding,
                  ),
                  Text(
                    'Теперь введите код',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: kEdgeVerticalPadding / 3,
                  ),
                  Text(
                    'Код отправили на номер',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
                  ),
                  Text(
                    widget.phoneNumber,
                    // widget.phoneNumber,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: kEdgeVerticalPadding),
                  Pinput(
                    length: 6,
                    controller: controller,
                    defaultPinTheme: defaultPinTheme,
                    separator: const SizedBox(width: 16),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
                            offset: Offset(0, 3),
                            blurRadius: 16,
                          )
                        ],
                      ),
                    ),
                    onSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      if (value.length == 6) {
                        context.read<LoginPhoneCubit>().verifyCode(value);
                      }
                    },
                    showCursor: true,
                    cursor: cursor,
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
