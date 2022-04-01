import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../common/app_constants.dart';
import '../components/onboarding_dot.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
            child: Column(
              children: [
                Stack(
                  children: [
                    /// image carousel
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kEdgeMainBorder),
                      ),
                      width: double.infinity,
                      height: 380,
                      child: PhotoViewGallery.builder(
                        scrollPhysics: const BouncingScrollPhysics(),
                        builder: (BuildContext context, int index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: const AssetImage("assets/images/room_image_3.png"),
                            heroAttributes: PhotoViewHeroAttributes(tag: index),
                            basePosition: Alignment.center,
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 2,
                          );
                        },
                        pageController: controller,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemCount: 7,
                        enableRotation: true,
                        backgroundDecoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                        ),
                        loadingBuilder: (context, event) => const Center(
                          child: SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),

                    /// back_button from product_screen and indicator image's dots
                    SizedBox(
                      height: 380,
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
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: OnboardingDot(
                                  currentPage: currentPage,
                                  controller: controller,
                                  length: 7,
                                  dotColor: Colors.white.withOpacity(0.4),
                                ),
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
                            'Бизнес номер для двоих',
                            style: Theme.of(context).textTheme.headline1,
                          ),

                          const SizedBox(
                            height: kEdgeVerticalPadding / 2,
                          ),

                          /// product type subtitle
                          const Text('Премиум', style: TextStyle(color: Color(0xFF979797), fontSize: 14, fontWeight: FontWeight.w500)),
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
                            '₽ 3000',
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
                const Text(
                  'Расслабьтесь в современном номере площадью 35–36 кв. м с одной большой двуспальной кроватью (King), удобным креслом для чтения, минибаром, душевой кабиной с тропическим душем, отдельной ванной и бесплатным Wi-Fi.',
                  style: TextStyle(color: Color(0xFF979797), fontWeight: FontWeight.w400, fontSize: 12),
                )
              ],
            )),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: kEdgeVerticalPadding),
        child: FloatingActionButton.extended(
          backgroundColor: kMainBlueColor,
          onPressed: () => setState(() {}),
          elevation: 3,
          label: Text(
            'Забронировать ${widget.index}',
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
