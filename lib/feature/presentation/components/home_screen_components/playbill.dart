import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_constants.dart';

class PlayBill extends StatelessWidget {
  const PlayBill({Key? key, required this.events}) : super(key: key);
  final List<Map<String, dynamic>>? events;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: kEdgeVerticalPadding/2
        ),
        Align(
          child: Text(
            "Афиша",
            style: Theme.of(context).textTheme.headline3,
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
            itemCount: events?.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kEdgeMainBorder),
                      child: CachedNetworkImage(
                        imageUrl: events?[index]['image'] ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'до ${(events?[index]['dateEnd'] as Timestamp).toDate()}',
                    style: const TextStyle(fontFamily: "Inter", fontSize: 10, color: Colors.grey),
                  ),
                  Text(events?[index]['name'],
                      overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 14)),
                ],
              );
            }),
      ],
    );
  }
}
