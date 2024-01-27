import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:palketdex/app/palketmon/presentation/palketmon_detail_view.dart';

import '../model/palketmon_model.dart';

class PalketmonWidget extends StatelessWidget {
  const PalketmonWidget(
      {super.key,
      required this.img,
      required this.name,
      required this.palnumber,
      required this.palelement,
      required this.palskill,
      required this.palworksfor,
      required this.paldrops,
      required this.extra});
  final String img;
  final String name;
  final String palnumber;
  final String palelement;
  final String palskill;
  final String palworksfor;
  final String paldrops;
  final Palketmon extra;

  factory PalketmonWidget.fromModel(Palketmon palketmon) {
    return PalketmonWidget(
        img: palketmon.img,
        name: palketmon.name,
        palnumber: palketmon.palnumber,
        palelement: palketmon.palelement,
        palskill: palketmon.palskill,
        palworksfor: palketmon.palworksfor,
        paldrops: palketmon.paldrops,
        extra: palketmon);
  }

  @override
  Widget build(BuildContext context) {
    final text = '$palnumber. $name';

    return GestureDetector(
      onTap: () {
        context.goNamed(PalketmonDetailView.routeName,
            pathParameters: {
              'pid': palnumber,
            },
            extra: extra);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                imageUrl: img,
                width: 100,
              )),
          const SizedBox(height: 10),
          Text(text),
        ],
      ),
    );
  }
}
