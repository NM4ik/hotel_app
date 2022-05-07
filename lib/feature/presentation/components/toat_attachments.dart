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

/// update profile_fields
void updateProfileFields(String field, context) => BotToast.showSimpleNotification(
      title: 'поле $field успешно обновлено',
      hideCloseButton: true,
      // backgroundColor: Theme.of(context).primaryColorLight,
      backgroundColor: Colors.green,
      titleStyle: Theme.of(context).textTheme.bodyText1,
    );

void nonUpdateProfileFields(String field, context) => BotToast.showSimpleNotification(
      title: 'поле $field не обновлено',
      hideCloseButton: true,
      backgroundColor: Colors.red,
      titleStyle: Theme.of(context).textTheme.bodyText1,
    );
