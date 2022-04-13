import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/presentation/screens/conversation_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/faq_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/product_screen.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        if (user == null) {
          userModel = UserModel.empty;
        } else {
          userModel = UserModel.toUser(user);
        }
      });
    });

  }

  Future<DocumentSnapshot> initChat() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('chats').doc(userModel.uid).get();
    return snapshot;
  }

  @override
  void dispose() {
    super.dispose();
  }

  final String imageRoot = "assets/images/car_2.png";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// title
              Text(
                "Чаты",
                style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 36),
              ),

              const SizedBox(
                height: kEdgeVerticalPadding,
              ),

              /// FAG BLOCk
              Text(
                "Частые вопросы",
                style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: kEdgeVerticalPadding / 2,
              ),

              SizedBox(
                height: 110,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => _cardWidget(context, index),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ),
                    itemCount: 6),
              ),

              const SizedBox(
                height: kEdgeVerticalPadding / 2,
              ),

              GestureDetector(
                onTap: () {
                  if (userModel == UserModel.empty) {
                    showCustomDialog(context, 'Нельзя писать в чат, будучи неавторизованным');
                  }
                  if (userModel != UserModel.empty) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConversationScreen(userModel: userModel))).then((_) => setState(() {}));
                  }
                },
                child: FutureBuilder(
                    future: initChat(),
                    builder: (context, AsyncSnapshot snapshot) {
                      late String lastMessage;
                      late String lastMessageUid;

                      if (!snapshot.hasData || snapshot.hasError) {
                        lastMessage = 'Сообщений еще не было или они не загрузились..';
                        lastMessageUid = '';
                      }

                      if (snapshot.hasData) {
                        lastMessage = snapshot.data['recentMessage']['content'];
                        lastMessageUid = snapshot.data['recentMessage']['sendBy'];
                      }
                      return Card(
                        margin: EdgeInsets.zero,
                        color: Colors.transparent,
                        elevation: 0,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: kMainBlueColor,
                                  borderRadius: BorderRadius.circular(kEdgeMainBorder),
                                ),
                                child: const Icon(
                                  Icons.person_pin,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              title: Text('Поддержка', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16)),
                              subtitle: Text.rich(
                                lastMessageUid == userModel.uid
                                    ? TextSpan(children: [
                                        TextSpan(
                                            // text: '${userModel.displayName}: ',
                                            text: '${'qwe'}: ',
                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                                        TextSpan(
                                            text: lastMessage,
                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, fontWeight: FontWeight.w400))
                                      ])
                                    : TextSpan(children: [
                                        TextSpan(
                                            text: 'поддержка: ',
                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                                        TextSpan(
                                            text: lastMessage,
                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, fontWeight: FontWeight.w400))
                                      ]),
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          )),
    );
  }

  _cardWidget(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FaqScreen(index: index, imageRoot: imageRoot),
        ));
      },
      child: SizedBox(
        width: 74,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(kEdgeMainBorder),
              child: Image.asset(
                imageRoot,
                fit: BoxFit.cover,
                width: 74,
                height: 74,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Как оплатить автомобиль',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w400, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomDialog(BuildContext context, String content) => showDialog(
    context: context,
    builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kEdgeMainBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kEdgeVerticalPadding / 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: kEdgeVerticalPadding / 2,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ок'),
                  style: ElevatedButton.styleFrom(primary: kMainBlueColor),
                )
              ],
            ),
          ),
        ));
