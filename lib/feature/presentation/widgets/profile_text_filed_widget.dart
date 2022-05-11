import 'package:flutter/material.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';

import '../../../common/app_constants.dart';

class ProfileTextFieldWidget extends StatefulWidget {
  const ProfileTextFieldWidget({Key? key, required this.title, required this.uid, required this.fieldValue, required this.fieldName, required this.enable})
      : super(key: key);
  final String fieldValue;
  final String fieldName;
  final String title;
  final String uid;
  final bool enable;

  @override
  _ProfileTextFieldWidgetState createState() => _ProfileTextFieldWidgetState();
}

class _ProfileTextFieldWidgetState extends State<ProfileTextFieldWidget> {
  bool _iconSee = false;
  final _controller = TextEditingController();

  bool validateName = false;

  @override
  void initState() {
    _controller.text = widget.fieldValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(color: kMainGreyColor, fontSize: 11, fontFamily: "Inter"),
        ),
        SizedBox(
          height: 30,
          child: TextFormField(
            enabled: widget.enable,
            controller: _controller,
            onTap: () {
              setState(() {
                _iconSee = true;
              });
            },
            onEditingComplete: () {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {
                _iconSee = false;
              });
            },
            onFieldSubmitted: (value) async {
              if (value.length < 2) {
                setState(() {
                  validateName = true;
                });
              } else {
                setState(() {
                  validateName = false;
                });
                if (widget.fieldValue != _controller.text) {
                  _updateField(value);
                }
              }
            },
            cursorColor: kMainBlueColor,
            decoration: InputDecoration(
                suffixIcon: _iconSee
                    ? IconButton(
                        onPressed: _controller.clear,
                        icon: const Icon(
                          Icons.clear,
                          size: 16,
                          color: kMainBlueColor,
                        ),
                      )
                    : null,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorText: validateName ? 'Слишком длинное или короткое значение для поля: ${widget.title}' : null,
                errorStyle: const TextStyle(fontSize: 10)),
          ),
        ),
        const Divider(
          color: kMainGreyColor,
        ),
      ],
    );
  }

  void _updateField(String value) async {
    try {
      await locator.get<FirestoreRepository>().updateUser(widget.fieldName, value, widget.uid);
      final userModel = await locator.get<FirestoreRepository>().getUserFromUserCollection(widget.uid);
      locator.get<SqlRepository>().userToSql(userModel);
      print('EXCEPTION NONE');
    } catch (e) {
      print('EXCEPTION');
    }
  }
}
