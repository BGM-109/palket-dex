import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palketdex/app/core/async_value_widget.dart';
import 'package:palketdex/app/core/paginate.dart';
import 'package:palketdex/app/palketmon/model/palketmon_model.dart';
import 'package:palketdex/app/palketmon/presentation/get_palketmon_notifier.dart';
import 'package:palketdex/app/palketmon/presentation/palketmon_search_view.dart';

import 'palketmon_widget.dart';

/// Show the Palketmon List
class PalketmonView extends HookConsumerWidget {
  const PalketmonView({super.key});
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palketmons = ref.watch(getPalketmonProvider);
    final pagination = usePagination(
        ref.read(getPalketmonProvider.notifier).loadMore,
        ref.read(getPalketmonProvider.notifier).canLoadMore);

    void goToTop() {
      pagination.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: goToTop,
          child: const Icon(Icons.arrow_upward),
        ),
        appBar: AppBar(
          title: const Text('Palketmon'),
          actions: [
            IconButton(
              onPressed: () {
                context.goNamed(PalketmonSearchView.routeName);
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: AsyncValueWidget<Paginate<Palketmon>>(
          value: palketmons,
          data: (data) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            controller: pagination,
            itemCount: data.data.length,
            itemBuilder: (context, index) => PalketmonWidget.fromModel(
              data.data[index],
            ),
          ),
        ));
  }
}
