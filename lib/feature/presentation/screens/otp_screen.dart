import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';

import '../widgets/page_animation.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: Theme.of(context).textTheme.headline1,
      decoration: BoxDecoration(
        // color: Color.fromRGBO(232, 235, 241, 0.37),
        color: kMainBlueColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
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
                        'Телефон',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  onTap: Navigator.of(context).pop,
                ),
                alignment: Alignment.centerLeft,
              ),
              Text(
                'Теперь введите код',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Код отправили на номер',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                widget.phoneNumber,
                style: Theme.of(context).textTheme.headline3,
              ),
              Pinput(
                length: 4,
                controller: controller,
                focusNode: focusNode,
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
                onSubmitted: (value){
                  print(value);
                },
                onChanged: (value){
                  ///when 4 => request to firebase
                  print(value.length);
                },
                showCursor: true,
                cursor: cursor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
