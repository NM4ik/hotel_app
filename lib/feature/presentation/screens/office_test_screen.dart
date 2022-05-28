// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_ma/common/app_constants.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:photo_view/photo_view_gallery.dart';
//
// import '../bloc/service_rent_bloc/service_rent_bloc.dart';
// import '../components/onboarding_dot.dart';
//
// class OfficeTestScreen extends StatefulWidget {
//   const OfficeTestScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OfficeTestScreen> createState() => _OfficeTestScreenState();
// }
//
// class _OfficeTestScreenState extends State<OfficeTestScreen> {
//   late PageController pageController;
//   late PhotoViewController photoController;
//
//   int currentPage = 0;
//   late DateFormat dateFormat;
//
//   @override
//   void initState() {
//     pageController = PageController();
//     photoController = PhotoViewController();
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     pageController.dispose();
//     photoController.dispose();
//
//     pageController = PageController();
//     photoController = PhotoViewController();
//   }
//
//   @override
//   void dispose() {
//     photoController.dispose();
//     pageController.dispose();
//     super.dispose();
//   }
//
//   final List<String> images = [
//     'assets/images/room_image_4.jpg',
//     'assets/images/room_image_3.jpg',
//     'assets/images/room_image_2.jpg',
//     "assets/images/room_image_1.jpg"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ServiceRentBloc, ServiceRentState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         if (state is ServiceRentChooseState) {
//           return SafeArea(
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(kEdgeMainBorder),
//                               ),
//                               // width: double.infinity,
//                               height: 330,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(kEdgeMainBorder),
//                                 child: PhotoViewGallery.builder(
//                                   scrollPhysics: const BouncingScrollPhysics(),
//                                   builder: (BuildContext context, int index) {
//                                     return PhotoViewGalleryPageOptions(
//                                       controller: photoController,
//                                       imageProvider: AssetImage(images[index]),
//                                       // imageProvider: const NetworkImage('https://www.matratzen-webshop.de/media/image/8b/ac/ef/100600-NP_5283.jpg'),
//                                       heroAttributes: PhotoViewHeroAttributes(tag: index),
//                                       basePosition: Alignment.center,
//                                       // initialScale: PhotoViewComputedScale.covered * 0.5,
//                                       minScale: PhotoViewComputedScale.covered,
//                                       maxScale: PhotoViewComputedScale.covered * 2,
//                                     );
//                                   },
//                                   pageController: pageController,
//                                   onPageChanged: (index) {
//                                     setState(() {
//                                       currentPage = index;
//                                     });
//                                   },
//                                   itemCount: 4,
//                                   enableRotation: true,
//                                   backgroundDecoration: BoxDecoration(
//                                     color: Theme.of(context).canvasColor,
//                                   ),
//                                   loadingBuilder: (context, event) => const Center(
//                                     child: SizedBox(
//                                       width: 20.0,
//                                       height: 20.0,
//                                       child: CircularProgressIndicator(
//                                         color: kMainBlueColor,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                             /// back_button from product_screen and indicator image's dots
//                             SizedBox(
//                               height: 330,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 1.5, horizontal: kEdgeHorizontalPadding),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     /// back button
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.of(context).pop();
//                                         // context.read<RoomsBloc>().add(RoomsLoadingEvent());
//                                       },
//                                       child: ClipRRect(
//                                         child: BackdropFilter(
//                                           filter: ImageFilter.blur(
//                                             sigmaX: 4.0,
//                                             sigmaY: 4.0,
//                                           ),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Colors.white.withOpacity(0.4),
//                                               borderRadius: BorderRadius.circular(kEdgeMainBorder),
//                                             ),
//                                             child: const Padding(
//                                               padding: EdgeInsets.all(10.0),
//                                               child: Icon(
//                                                 Icons.arrow_back_ios_rounded,
//                                                 color: kMainBlueColor,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//                                     /// indicator dots
//                                     Center(
//                                       child: ViewDots(
//                                         currentPage: currentPage,
//                                         controller: pageController,
//                                         length: 4,
//                                         dotColor: Colors.white.withOpacity(0.4),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: kEdgeVerticalPadding / 2,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Renault Logan',
//                               style: Theme.of(context).textTheme.headline3,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   '12 577',
//                                   style: Theme.of(context).textTheme.headline3,
//                                 ),
//                                 Text(
//                                   'за 9 дней',
//                                   style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kMainGreyColor, fontSize: 13),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         _customDivider(),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Предоплата',
//                               style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kMainGreyColor, fontSize: 13),
//                             ),
//                             Text(
//                               '11%', // if null return 0%
//                               style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13),
//                             ),
//                           ],
//                         ),
//                         _customDivider(),
//                         _dateFormatter('01 июня, 12:00', 'Приморье Grand Resort Hotel. Геленджик, ул. Мира, д. 23., +7 (921) 306-98-35.'),
//                         _dateFormatter('10 июня, 12:00', 'Приморье Grand Resort Hotel. Геленджик, ул. Мира, д. 23., +7 (921) 306-98-35.'),
//                       ],
//                     ),
//                   ),
//                   _dividerCharacterBloc(),
//                 ],
//               ),
//             ),
//           );
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: kMainBlueColor,
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   _dividerCharacterBloc() => Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 40,
//             color: Color(0xFFE7E7E7),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: 9),
//               child: Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Text(
//                   'Включено в аренду',
//                   style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 13),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding / 3),
//               child: ListView.separated(
//                 shrinkWrap: true,
//                 itemCount: 10,
//                 itemBuilder: (context, index) => Row(
//                   children: [
//                     Container(
//                       width: 5,
//                       height: 5,
//                       decoration: BoxDecoration(color: kMainGreyColor, borderRadius: BorderRadius.circular(10)),
//                     ),
//                     const SizedBox(
//                       width: kEdgeHorizontalPadding / 2,
//                     ),
//                     Flexible(
//                       child: Text(
//                         'qwe',
//                         style: Theme.of(context).textTheme.bodyText1,
//                       ),
//                     ),
//                   ],
//                 ),
//                 separatorBuilder: (BuildContext context, int index) => const SizedBox(
//                   height: kEdgeVerticalPadding / 3,
//                 ),
//               ),
//             ),
//           )
//         ],
//       );
//
//   _dateFormatter(String date, String address) => Container(
//         width: MediaQuery.of(context).size.width * 0.8,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               date,
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//             Text(
//               address,
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kMainGreyColor),
//             ),
//             const SizedBox(
//               height: kEdgeVerticalPadding / 3,
//             ),
//           ],
//         ),
//       );
//
//   _customDivider() => const SizedBox(
//         height: 35,
//         child: Divider(
//           height: 1,
//           color: kDividerGreyColor,
//         ),
//       );
// }
