import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/presentation/screens/home_screen.dart';

import '../../../common/app_constants.dart';

class GetUserInfoScreen extends StatefulWidget {
  const GetUserInfoScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  _GetUserInfoScreenState createState() => _GetUserInfoScreenState();
}

class _GetUserInfoScreenState extends State<GetUserInfoScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController nameController = TextEditingController();
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
        child: SafeArea(
          child: Column(children: [
            Align(
              child: GestureDetector(
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: kMainBlueColor,
                    ),
                    Text(
                      'назад',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                onTap: () async {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen(page: null)), (route) => false);
                },
              ),
              alignment: Alignment.centerLeft,
            ),
            TextFormField(
              // validator: (String? inputValue) {
              //   if (inputValue!.isEmpty && inputValue.length < 3) {
              //     return "Please Fill before";
              //   }
              //   return null;
              // },
              controller: nameController,
              // onChanged: (inputValue) {
              //   _name = inputValue;
              // },
              decoration: const InputDecoration(
                label: Text("name"),
                labelStyle: TextStyle(color: Colors.red),
              ),
            ),
            Text(widget.user.toString()),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await users.doc(widget.user.uid).update({"name": _name});
                  } catch (e) {
                    print('не получилось');
                  }
                },
                child: Text('qwe'))
          ]),
        ),
      ),
    );
  }
}
