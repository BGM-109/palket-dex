// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Example
// final oldState = state;

//     if (p.page == 1) {
//       state = const AsyncLoading();
//     }

//     final repository = ref.read(searchRepositoryProvider);

//     await Future.delayed(const Duration(seconds: 3));
//     print('loadData');
//     final result = await repository.getProfiles(
//       page: p.page,
//       size: p.size,
//     );

//     return result.fold(
//       (l) {
//         state = AsyncError<Paginate<ProfileModel>>(l, StackTrace.current)
//             .copyWithPrevious(oldState);
//         return p;
//       },
//       (r) {
//         final data = r.map((e) => e.toDomain()).toList();
//         return p.insertData(data);
//       },
//     );

/// Notifier에 페이지 네이션 기능을 추가할수있는 mixin입니다
///
mixin PaginationController<T> on AutoDisposeAsyncNotifier<Paginate<T>> {
  Future<Paginate<T>> loadData(Paginate<T> p);

  Future<void> loadMore() async {
    final oldState = state;
    // 반복된 로딩 방지
    if (state.isLoading) return;
    // 완료 되었을 때
    if (oldState.requireValue.isCompleted) return;
    state = AsyncLoading<Paginate<T>>().copyWithPrevious(oldState);
    final res = await loadData(oldState.requireValue.nextPage());
    if (state is AsyncError<Paginate<T>>) return;
    state = AsyncData(res).copyWithPrevious(oldState);
  }

  bool canLoadMore() {
    if (state.isLoading) return false;
    if (!state.hasValue) return false;
    if (state.requireValue.isCompleted) return false;
    return true;
  }

  Future<void> refresh() async {
    final oldState = state;
    state = AsyncLoading<Paginate<T>>().copyWithPrevious(oldState);
    final res = await loadData(oldState.requireValue.refresh());
    if (state is AsyncError<Paginate<T>>) return;
    state = AsyncData(res);
  }
}

class Paginate<T> {
  final int page;
  final int size;
  final bool isCompleted;
  final List<T> data;

  Paginate({
    this.page = 1,
    this.size = 10,
    this.data = const [],
    this.isCompleted = false,
  });

  Paginate<T> refresh() {
    return Paginate<T>(page: 1, size: size, data: []);
  }

  Paginate<T> nextPage() {
    return Paginate(page: page + 1, size: size, data: data);
  }

  Paginate<T> insertData(List<T> insert) {
    return Paginate<T>(
      page: page,
      size: size,
      data: [...data, ...insert],
      isCompleted: isCompleted,
    );
  }

  Paginate<T> copyWith({
    int? page,
    int? size,
    bool? isCompleted,
    List<T>? data,
  }) {
    return Paginate<T>(
      page: page ?? this.page,
      size: size ?? this.size,
      isCompleted: isCompleted ?? this.isCompleted,
      data: data ?? this.data,
    );
  }
}

ScrollController usePagination(
    VoidCallback fetchData, bool Function() isLoadMore) {
  final scrollController = useScrollController();

  void scrollListener() {
    if (isLoadMore() &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
      fetchData();
    }
  }

  useEffect(() {
    scrollController.addListener(scrollListener);

    return null;
  }, [scrollController]);

  return scrollController;
}

class InfiniteScrollWidget<T> extends HookWidget {
  const InfiniteScrollWidget(
      {super.key,
      required this.paginate,
      required this.itemBuilder,
      required this.scroll,
      required this.isLoadMore,
      this.onRefresh});
  final Paginate<T> paginate;
  final Widget Function(BuildContext, int) itemBuilder;
  final ScrollController scroll;
  final Future<void> Function()? onRefresh;
  final bool isLoadMore;
  @override
  Widget build(BuildContext context) {
    Widget lastWidget() {
      if (paginate.isCompleted) {
        return const Center(child: Text("끝"));
      }
      if (isLoadMore) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      return const SizedBox();
    }

    return RefreshIndicator.adaptive(
        onRefresh: onRefresh ?? () async {},
        child: ListView.builder(
            controller: scroll,
            itemCount: paginate.data.length + 1,
            itemBuilder: (context, index) {
              if (index == paginate.data.length) {
                return lastWidget();
              }
              return itemBuilder(context, index);
            }));
  }
}

class PaginateWidget extends StatelessWidget {
  const PaginateWidget({
    super.key,
    required this.isLoading,
    required this.hasError,
    required this.data,
    required this.errorWidget,
    required this.controller,
    required this.itemCount,
    required this.itemBuilder,
    this.onRefresh,
  });

  final bool isLoading;
  final bool hasError;
  final Widget errorWidget;
  final List data;
  final ScrollController controller;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback? onRefresh;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(bottom: 8),
        controller: controller,
        itemCount: isLoading || hasError ? itemCount + 1 : itemCount,
        itemBuilder: (context, index) {
          final isLast = index == data.length;
          if (isLast) {
            return isLoading
                ? const Center(
                    child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )),
                  )
                : errorWidget;
          }
          return itemBuilder(context, index);
        });
  }
}
