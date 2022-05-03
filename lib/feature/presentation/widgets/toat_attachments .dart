import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../../../common/app_constants.dart';

void toatAuth(String title){
  BotToast.showSimpleNotification(
    title: title,
    // backgroundColor: kMainBlueColor,
    hideCloseButton: true,
    backgroundColor: Colors.white,
  );
}

