import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_themes.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/data/datasources/sql_methods.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/app_constants.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    FirestoreMethods firestoreData = FirestoreMethods();
    late bool isData;

    _sendMessage(String message, bool isData) async {
      if (isData == false) {
        await firestoreData.initializeChat(message, widget.userModel);
      }
      firestoreData.sendMessage(message, widget.userModel.uid);
      textController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFEFEFEF),
        elevation: 0,
        title: Column(
          children: [
            Text('Поддержка', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500)),
            const Text('На связи 24/7', style: TextStyle(color: Color(0xFF8D8D8D), fontWeight: FontWeight.w400, fontSize: 11)),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2, horizontal: kEdgeHorizontalPadding),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(widget.userModel.uid)
                      .collection('messages')
                      .orderBy('sendAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kMainBlueColor,
                        ),
                      );
                    }

                    final data = snapshot.data!.docs.map((DocumentSnapshot e) => e.data()! as Map<String, dynamic>).toList();

                    if (data.isEmpty) {
                      isData = false;

                      return Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Bubble(
                            alignment: Alignment.center,
                            color: const Color(0xFF809BD4),
                            child: const Text(
                              'Сообщений пока что нет...',
                              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                            ),
                            padding: const BubbleEdges.all(kEdgeVerticalPadding / 2),
                            margin: const BubbleEdges.only(top: kEdgeVerticalPadding / 2),
                          ),
                        ),
                      );
                    } else {
                      isData = true;
                    }

                    return Expanded(
                        child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final isUser = widget.userModel.uid == data[index]['sendBy'];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: data[index]['name'] == null
                                  ? const SizedBox()
                                  : Text(
                                      data[index]['name'],
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: kMainGreyColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ),
                            Bubble(
                              alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                              color: isUser ? const Color(0xFF809BD4) : Theme.of(context).cardColor,
                              padding: const BubbleEdges.all(kEdgeVerticalPadding / 2),
                              margin: const BubbleEdges.only(top: 3),
                              nip: isUser ? BubbleNip.rightBottom : BubbleNip.leftBottom,
                              child: Text(
                                data[index]['content'].toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? isUser
                                            ? Colors.white
                                            : Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(
                        height: kEdgeVerticalPadding / 2,
                      ),
                    ));
                  }),

              const SizedBox(
                height: kEdgeVerticalPadding / 2,
              ),

              /// text field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        // color: Colors.red,

                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            GestureDetector(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: kMainBlueColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(6),
                                      child: Icon(
                                        Icons.add_rounded,
                                        color: Colors.white,
                                      ),
                                    )),
                                onTap: () {}),
                            const SizedBox(
                              width: kEdgeHorizontalPadding,
                            ),
                            Expanded(
                              child: TextField(
                                controller: textController,
                                decoration: const InputDecoration(hintText: 'message', border: InputBorder.none),
                                maxLines: 1,
                                // onSubmitted: _sendMessage(textController.text),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: kEdgeHorizontalPadding,
                  ),

                  /// send image
                  GestureDetector(
                      child: Container(
                          // height: 60,
                          decoration: BoxDecoration(
                            color: kMainBlueColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(kEdgeHorizontalPadding / 1.3),
                            child: Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.white,
                            ),
                          )),
                      onTap: () {
                        _sendMessage(
                          textController.text,
                          isData,
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
