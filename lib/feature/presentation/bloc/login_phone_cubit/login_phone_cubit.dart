import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';
import 'package:meta/meta.dart';

import '../../../../core/locator_service.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/firestore_repository.dart';

part 'login_phone_state.dart';

class LoginPhoneCubit extends Cubit<LoginPhoneState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  LoginPhoneCubit() : super(LoginPhoneInitialState());

  String? _verificationId;

  Future<void> verifyNumber(String phoneNumber) async {
    emit(LoginPhoneLoadingState());
    print('QWEQWEQWE');
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException exception) {
          emit(LoginPhoneErrorState(message: exception.message.toString()));
        },
        codeSent: (String verificationId, int? resendToken) {
          print('PHONE $phoneNumber');
          _verificationId = verificationId;
          emit(LoginPhoneCodeSentState());
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          _verificationId = verificationID;
        });
  }

  void verifyCode(String smsCode) async {
    emit(LoginPhoneLoadingState());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: smsCode);
      final user = await _firebaseAuth.signInWithCredential(credential);

      if (user.user != null) {
        final userModel = await locator.get<FirestoreRepository>().personToUserCollection(UserModel.toUser(user.user));
        log(userModel.toString(), name: "USERMODEL");

        if (user.additionalUserInfo?.isNewUser == true) {
          // emit(LoginPhoneFirstState(user: UserModel.toUser(user.user))); /// fix otp screen :D
          if (userModel == null) {
            locator.get<SqlRepository>().userToSql(UserModel.toUser(user.user));
          } else {
            locator.get<SqlRepository>().userToSql(userModel);
          }
          emit(LoginPhoneLoggedInState());
        } else {
          if (userModel == null) {
            locator.get<SqlRepository>().userToSql(UserModel.toUser(user.user));
          } else {
            locator.get<SqlRepository>().userToSql(userModel);
          }
          emit(LoginPhoneLoggedInState());
        }
      }
    } on FirebaseAuthException catch (ex) {
      emit(LoginPhoneErrorState(message: ex.message.toString()));
    }
  }
}
