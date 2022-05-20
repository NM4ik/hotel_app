import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/service_rent_bloc/service_rent_bloc.dart';
import 'package:hotel_ma/feature/presentation/components/office_components/office_order_screen.dart';
import 'package:hotel_ma/feature/presentation/widgets/page_animation.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../../common/app_constants.dart';
import '../../../data/models/user_model.dart';
import '../../bloc/rooms_bloc/rooms_bloc.dart';
import '../onboarding_dot.dart';

class OfficeProductDetailScreen extends StatefulWidget {
  const OfficeProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OfficeProductDetailScreen> createState() => _OfficeProductDetailScreenState();
}

class _OfficeProductDetailScreenState extends State<OfficeProductDetailScreen> {
  final controller = PageController();
  final userModel = locator.get<SqlRepository>().getUserFromSql();

  int currentPage = 0;
  String? totalCost;
  late DateFormat dateFormat;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
    super.initState();
  }

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

    return BlocConsumer<ServiceRentBloc, ServiceRentState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ServiceRentChooseState) {
          totalCost = ((state.lastDate.difference(state.firstDate).inDays) * int.parse(state.rent.price)).toString();
          return Scaffold(
            body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                        context.read<RoomsBloc>().add(RoomsLoadingEvent());
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
                                    state.rent.name,
                                    style: Theme.of(context).textTheme.headline1,
                                  ),
                                  const SizedBox(
                                    height: kEdgeVerticalPadding / 4,
                                  ),

                                  Text('Предоплата: ${state.rent.prePayment}%',
                                      style: const TextStyle(color: kMainGreyColor, fontSize: 14, fontWeight: FontWeight.w500)),

                                  const SizedBox(
                                    height: kEdgeVerticalPadding / 2,
                                  ),
                                  ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Text('${dateFormat.format(state.firstDate)}, 12:00',
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600, fontSize: 14)),
                                      subtitle: Text(
                                        'Адрес: Краснодарский край, г. Геленджик, ул. Мира, д. 23. Телефон: 7 800 33 08 00',
                                        style:
                                            Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w300, fontSize: 11, color: kMainGreyColor),
                                      )),

                                  ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Text('${dateFormat.format(state.lastDate)}, 12:00',
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600, fontSize: 14)),
                                      subtitle: Text(
                                        'Адрес: Краснодарский край, г. Геленджик, ул. Мира, д. 23. Телефон: 7 800 33 08 00',
                                        style:
                                            Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w300, fontSize: 11, color: kMainGreyColor),
                                      )),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₽ ${state.rent.price}',
                                    style: Theme.of(context).textTheme.headline1,
                                  ),
                                  const Text('ночь', style: TextStyle(color: Color(0xFF979797), fontSize: 14, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                          child: Divider(
                            height: 1,
                            color: Color(0xFF979797),
                          ),
                        ),
                        const Text(
                          'Характеристики',
                          style: TextStyle(color: Color(0xFF979797), fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          // height: (state.rent.characters?.length == null ? 1 : state.rent.characters!.length * 30),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.rent.characters?.length ?? 0,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(color: kMainGreyColor, borderRadius: BorderRadius.circular(10)),
                                  ),
                                  const SizedBox(
                                    width: kEdgeHorizontalPadding / 2,
                                  ),
                                  Text(
                                    '${state.rent.characters?[index]['title']} - ${state.rent.characters?[index]['value']}',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  )
                                ],
                              ),
                            ),
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                          child: Divider(
                            height: 1,
                            color: Color(0xFF979797),
                          ),
                        ),
                        const Text(
                          'Список документов для получения услуги',
                          style: TextStyle(color: Color(0xFF979797), fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          // height: (state.rent.documents?.length == null ? 1 : state.rent.documents!.length * 30),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.rent.documents?.length ?? 0,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(color: kMainGreyColor, borderRadius: BorderRadius.circular(10)),
                                  ),
                                  const SizedBox(
                                    width: kEdgeHorizontalPadding / 2,
                                  ),
                                  Flexible(
                                    child: Text(
                                      state.rent.documents?[index] ?? '',
                                      overflow: TextOverflow.fade,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            scrollDirection: Axis.vertical,
                          ),
                        ),

                        /// space for floatingButton
                        const SizedBox(height: 50,),
                      ],
                    ),
                  )),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: kEdgeVerticalPadding),
              child: FloatingActionButton.extended(
                backgroundColor: kMainBlueColor,
                onPressed: () {
                  if (userModel == UserModel.empty) {
                    showCustomDialog(context, 'Нельзя забронировать номер, будучи неавторизованным');
                  } else {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (context) => OrderScreen(
                    //           dateStart: state.firstDate,
                    //           roomModel: state.room,
                    //           dateEnd: state.lastDate,
                    //           totalCost: totalCost!,
                    //         )));

                    Navigator.of(context).push(createRouteAnim(OfficeOrderScreen(rent: state.rent, dateStart: state.firstDate, dateEnd: state.lastDate, totalCost: totalCost!)));
                  }
                },
                elevation: 3,
                label: Text(
                  'Забронировать номер за $totalCost ₽',
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: kMainBlueColor,
              ),
            ),
          );
        }
      },
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
