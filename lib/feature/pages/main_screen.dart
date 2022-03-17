import 'package:flutter/material.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 30,), /// UPDATE TO SPACER OR FLEX OR SOMETHING
            Text('ASIA HOTEL', style: Theme.of(context).textTheme.headline1),
           ],
        ),
      ),
    );
  }
}
