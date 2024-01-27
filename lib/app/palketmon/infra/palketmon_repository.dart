import 'package:fpdart/fpdart.dart';
import 'package:palketdex/app/palketmon/infra/palketmon_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'palketmon_repository.g.dart';

@Riverpod(keepAlive: true)
PalketmonRepository palketmonRepository(PalketmonRepositoryRef ref) {
  final client = Supabase.instance.client;
  return PalketmonRepository(client: client);
}

typedef FutureEither<T> = Future<Either<Exception, T>>;

class PalketmonRepository {
  final SupabaseClient client;

  static const String tableName = 'palketmon';
  static const String query = '*';

  PalketmonRepository({required this.client});

  FutureEither<List<PalketMonDto>> getPalketmons({
    required int page,
    required int size,
  }) async {
    try {
      final startAt = (page - 1) * size;
      final endAt = page * size - 1;
      final response =
          await client.from(tableName).select(query).range(startAt, endAt);

      return right(response.map((e) => PalketMonDto.fromJson(e)).toList());
    } catch (e) {
      return left(PalketmonException(e.toString()));
    }
  }

  // Search
  FutureEither<List<PalketMonDto>> searchPalketmons({
    required String query,
  }) async {
    if (query.isEmpty) {
      return right([]);
    }

    final textQuery = "'$query'";
    try {
      final response = await client
          .from(tableName)
          .select()
          .textSearch('name', textQuery, config: 'english');

      return right(response.map((e) => PalketMonDto.fromJson(e)).toList());
    } catch (e) {
      return left(PalketmonException(e.toString()));
    }
  }
}

class PalketmonException implements Exception {
  final String message;

  PalketmonException(this.message);
}
