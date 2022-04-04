import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/app_constants.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  List<String> messages = [
    'qweqwe',

  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();


    void sendMessage(String msg) {
      setState(() {
        print(msg);
        messages.add(msg);
        textController.clear();
      });
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) => Bubble(
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 212, 234, 244),
                  borderColor: Colors.black,
                  borderWidth: 2,
                  margin: const BubbleEdges.only(top: 8),
                  child: Text(
                    messages[index],
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: CupertinoTextField(
                        controller: textController,
                          ),
                    ),
                  ),
                  CupertinoButton(
                      child: Icon(Icons.send_sharp),
                      onPressed: () {
                        sendMessage(textController.text);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
