import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/models/faq_model.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';
import 'package:hotel_ma/feature/presentation/screens/conversation_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/faq_screen.dart';

import '../widgets/build_shimmer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

Future<List<FaqModel>> _fetchFaq() async {
  final List<FaqModel> faqs = [];

  try {
    final data = await FirebaseFirestore.instance.collection('FAQ').get();
    data.docs.map((e) => faqs.add(FaqModel.fromJson(e.data()))).toList();
    return faqs;
  } catch (e) {
    log(e.toString());
    return faqs;
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final userModel = locator.get<SqlRepository>().getUserFromSql();

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
                  future: _fetchFaq(),
                  builder: (BuildContext context, AsyncSnapshot<List<FaqModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData || snapshot.hasError) {
                      return SizedBox(
                        height: 75,
                        child: ListView.separated(
                            separatorBuilder: (context, index) => const SizedBox(
                                  width: 15,
                                ),
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => const BuildShimmer(
                                  width: 74,
                                  height: 74,
                                )),
                      );
                    }

                    if (snapshot.hasData) {
                      final List<FaqModel>? data = snapshot.data;

                      return SizedBox(
                        height: 110,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => _cardWidget(context, data![index]),
                            separatorBuilder: (context, index) => const SizedBox(
                                  width: 15,
                                ),
                            itemCount: data!.length),
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
                  if (userModel == UserModel.empty) {
                    showCustomDialog(context, 'Нельзя писать в чат, будучи неавторизованным');
                  }
                  if (userModel != UserModel.empty) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConversationScreen(userModel: userModel))).then((_) => setState(() {}));
                  }
                },
                child: userModel == UserModel.empty
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
                    // : StreamBuilder(
                    //     stream: FirebaseFirestore.instance.collection('chats').doc(userModel.uid).snapshots(),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasError) {
                    //         ListTile(title: Text('error'));
                    //       }
                    //
                    //       if (!snapshot.hasData) {
                    //         ListTile(title: Text('error'));
                    //       }
                    //
                    //       return Card(child: ListTile(title: Text('name')));
                    //     })),

                    : StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('chats').doc(userModel.uid).snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          late String lastMessage;
                          late String lastMessageUid;

                          if (snapshot.hasError) {
                            lastMessage = 'Ошибка загрузки чата..';
                            lastMessageUid = '';
                          }

                          if (!snapshot.hasData || snapshot.hasData) {
                            lastMessage = 'Сообщений еще не было или они не загрузились..';
                            lastMessageUid = '';
                          }

                          if (snapshot.connectionState == ConnectionState.done) {
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
                                                text: '${userModel.name}: ',
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

  _cardWidget(BuildContext context, FaqModel faqModel) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FaqScreen(
            faqModel: faqModel,
          ),
        ));
      },
      child: SizedBox(
        width: 74,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(kEdgeMainBorder),
              child: CachedNetworkImage(
                height: 74,
                imageUrl: faqModel.image ?? '',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Flexible(
              child: Text(
                faqModel.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w400, fontSize: 11),
              ),
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
