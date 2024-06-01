import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notification_model.dart';
import '../repo/notification_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_provider.g.dart';

@riverpod
NotificationRepository notificationRepository(NotificationRepositoryRef ref) {
  return NotificationRepository();
}

@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  late final NotificationRepository repository;

  @override
  AsyncValue<List<Notifications>> build() {
    repository = ref.watch(notificationRepositoryProvider);
    return const AsyncValue.loading();
  }

  Future<void> loadNotifications(String userId) async {
    state = const AsyncValue.loading();
    try {
      final notifications = await repository.getNotifications(userId);
      state = AsyncValue.data(notifications);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addNotification(String userId, Notifications notification) async {
    try {
      await repository.addNotification(userId, notification);
      await loadNotifications(userId); 
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> deleteNotification(String userId, String notificationId) async {
    try {
      await repository.deleteNotification(userId, notificationId);
      await loadNotifications(userId); 
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
