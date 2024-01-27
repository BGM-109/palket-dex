import 'package:palketdex/app/core/paginate.dart';
import 'package:palketdex/app/palketmon/infra/palketmon_repository.dart';
import 'package:palketdex/app/palketmon/model/palketmon_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_palketmon_notifier.g.dart';

/// List of Palketmon
@riverpod
class GetPalketmon extends _$GetPalketmon with PaginationController<Palketmon> {
  @override
  Future<Paginate<Palketmon>> build() async {
    return await loadData(Paginate<Palketmon>(page: 1, size: 12));
  }

  @override
  Future<Paginate<Palketmon>> loadData(Paginate<Palketmon> p) async {
    final oldState = state;

    if (p.page == 1) {
      state = const AsyncLoading();
    }

    final repository = ref.read(palketmonRepositoryProvider);

    final result = await repository.getPalketmons(
      page: p.page,
      size: p.size,
    );

    return result.fold(
      (l) {
        state = AsyncError<Paginate<Palketmon>>(l, StackTrace.current)
            .copyWithPrevious(oldState);
        return p;
      },
      (r) {
        final data = r.map((e) => e.toDomain()).toList();
        return p.insertData(data);
      },
    );
  }
}
