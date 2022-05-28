import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/presentation/widgets/defaut_button_widget.dart';

import '../../bloc/rooms_bloc/rooms_bloc.dart';

class RoomsUsicScreen extends StatelessWidget {
  const RoomsUsicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomsBloc, RoomsState>(
      listener: (context, state) {
        if (state is RoomsSICState) {
          log('Соеденение восстановлено в RoomsScreen (rooms_usic_screen)');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/no_internet_ill.png.png'),
              const SizedBox(height: kEdgeVerticalPadding/2,),
              Text(
                'Не удалось загрузить',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: kEdgeVerticalPadding/2,),
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: DefaultButtonWidget(
                    press: () {
                      context.read<RoomsBloc>().add(RoomsCheckConnectionEvent());
                    },
                    title: 'Повторить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
