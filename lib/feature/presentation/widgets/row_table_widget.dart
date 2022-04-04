import 'package:flutter/material.dart';

import '../../../common/app_constants.dart';

class RowTableWidget extends StatelessWidget {
  const RowTableWidget({Key? key, required this.title, this.query}) : super(key: key);
  final String title;
  final String? query;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 75,
          child: Text(title, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),),
        ),
        const SizedBox(width: kEdgeHorizontalPadding,),
        Expanded(
          child: TextField(decoration: InputDecoration(
            border: InputBorder.none,
            hintText: query,
            hintStyle: const TextStyle(fontSize: 16, color: kMainGreyColor, fontWeight: FontWeight.w400),
          )),
        ),
        SizedBox(height: 50,),
      ],
    );
  }
}
