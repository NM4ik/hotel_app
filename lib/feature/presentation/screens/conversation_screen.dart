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
          padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding/2, horizontal: kEdgeHorizontalPadding),
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) => Bubble(
                  alignment: Alignment.centerRight,
                  color: const Color(0xFF809BD4),
                  padding: const BubbleEdges.all(kEdgeVerticalPadding / 2),
                  margin: const BubbleEdges.only(top: kEdgeVerticalPadding / 2),
                  nip: BubbleNip.rightBottom,
                  child: Text(
                    messages[index],
                    style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ),
              )),
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
                                onTap: () {
                                  sendMessage(textController.text);
                                }),

                            SizedBox(width: kEdgeHorizontalPadding,),

                            Expanded(
                              child: TextField(
                                controller: textController,
                                decoration: const InputDecoration(hintText: 'message', border: InputBorder.none),
                                maxLines: 1,
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
                            padding: EdgeInsets.all(kEdgeHorizontalPadding),
                            child: Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.white,
                            ),
                          )),
                      onTap: () {
                        sendMessage(textController.text);
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
