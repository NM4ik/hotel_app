import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:hotel_ma/feature/presentation/components/toat_attachments.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../components/profile_screen_components/profile_screeen_unsigned.dart';
import '../components/profile_screen_components/profile_screen_signed.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // if (state is UnAuthenticatedState) {
        //   toatAuth("До свидания!", context);
        // } // yes or no?
      },
      builder: (context, state) {
        if (state is UnAuthenticatedState) {
          return const ProfileScreenUnAuth();
        }
        if (state is AuthenticatedState) {
          return const ProfileScreenAuth();
        } else {
          return const Center(
            child: Text('Что-то пошло не так'),
          );

          /// need to find this exception
        }
      },
    );
  }
}
