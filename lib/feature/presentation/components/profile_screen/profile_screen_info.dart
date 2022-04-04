import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/feature/presentation/widgets/defaut_button_widget.dart';
import 'package:hotel_ma/feature/presentation/widgets/row_table_widget.dart';

import '../../../../common/app_constants.dart';
import '../../../../core/locator_service.dart';
import '../../../data/datasources/shared_preferences_methods.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';

class ProfileScreenInfo extends StatelessWidget {
  const ProfileScreenInfo({Key? key}) : super(key: key);

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
              const Expanded(
                child: TextField(decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'on/off',
                  hintStyle: TextStyle(fontSize: 16, color: kMainGreyColor, fontWeight: FontWeight.w400),
                )),
              ),
              const SizedBox(height: 50,),
            ],
          ),
          SizedBox(height: 1, child: Opacity(opacity: 0.5, child: Container(color: kMainGreyColor,)),),

          const SizedBox(height: kEdgeVerticalPadding,),

          SizedBox(width: 170, height: 35, child: DefaultButtonWidget(press: () {
            locator.get<PersonStatus>().setStatus(false);
            context.read<ProfileBloc>().add(ProfileAuthEvent());
          }, title: 'Выйти',)),


        ],
      ),
    );
  }
}
