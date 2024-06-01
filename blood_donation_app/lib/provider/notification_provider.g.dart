// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationRepositoryHash() =>
    r'c074cdb2ba4209a3ef964e424f6d6407f9da0e10';

/// See also [notificationRepository].
@ProviderFor(notificationRepository)
final notificationRepositoryProvider =
    AutoDisposeProvider<NotificationRepository>.internal(
  notificationRepository,
  name: r'notificationRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotificationRepositoryRef
    = AutoDisposeProviderRef<NotificationRepository>;
String _$notificationNotifierHash() =>
    r'87f751873c3b33d51f09f18dff803730d64c3cfd';

/// See also [NotificationNotifier].
@ProviderFor(NotificationNotifier)
final notificationNotifierProvider = AutoDisposeNotifierProvider<
    NotificationNotifier, AsyncValue<List<Notifications>>>.internal(
  NotificationNotifier.new,
  name: r'notificationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotificationNotifier
    = AutoDisposeNotifier<AsyncValue<List<Notifications>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
