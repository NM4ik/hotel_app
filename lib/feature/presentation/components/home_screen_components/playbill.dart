import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/event_model.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PlayBill extends StatefulWidget {
  const PlayBill({Key? key, required this.events}) : super(key: key);
  final List<EventModel>? events;

  @override
  State<PlayBill> createState() => _PlayBillState();
}

class _PlayBillState extends State<PlayBill> {
  late DateFormat dateFormat;


  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kEdgeVerticalPadding / 2),
        Align(
          child: Text(
            "Афиша",
            style: Theme
                .of(context)
                .textTheme
                .headline3,
          ),
          alignment: Alignment.centerLeft,
        ),
        const SizedBox(
          height: 15,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemCount: widget.events?.length,
            itemBuilder: (context, index) {
              var event = widget.events?[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kEdgeMainBorder),
                      child: CachedNetworkImage(
                        imageUrl: widget.events?[index].image ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    // '${123} - ${123}',
                    "${dateFormat.format(event!.dateStart)} - ${dateFormat.format(event!.dateEnd)}",
                    style: const TextStyle(fontFamily: "Inter", fontSize: 10, color: Colors.grey),
                  ),
                  Text(widget.events?[index].title ?? '',
                      overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme
                          .of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 14)),
                ],
              );
            }),
      ],
    );
  }
}
