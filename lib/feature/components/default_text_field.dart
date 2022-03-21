import 'package:flutter/material.dart';


class DefaultTextField extends StatelessWidget {
  const DefaultTextField({Key? key, required this.text, required this.textEditingController}) : super(key: key);
  final String text;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8)),
      child:  Padding(
        padding: EdgeInsets.only(left: 20.0, right: 10.0),
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: text,
              hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400),
              suffixIcon: Icon(
                Icons.search_rounded,
                color: Color(0xFFBDBDBD),
              )),
        ),
      ),
    );
  }
}
