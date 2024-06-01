// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$donateRepositoryHash() => r'a65722e74341b5642feff3f8727e023e007428a9';

/// See also [donateRepository].
@ProviderFor(donateRepository)
final donateRepositoryProvider = AutoDisposeProvider<DonateRepository>.internal(
  donateRepository,
  name: r'donateRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$donateRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DonateRepositoryRef = AutoDisposeProviderRef<DonateRepository>;
String _$donateNotifierHash() => r'06bc375a0be0096997df0f7723b5738c027d0f3c';

/// See also [DonateNotifier].
@ProviderFor(DonateNotifier)
final donateNotifierProvider =
    AutoDisposeNotifierProvider<DonateNotifier, AsyncValue<Donor?>>.internal(
  DonateNotifier.new,
  name: r'donateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$donateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DonateNotifier = AutoDisposeNotifier<AsyncValue<Donor?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
