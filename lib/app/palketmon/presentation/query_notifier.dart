import 'dart:async';

import 'package:palketdex/app/palketmon/infra/palketmon_repository.dart';
import 'package:palketdex/app/palketmon/model/palketmon_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
part 'query_notifier.g.dart';

/// Manage search query on TextField with Debouncer
@riverpod
class SearchQueryNotifier extends _$SearchQueryNotifier with NotifierDebouncer {
  @override
  String build() => init('');
}

/// Showing List of Palketmon Listen to SearchQueryNotifier
///
/// Search Result
@riverpod
Future<List<Palketmon>> searchResult(SearchResultRef ref) {
  final searchQuery = ref.watch(searchQueryNotifierProvider);
  return ref.watch(searchListProvider(query: searchQuery).future);
}

/// Debounce for Notifier
mixin NotifierDebouncer on AutoDisposeNotifier<String> {
  final _searchQueryController = StreamController<String>();
  late final StreamSubscription<String> _subscription;

  String init(String value) {
    _subscription = _searchQueryController.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen(_updateState);
    ref.onDispose(() {
      _searchQueryController.close();
      _subscription.cancel();
    });

    return value;
  }

  void _updateState(String query) {
    state = query;
  }

  void setQuery(String query) {
    _searchQueryController.sink.add(query);
  }
}

/// A provider that provides a list when searching.
///
/// If the search query changes, create a new provider.
///
/// There is a 30-second timeout.
@riverpod
Future<List<Palketmon>> searchList(SearchListRef ref,
    {required String query}) async {
  final link = ref.keepAlive();

  Timer? timer;

  ref.onDispose(() {
    timer?.cancel();
  });

  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), () {
      link.close();
    });
  });
  ref.onResume(() {
    timer?.cancel();
  });

  final repository = ref.read(palketmonRepositoryProvider);

  final result = await repository.searchPalketmons(query: query);

  return result.fold((l) => [], (r) => r.map((e) => e.toDomain()).toList());
}
