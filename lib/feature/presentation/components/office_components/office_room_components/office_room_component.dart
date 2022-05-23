import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';

class OfficeRoomComponent extends StatelessWidget {
  const OfficeRoomComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kEdgeMainBorder),
            color: Colors.grey[200],
          ),
          width: double.infinity,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.medical_services_outlined,
                  color: kMainBlueColor,
                  size: 45,
                ),
                const SizedBox(
                  width: kEdgeHorizontalPadding,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Вызов врача',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
                    ),
                    Text(
                      'от 1000Р',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.5), fontSize: 14),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: kMainBlueColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        shrinkWrap: true,
        itemCount: 8,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: kEdgeVerticalPadding / 3,
        ),
      ),
    );
  }
}
