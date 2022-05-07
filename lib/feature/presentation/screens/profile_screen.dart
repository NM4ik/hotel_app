import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/feature/presentation/bloc/auth_bloc/auth_bloc.dart';

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
    return BlocBuilder<AuthBloc, AuthState>(
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
        }
      },
    );
  }
}
