import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';

import '../../../common/app_constants.dart';

class OrderTextFieldWidget extends StatefulWidget {
  const OrderTextFieldWidget({Key? key, required this.field, required this.title, required this.function})
      : super(key: key);
  final String? field;
  final String title;
  final Function(String, String) function;

  @override
  _OrderTextFieldWidgetState createState() => _OrderTextFieldWidgetState();
}

class _OrderTextFieldWidgetState extends State<OrderTextFieldWidget> {
  bool _iconSee = false;
  final _controller = TextEditingController();

  bool validateName = false;

  @override
  void initState() {
    _controller.text = widget.field ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 75,
          child: Text(widget.title, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),),
        ),
        const SizedBox(width: kEdgeHorizontalPadding,),
        Expanded(
          child: TextFormField(
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
            onChanged: (value) async {
              if (value.length < 2) {
                setState(() {
                  validateName = true;
                });
              } else {
                setState(() {
                  validateName = false;
                });
                if (widget.field != _controller.text) {
                  widget.function(value, widget.title);
                }
              }
            },
            cursorColor: kMainBlueColor,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
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
}
