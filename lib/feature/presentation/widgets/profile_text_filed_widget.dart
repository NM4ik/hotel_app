import 'package:flutter/material.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';

import '../../../common/app_constants.dart';

class ProfileTextFieldWidget extends StatefulWidget {
  const ProfileTextFieldWidget({Key? key, required this.field, required this.value, required this.uid}) : super(key: key);
  final String field;
  final String value;
  final String uid;

  @override
  _ProfileTextFieldWidgetState createState() => _ProfileTextFieldWidgetState();
}

class _ProfileTextFieldWidgetState extends State<ProfileTextFieldWidget> {
  final _nameController = TextEditingController();

  bool validateName = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      onFieldSubmitted: (value) async {
        if (value.length < 3) {
          setState(() {
            validateName = true;
          });
        } else {
          setState(() {
            validateName = false;
          });
          try {
            await locator.get<FirestoreRepository>().updateUser(widget.field, value, widget.uid);
            final userModel = locator.get<FirestoreRepository>();
            // locator.get<SqlRepository>().userToSql(userModel);
            print('EXCEPTION NONE');
          } catch (e) {
            print('EXCEPTION');
          }
        }
      },
      cursorColor: kMainBlueColor,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kMainBlueColor,
          ),
        ),
        errorText: validateName ? 'Слишком длинное значение для поля ${widget.field}' : null,
        labelText: widget.field,
        labelStyle: const TextStyle(color: kMainGreyColor),
      ),
    );
  }
}
