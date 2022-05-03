import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../widgets/page_animation.dart';
import 'otp_screen.dart';

class PhoneEnterScreen extends StatefulWidget {
  const PhoneEnterScreen({Key? key}) : super(key: key);

  @override
  _PhoneEnterScreenState createState() => _PhoneEnterScreenState();
}

class _PhoneEnterScreenState extends State<PhoneEnterScreen> {
  late String phoneNumber;

  @override
  Widget build(BuildContext context) {
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
                  print(phone.completeNumber);
                },
                onSubmitted: (phone) {
                  Navigator.of(context).push(createRouteAnim(OtpScreen(
                    phoneNumber: phoneNumber,
                  )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
