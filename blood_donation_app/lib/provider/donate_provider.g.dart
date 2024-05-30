// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_provider.dart';

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
String _$donateNotifierHash() => r'ff11f8eb28bbe7445898fd4de2811cdb0333779c';

/// See also [DonateNotifier].
@ProviderFor(DonateNotifier)
final donateNotifierProvider =
    AutoDisposeNotifierProvider<DonateNotifier, AsyncValue<Donate?>>.internal(
  DonateNotifier.new,
  name: r'donateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$donateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DonateNotifier = AutoDisposeNotifier<AsyncValue<Donate?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
