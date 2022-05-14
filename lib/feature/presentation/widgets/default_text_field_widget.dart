import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_constants.dart';

class DefaultTextFieldWidget extends StatefulWidget {
  const DefaultTextFieldWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<DefaultTextFieldWidget> createState() => _DefaultTextFieldWidgetState();
}

class _DefaultTextFieldWidgetState extends State<DefaultTextFieldWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(kEdgeMainBorder)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: widget.text,
              hintStyle: const TextStyle(color: kMainGreyColor, fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400),
              suffixIcon: const Icon(
                Icons.search_rounded,
                color: Color(0xFFBDBDBD),
              )),
        ),
      ),
    );
  }
}
