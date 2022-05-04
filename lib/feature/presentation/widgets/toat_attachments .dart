import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../../../common/app_constants.dart';

/// auth
void toatAuth(String title, context) => BotToast.showSimpleNotification(
      title: title,
      hideCloseButton: true,
      backgroundColor: Theme.of(context).primaryColorLight,
      titleStyle: Theme.of(context).textTheme.bodyText1,
    );
