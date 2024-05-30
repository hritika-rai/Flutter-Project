// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$requestRepositoryHash() => r'd04128bb593b3312ae54e916304c0da7b846e8e2';

/// See also [requestRepository].
@ProviderFor(requestRepository)
final requestRepositoryProvider =
    AutoDisposeProvider<RequestRepository>.internal(
  requestRepository,
  name: r'requestRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$requestRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RequestRepositoryRef = AutoDisposeProviderRef<RequestRepository>;
String _$requestNotifierHash() => r'e988a91928f86945f34a407d251346071720aba9';

/// See also [RequestNotifier].
@ProviderFor(RequestNotifier)
final requestNotifierProvider =
    AutoDisposeNotifierProvider<RequestNotifier, AsyncValue<Request?>>.internal(
  RequestNotifier.new,
  name: r'requestNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$requestNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RequestNotifier = AutoDisposeNotifier<AsyncValue<Request?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
