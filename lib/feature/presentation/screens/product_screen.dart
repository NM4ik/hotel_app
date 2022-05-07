import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';
import 'package:hotel_ma/feature/presentation/screens/order_screen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../common/app_constants.dart';
import '../../data/models/user_model.dart';
import '../components/onboarding_dot.dart';
import '../components/onboarding_dot.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.roomModel, required this.dateTimeFirst, required this.dateTimeSecond}) : super(key: key);
  final RoomModel roomModel;
  final DateTime dateTimeFirst;
  final DateTime dateTimeSecond;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey _scaffold = GlobalKey();
  final controller = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/room_image_4.jpg',
      'assets/images/room_image_3.jpg',
      'assets/images/room_image_2.jpg',
      "assets/images/room_image_1.jpg"
    ];

    UserModel userModel = UserModel.toUser(FirebaseAuth.instance.currentUser);

    return Scaffold(
      key: _scaffold,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
            child: Column(
              children: [
                Stack(
                  children: [
                    /*image carousel   not working correctly. an exception throwing when returning back. try to fix or use another from pub.dev
                    Looking up a deactivated widget's ancestor is unsafe. - exception*/

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kEdgeMainBorder),
                      ),
                      // width: double.infinity,
                      height: 330,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kEdgeMainBorder),
                        child: PhotoViewGallery.builder(
                          scrollPhysics: const BouncingScrollPhysics(),
                          builder: (BuildContext context, int index) {
                            return PhotoViewGalleryPageOptions(
                              imageProvider: AssetImage(images[index]),
                              // imageProvider: const NetworkImage('https://www.matratzen-webshop.de/media/image/8b/ac/ef/100600-NP_5283.jpg'),
                              heroAttributes: PhotoViewHeroAttributes(tag: index),
                              basePosition: Alignment.center,
                              // initialScale: PhotoViewComputedScale.covered * 0.5,
                              minScale: PhotoViewComputedScale.covered,
                              maxScale: PhotoViewComputedScale.covered * 2,
                            );
                          },
                          pageController: controller,
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          itemCount: 4,
                          enableRotation: true,
                          backgroundDecoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                          ),
                          loadingBuilder: (context, event) => const Center(
                            child: SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                color: kMainBlueColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// back_button from product_screen and indicator image's dots
                    SizedBox(
                      height: 330,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 1.5, horizontal: kEdgeHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// back button
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 4.0,
                                    sigmaY: 4.0,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(kEdgeMainBorder),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: kMainBlueColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            /// indicator dots
                            Center(
                              child: ViewDots(
                                currentPage: currentPage,
                                controller: controller,
                                length: 4,
                                dotColor: Colors.white.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kEdgeVerticalPadding,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// product name
                          Text(
                            widget.roomModel.name,
                            style: Theme.of(context).textTheme.headline1,
                          ),

                          const SizedBox(
                            height: kEdgeVerticalPadding / 2,
                          ),

                          /// product type subtitle
                          Text(widget.roomModel.type, style: const TextStyle(color: Color(0xFF979797), fontSize: 14, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          /// product price
                          Text(
                            '₽ ${widget.roomModel.price}',
                            style: Theme.of(context).textTheme.headline1,
                          ),

                          // const SizedBox(height: kEdgeVerticalPadding/2,),

                          /// product price type subtitle
                          const Text('ночь', style: TextStyle(color: Color(0xFF979797), fontSize: 14, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    )
                  ],
                ),

                /// Divider which divides product_info and product_description
                const SizedBox(
                  height: 40,
                  child: Divider(
                    height: 1,
                    color: Color(0xFF979797),
                  ),
                ),

                /// Description bloc
                Text(
                  widget.roomModel.description.toString(),
                  //'Расслабьтесь в современном номере площадью 35–36 кв. м с одной большой двуспальной кроватью (King), удобным креслом для чтения, минибаром, душевой кабиной с тропическим душем, отдельной ванной и бесплатным Wi-Fi.',
                  style: TextStyle(color: const Color(0xFF979797), fontWeight: FontWeight.w400, fontSize: 12),
                )
              ],
            )),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: kEdgeVerticalPadding),
        child: FloatingActionButton.extended(
          backgroundColor: kMainBlueColor,
          onPressed: () {
            if (userModel == UserModel.empty) {
              log(userModel.toString(), name: "MODEL: ");
              showCustomDialog(context, 'Нельзя забронировать номер, будучи неавторизованным');
            } else {
              log(userModel.toString(), name: "MODEL2: ");
              log(FirebaseAuth.instance.currentUser.toString(), name: "userModel2: ");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OrderScreen(
                        roomModel: widget.roomModel,
                        dateTimeFirst: widget.dateTimeFirst,
                        dateTimeSecond: widget.dateTimeSecond,
                      )));
            }
          },
          elevation: 3,
          label: const Text(
            'Забронировать номер',
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
