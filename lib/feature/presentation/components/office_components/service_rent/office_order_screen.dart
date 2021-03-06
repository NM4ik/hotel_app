import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/booking_model.dart';
import 'package:hotel_ma/feature/data/models/booking_rent_model.dart';
import 'package:hotel_ma/feature/data/models/rent_model.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/office_bloc/office_bloc.dart';
import 'package:hotel_ma/feature/presentation/components/toat_attachments.dart';
import 'package:hotel_ma/feature/presentation/screens/router_screen.dart';
import 'package:hotel_ma/feature/presentation/widgets/defaut_button_widget.dart';
import 'package:hotel_ma/feature/data/repositories/payment_controller.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../../../core/locator_service.dart';
import '../../../../data/models/room_model.dart';
import '../../../../data/repositories/sql_repository.dart';
import '../../../widgets/order_text_field_widget.dart';
import '../../../widgets/row_table_widget.dart';

class OfficeOrderScreen extends StatefulWidget {
  final RentModel rent;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String totalCost;

  const OfficeOrderScreen({
    Key? key,
    required this.rent,
    required this.dateStart,
    required this.dateEnd,
    required this.totalCost,
  }) : super(key: key);

  @override
  _OfficeOrderScreenState createState() => _OfficeOrderScreenState();
}

class _OfficeOrderScreenState extends State<OfficeOrderScreen> {
  late DateFormat dateFormat;
  final UserModel userModel = locator.get<SqlRepository>().getUserFromSql();
  PaymentController paymentController = PaymentController();
  String? name;
  String? secondName;
  String? phoneNumber;
  String? email;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
    name = userModel.name;
    phoneNumber = userModel.phoneNumber;
    email = userModel.email;

    super.initState();
  }

  // void _addOrder() async {
  //   data.sendBooking(widget.dateTimeFirst, widget.dateTimeSecond, widget.roomModel.name, widget.roomModel.price, userModel.uid, widget.roomModel.type);
  //   showCustomDialog(context, '???? ?????????????? ?????????????????????????? ${widget.roomModel.name}');
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
  //                   child: const Text('????'),
  //                   style: ElevatedButton.styleFrom(primary: kMainBlueColor),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ));

  @override
  Widget build(BuildContext context) {
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
        title: Text('????????????????????????', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500)),
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
                      '???????????????????? ?? ????????????????????????',
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
                            Text(
                              widget.rent.title.toString(),
                              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        ),
                        CachedNetworkImage(
                          imageUrl: widget.rent.images?[0] ?? '',
                          width: 100,
                        ),
                      ],
                    ),
                    const Divider(
                      height: 30,
                      color: Colors.black,
                    ),
                    Text(
                      '${dateFormat.format(widget.dateStart)} - ${dateFormat.format(widget.dateEnd)}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '?????????????? ?? 12:00, ?????????????? ???? 12:00',
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
                        '???????????????????? ???????????????????? ????????????????????',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                      )),
                )),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(kEdgeHorizontalPadding),
                child: Column(
                  children: [
                    OrderTextFieldWidget(field: name, title: "??????", function: _setField),
                    // OrderTextFieldWidget(field: secondName, title: "??????????????", function: _setField),
                    OrderTextFieldWidget(field: phoneNumber, title: "??????????", function: _setField),
                    OrderTextFieldWidget(field: email, title: "??????????", function: _setField),
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
                          '?????????? ?? ????????????:',
                          style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${widget.totalCost} ???',
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
                      '???????????? ?????????????????? ?????????? ???????????????? ?? ???????????? ????????????????????????. ???????????????????????? ?????????? ???????????????????????? ?????????? ?????????? ?????????????? ???? ???????????? "??????????????????????????"',
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
                          '?????????????? ???????????????????????? ?? ????????????',
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
                          '???????????? ???????????????????? ?? ?????????????? ??????????????????????',
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
                  '?????????????? "??????????????????????????", ???? ???????????????????? ?????????????? ???????????????? ??????????, ???????????????????????????????? ????????????????????, ???????????????? ????????????????????????????????????, ???????????????? ?????????????????????????? cookie-????????????.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: BlocBuilder<OfficeBloc, OfficeState>(
                builder: (context, state) {
                  if (state is OfficeLiveState) {
                    return DefaultButtonWidget(
                        press: () async {
                          final bookingRent = BookingRentModel(
                              dateStart: widget.dateStart,
                              dateEnd: widget.dateEnd,
                              rentItemId: widget.rent.id,
                              rentItemName: widget.rent.title,
                              totalPrice: widget.totalCost);

                          _createOrder(context, bookingRent, state.bookingId);
                        },
                        title: '??????????????????????????');
                  } else {
                    return Center(
                      child: DefaultButtonWidget(
                        title: "????????????",
                        press: () {},
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createOrder(BuildContext context, BookingRentModel bookingRentModel, String bookingId) async {
    try {
      final response = await paymentController.makePayment(amount: widget.totalCost, currency: "RUB");
      locator.get<FirestoreRepository>().createBookingRent(bookingRentModel, bookingId);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RouterScreen(page: null)), (route) => false);
      successCreateBooking(bookingRentModel.rentItemName, context);
    } catch (e) {
      toatAuth('$e', context);
    }
  }

  void _setField(String value, String field) {
    switch (field) {
      case "??????":
        setState(() {
          name = value;
        });
        log(name.toString(), name: "NAME");
        break;
      case "??????????????":
        setState(() {
          secondName = value;
        });
        log(secondName.toString(), name: "secondName");
        break;
      case "??????????":
        setState(() {
          phoneNumber = value;
        });
        log(phoneNumber.toString(), name: "phoneNumber");
        break;
      case "??????????":
        setState(() {
          email = value;
        });
        log(email.toString(), name: "email");
        break;
    }
  }
}
