// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchResultHash() => r'7f7c01d037a71acf7ef4ffc436962a9212bcb5ae';

/// Showing List of Palketmon Listen to SearchQueryNotifier
///
/// Search Result
///
/// Copied from [searchResult].
@ProviderFor(searchResult)
final searchResultProvider =
    AutoDisposeFutureProvider<List<Palketmon>>.internal(
  searchResult,
  name: r'searchResultProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchResultHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SearchResultRef = AutoDisposeFutureProviderRef<List<Palketmon>>;
String _$searchListHash() => r'b47ffff4893bf82537909e78fc6cde3ff6025931';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// A provider that provides a list when searching.
///
/// If the search query changes, create a new provider.
///
/// There is a 30-second timeout.
///
/// Copied from [searchList].
@ProviderFor(searchList)
const searchListProvider = SearchListFamily();

/// A provider that provides a list when searching.
///
/// If the search query changes, create a new provider.
///
/// There is a 30-second timeout.
///
/// Copied from [searchList].
class SearchListFamily extends Family<AsyncValue<List<Palketmon>>> {
  /// A provider that provides a list when searching.
  ///
  /// If the search query changes, create a new provider.
  ///
  /// There is a 30-second timeout.
  ///
  /// Copied from [searchList].
  const SearchListFamily();

  /// A provider that provides a list when searching.
  ///
  /// If the search query changes, create a new provider.
  ///
  /// There is a 30-second timeout.
  ///
  /// Copied from [searchList].
  SearchListProvider call({
    required String query,
  }) {
    return SearchListProvider(
      query: query,
    );
  }

  @override
  SearchListProvider getProviderOverride(
    covariant SearchListProvider provider,
  ) {
    return call(
      query: provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchListProvider';
}

/// A provider that provides a list when searching.
///
/// If the search query changes, create a new provider.
///
/// There is a 30-second timeout.
///
/// Copied from [searchList].
class SearchListProvider extends AutoDisposeFutureProvider<List<Palketmon>> {
  /// A provider that provides a list when searching.
  ///
  /// If the search query changes, create a new provider.
  ///
  /// There is a 30-second timeout.
  ///
  /// Copied from [searchList].
  SearchListProvider({
    required String query,
  }) : this._internal(
          (ref) => searchList(
            ref as SearchListRef,
            query: query,
          ),
          from: searchListProvider,
          name: r'searchListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchListHash,
          dependencies: SearchListFamily._dependencies,
          allTransitiveDependencies:
              SearchListFamily._allTransitiveDependencies,
          query: query,
        );

  SearchListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Palketmon>> Function(SearchListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchListProvider._internal(
        (ref) => create(ref as SearchListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Palketmon>> createElement() {
    return _SearchListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchListProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchListRef on AutoDisposeFutureProviderRef<List<Palketmon>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchListProviderElement
    extends AutoDisposeFutureProviderElement<List<Palketmon>>
    with SearchListRef {
  _SearchListProviderElement(super.provider);

  @override
  String get query => (origin as SearchListProvider).query;
}

String _$searchQueryNotifierHash() =>
    r'259abd0dbbdce2e4c133e217bb4ccefd975386a0';

/// Manage search query on TextField with Debouncer
///
/// Copied from [SearchQueryNotifier].
@ProviderFor(SearchQueryNotifier)
final searchQueryNotifierProvider =
    AutoDisposeNotifierProvider<SearchQueryNotifier, String>.internal(
  SearchQueryNotifier.new,
  name: r'searchQueryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchQueryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchQueryNotifier = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
