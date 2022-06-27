import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/feature/data/models/event_model.dart';
import 'package:hotel_ma/feature/presentation/widgets/defaut_button_widget.dart';

import '../../../common/app_constants.dart';
import 'package:intl/intl.dart';

import '../../../core/locator_service.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/sql_repository.dart';
import '../components/office_components/service_rent/office_product_detail_screen.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key, required this.eventModel}) : super(key: key);
  final EventModel eventModel;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late DateFormat dateFormat;
  final userModel = locator.get<SqlRepository>().getUserFromSql();

  @override
  void initState() {
    super.initState();
    dateFormat = DateFormat.MMMEd("ru");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              CachedNetworkImage(
                imageUrl: widget.eventModel.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding * 2, vertical: kEdgeVerticalPadding * 2),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(99), color: kMainBlueColor),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(
                              Icons.clear_rounded,
                              color: Colors.white,
                            )),
                      )),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// faq_date
                  Text(
                    'Даты проведения: ${dateFormat.format(widget.eventModel.dateStart)} - ${dateFormat.format(widget.eventModel.dateEnd)}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, color: kMainGreyColor, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.eventModel.title,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) => Text(
                      widget.eventModel.description[index],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: kEdgeVerticalPadding / 3,
                    ),
                    itemCount: widget.eventModel.description.length,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                  const SizedBox(
                    height: kEdgeVerticalPadding / 2,
                  ),
                  DefaultButtonWidget(
                      press: () async{
                        if (userModel == UserModel.empty) {
                          showCustomDialog(context, 'Нельзя записаться на мероприятие, будучи неавторизованным');
                        } else {
                          await showCustomDialog(context, 'Вы успешно записаны на данное мероприятие');
                          Navigator.of(context).pop();
                        }
                      },
                      title: "Записаться на мероприятие"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
