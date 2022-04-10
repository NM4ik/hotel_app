import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:hotel_ma/feature/presentation/widgets/defaut_button_widget.dart';
import 'package:hotel_ma/feature/presentation/widgets/row_table_widget.dart';

import '../../../../common/app_constants.dart';
import '../../../../core/locator_service.dart';
import '../../../data/datasources/shared_preferences_methods.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';

class ProfileScreenInfo extends StatefulWidget {
  const ProfileScreenInfo({Key? key}) : super(key: key);

  @override
  State<ProfileScreenInfo> createState() => _ProfileScreenInfoState();
}

class _ProfileScreenInfoState extends State<ProfileScreenInfo> {

  bool? notificationStatus = locator.get<PersonStatus>().getNotifications();
  AuthenticationRepository authenticationRepository = AuthenticationRepository();

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
      child: Column(
        children: [
          const RowTableWidget(title: 'Имя', query: 'Никита',),
          SizedBox(height: 1, child: Opacity(opacity: 0.5, child: Container(color: kMainGreyColor,)),),
          const RowTableWidget(title: 'Фамилия', query: 'Михайлов',),
          SizedBox(height: 1, child: Opacity(opacity: 0.5, child: Container(color: kMainGreyColor,)),),
          const RowTableWidget(title: 'Отчество', query: 'Ярославович',),
          SizedBox(height: 1, child: Opacity(opacity: 0.5, child: Container(color: kMainGreyColor,)),),
          const RowTableWidget(title: 'Email', query: 'nikitka32171@gmail.com',),
          SizedBox(height: 1, child: Opacity(opacity: 0.5, child: Container(color: kMainGreyColor,)),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 3, child: Text('Уведомления', style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16),)),
              const SizedBox(width: kEdgeHorizontalPadding,),

              FlutterSwitch(
                width: 70,
                height: 30,
                valueFontSize: 9,
                toggleSize: 14.0,
                value: notificationStatus!,
                borderRadius: 30.0,
                padding: 8.0,
                activeColor: kMainBlueColor,
                inactiveColor: kMainGreyColor,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    locator.get<PersonStatus>().setNotificationStatus(val);
                    notificationStatus = val;
                  });
                },
              ),

              const SizedBox(height: 50,),
            ],
          ),
          SizedBox(height: 1, child: Opacity(opacity: 0.5, child: Container(color: kMainGreyColor,)),),

          const SizedBox(height: kEdgeVerticalPadding,),

          SizedBox(width: 170, height: 35, child: DefaultButtonWidget(press: () {
            context.read<AuthBloc>().add(AuthLogoutEvent());
          }, title: 'Выйти',)),


        ],
      ),
    );
  }
}
