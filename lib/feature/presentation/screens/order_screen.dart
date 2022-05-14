import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';
import 'package:hotel_ma/feature/presentation/widgets/defaut_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../data/models/room_model.dart';
import '../bloc/booking_bloc/booking_bloc.dart';
import '../widgets/row_table_widget.dart';

class OrderScreen extends StatefulWidget {
  final RoomModel roomModel;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String totalCost;

  const OrderScreen({
    Key? key, required this.roomModel, required this.dateStart, required this.dateEnd, required this.totalCost,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  FirestoreMethods data = FirestoreMethods();
  late DateFormat dateFormat;
  late UserModel userModel;



  @override
  void initState() {
     userModel = locator.get<SqlRepository>().userFromSql();
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
    super.initState();
  }

  // void _addOrder() async {
  //   data.sendBooking(widget.dateTimeFirst, widget.dateTimeSecond, widget.roomModel.name, widget.roomModel.price, userModel.uid, widget.roomModel.type);
  //   showCustomDialog(context, 'Вы успешно забронировали ${widget.roomModel.name}');
  //   Future.delayed(const Duration(seconds: 3), () {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => const HomeScreen(
  //                   page: null,
  //                 )),
  //         (route) => false);
  //   });
  // }

  // void showCustomDialog(BuildContext context, String content) => showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(kEdgeMainBorder),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(kEdgeVerticalPadding / 2),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   content,
  //                   textAlign: TextAlign.center,
  //                   style: Theme.of(context).textTheme.bodyText1,
  //                 ),
  //                 const SizedBox(
  //                   height: kEdgeVerticalPadding / 2,
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: () => Navigator.of(context).pop(),
  //                   child: const Text('Ок'),
  //                   style: ElevatedButton.styleFrom(primary: kMainBlueColor),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        log(state.toString(), name: "STATE");
        // context.read<BookingBloc>().add(StartBookingEvent(
        //     userModel: userModel, roomModel: widget.roomModel, dateStart: widget.dateStart, dateEnd: widget.dateEnd, totalPrice: widget.totalCost));

        if(state is BookingLoadingState){
          return const Center(
            child: CircularProgressIndicator(color: kMainBlueColor,),
          );
        }
        if (state is BookingProcessState) {
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Бронирование', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500)),
              centerTitle: true,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    color: const Color(0xFFEFEFEF),
                    child: Padding(
                      padding: const EdgeInsets.all(kEdgeHorizontalPadding),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Информация о бронировании',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                          )),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(kEdgeHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 20,
                                    child: ListView.builder(
                                        itemCount: state.roomModel.rating,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) => const Icon(
                                              Icons.star,
                                              color: Color(0xFFFEC007),
                                              size: 14,
                                            )),
                                  ),
                                  Text(
                                    state.roomModel.name.toString(),
                                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ],
                              ),
                              CachedNetworkImage(
                                imageUrl: 'https://exat.ru/upload/iblock/e56/e56f843be5b904bd720480696d9080e1.jpeg',
                                width: 100,
                              ),
                            ],
                          ),
                          const Divider(
                            height: 30,
                            color: Colors.black,
                          ),
                          Text(
                            '${dateFormat.format(state.dateStart)} - ${dateFormat.format(state.dateEnd)}, 1 номер',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            'Заезд с ${state.roomModel.checkIn.toString()}, выезд до ${state.roomModel.eviction.toString()}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: double.infinity,
                      color: const Color(0xFFEFEFEF),
                      child: Padding(
                        padding: const EdgeInsets.all(kEdgeHorizontalPadding),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Контактная информация покупателя',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                            )),
                      )),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(kEdgeHorizontalPadding),
                      child: Column(
                        children: [
                          const RowTableWidget(
                            title: 'Имя',
                            query: 'Никита',
                          ),
                          const RowTableWidget(
                            title: 'Фамилия',
                            query: 'Михайлов',
                          ),
                          const RowTableWidget(
                            title: 'Номер',
                            query: '+79324788174',
                          ),
                          RowTableWidget(
                            title: 'Почта',
                            query: userModel.email,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(kEdgeHorizontalPadding),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Итого к оплате:',
                                style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'price',
                                // widget.roomModel.price.toString(),
                                style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 20,
                          ),
                          const Text(
                            'Полная стоимость проживания будет оплачена в момент бронирования. Бронирование будет подтверждено сразу после нажатия на кнопку "Оплатить"',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: kMainGreyColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(kEdgeHorizontalPadding),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Условия бронирования и оплаты',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_right_sharp,
                                color: kMainGreyColor,
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Важная информация и правила проживания',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_right_sharp,
                                color: kMainGreyColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(kEdgeHorizontalPadding),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Нажимая "Забронировать", вы принимаете условия оказания услуг, пользовательское соглашение, политику конфиденциальности, политику использования cookie-файлов.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: DefaultButtonWidget(
                        press: () {
                          // _addBooking();
                        },
                        title: 'Забронировать'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Что-то пошло не так...'),
            ),
          );
        }
      },
    );
  }
}
