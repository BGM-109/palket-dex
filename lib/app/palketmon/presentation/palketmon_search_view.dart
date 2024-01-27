import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palketdex/app/core/async_value_widget.dart';
import 'package:palketdex/app/core/empty_screen.dart';
import 'package:palketdex/app/palketmon/presentation/palketmon_widget.dart';
import 'package:palketdex/app/palketmon/presentation/query_notifier.dart';

/// Show the Palketmon List Search Result
class PalketmonSearchView extends HookConsumerWidget {
  const PalketmonSearchView({super.key});

  static const String routeName = 'search';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(searchResultProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: const SizedBox(),
          leadingWidth: 0,
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              filled: true,
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            onChanged: (value) =>
                ref.read(searchQueryNotifierProvider.notifier).setQuery(value),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Cancel')),
            const SizedBox(width: 16)
          ],
        ),
        body: AsyncValueWidget(
          value: result,
          data: (data) => data.isEmpty
              ? const EmptyScreen()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) => PalketmonWidget.fromModel(
                    data[index],
                  ),
                ),
        ));
  }
}
