import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/presentation/screens/conversation_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/faq_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String imageRoot = "assets/images/car_2.png";
  final currentUser = locator.get<AuthenticationRepository>().currentUser;

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

              FutureBuilder(
                  future: FirebaseFirestore.instance.collection('FAQ').get(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox(
                          height: 110,
                          child: CircularProgressIndicator(
                            color: kMainBlueColor,
                          ));
                    }

                    if (snapshot.hasData) {
                      final data = snapshot.data!.docs.map((e) => e.data() as Map<String, dynamic>).toList();

                      return SizedBox(
                        height: 110,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => _cardWidget(context, index, data),
                            separatorBuilder: (context, index) => const SizedBox(
                                  width: 15,
                                ),
                            itemCount: snapshot.data!.docs.length),
                      );
                    } else {
                      return const Text('Что-то пошло не так');
                    }
                  }),

              const SizedBox(
                height: kEdgeVerticalPadding / 2,
              ),

              GestureDetector(
                onTap: () {
                  if (currentUser == UserModel.empty) {
                    showCustomDialog(context, 'Нельзя писать в чат, будучи неавторизованным');
                  }
                  if (currentUser != UserModel.empty) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => ConversationScreen(userModel: currentUser)))
                        .then((_) => setState(() {}));
                  }
                },
                child: currentUser == UserModel.empty
                    ? Card(
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
                              subtitle: Text(
                                'Последнее сообщение',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('chats').doc(currentUser.uid).snapshots(),
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
                                    lastMessageUid == currentUser.uid
                                        ? TextSpan(children: [
                                            TextSpan(
                                                text: '${currentUser.displayName}: ',
                                                // text: '${'qwe'}: ',
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

  _cardWidget(BuildContext context, int index, List<dynamic> data) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FaqScreen(index: index, data: data[index]),
        ));
      },
      child: SizedBox(
        width: 74,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(kEdgeMainBorder),
              child: Image.network(
                data[index]['imageRoot'],
                fit: BoxFit.cover,
                width: 74,
                height: 74,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              data[index]['title'],
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
