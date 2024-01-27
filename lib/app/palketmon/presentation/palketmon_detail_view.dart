import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palketdex/app/palketmon/model/palketmon_model.dart';

/// This Widget is used to display Palketmon. id is Palketmon's id.
class PalketmonDetailView extends StatelessWidget {
  const PalketmonDetailView(
      {super.key, required this.pid, required this.extra});
  final String pid;
  final Palketmon extra;

  static const String routeName = 'palketmon';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pid),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl: extra.img,
                  fit: BoxFit.contain,
                )),
            const SizedBox(height: 16),
            Text('${extra.palnumber} ${extra.name}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text('element : ${extra.palelement}'),
            const SizedBox(height: 16),
            Text('skill : ${extra.palskill}'),
            const SizedBox(height: 16),
            Text('works for : ${extra.palworksfor}'),
            const SizedBox(height: 16),
            Text('drops : ${extra.paldrops}'),
          ],
        ),
      ),
    );
  }
}
