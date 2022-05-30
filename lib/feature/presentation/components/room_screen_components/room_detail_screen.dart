import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';
import 'package:hotel_ma/feature/presentation/components/room_screen_components/room_order_screen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../../common/app_constants.dart';
import '../../../data/models/user_model.dart';
import '../../bloc/rooms_bloc/rooms_bloc.dart';
import '../onboarding_dot.dart';

class RoomDetailScreen extends StatefulWidget {
  const RoomDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  final userModel = locator.get<SqlRepository>().getUserFromSql();
  late PageController pageController;
  late PhotoViewController photoController;

  int currentPage = 0;
  String? totalCost;
  late DateFormat dateFormat;

  @override
  void initState() {
    pageController = PageController();
    photoController = PhotoViewController();
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pageController.dispose();
    photoController.dispose();

    pageController = PageController();
    photoController = PhotoViewController();
  }

  @override
  void dispose() {
    photoController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomsBloc, RoomsState>(
      listener: (context, state) {
        if (state is RoomsLoadedState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is RoomsChooseState) {
          totalCost = ((state.lastDate.difference(state.firstDate).inDays) * state.room.price).toString();

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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(kEdgeMainBorder),
                              ),
                              height: 330,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(kEdgeMainBorder),
                                child: PhotoViewGallery.builder(
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  builder: (BuildContext context, int index) {
                                    return PhotoViewGalleryPageOptions(
                                      controller: photoController,
                                      imageProvider: NetworkImage(state.room.images?[index] ?? ''),
                                      heroAttributes: PhotoViewHeroAttributes(tag: index),
                                      basePosition: Alignment.center,
                                      minScale: PhotoViewComputedScale.covered,
                                      maxScale: PhotoViewComputedScale.covered * 2,
                                    );
                                  },
                                  pageController: pageController,
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
                                        controller: pageController,
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
                                    state.room.name,
                                    style: Theme.of(context).textTheme.headline1,
                                  ),

                                  const SizedBox(
                                    height: kEdgeVerticalPadding / 4,
                                  ),

                                  /// product type subtitle
                                  Text(state.room.roomTypeModel.title.toString(),
                                      style: TextStyle(
                                          color: Color(int.parse('0xFF${state.room.roomTypeModel.color}')), fontSize: 14, fontWeight: FontWeight.w500)),

                                  const SizedBox(
                                    height: kEdgeVerticalPadding / 4,
                                  ),

                                  /// product dates subtitle
                                  Text('${dateFormat.format(state.firstDate)} - ${dateFormat.format(state.lastDate)}',
                                      style: const TextStyle(color: Color(0xFF979797), fontSize: 14, fontWeight: FontWeight.w500)),
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
                                    '₽ ${state.room.price}',
                                    style: Theme.of(context).textTheme.headline1,
                                  ),

                                  /// product price type subtitle
                                  const Text('ночь', style: TextStyle(color: Color(0xFF979797), fontSize: 14, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          ],
                        ),

                        const Divider(
                          height: kEdgeVerticalPadding,
                          color: Color(0xFF979797),
                        ),

                        /// dates inserts bloc
                        Row(
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              color: kMainGreyColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Заезд с ${state.room.checkIn.toString()}, выезд до ${state.room.eviction.toString()}',
                              style: const TextStyle(color: Color(0xFF979797), fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: kEdgeVerticalPadding / 3,
                        ),

                        ListView.separated(
                          itemBuilder: (context, index) => Text(
                            state.room.description?[index] ?? '',
                            style: const TextStyle(color: Color(0xFF979797), fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                          itemCount: state.room.description?.length ?? 0,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(
                            height: 10,
                          ),
                        ),
                        // const SizedBox(
                        //   height: kEdgeVerticalPadding / 2,
                        // ),
                        const Divider(
                          height: kEdgeVerticalPadding,
                          color: Color(0xFF979797),
                        ),
                        const Text('Услуги и удобства в отеле', style: TextStyle(color: Color(0xFF979797), fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: kEdgeVerticalPadding / 4,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.tags.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: kMainBlueColor.withOpacity(0.5), width: 1), borderRadius: BorderRadius.circular(kEdgeMainBorder / 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                state.tags[index],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(
                            height: kEdgeVerticalPadding / 5,
                          ),
                        ),

                        const SizedBox(
                          height: 60,
                        ),
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => RoomOrderScreen(
                              dateStart: state.firstDate,
                              roomModel: state.room,
                              dateEnd: state.lastDate,
                              totalCost: totalCost!,
                            )));
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
