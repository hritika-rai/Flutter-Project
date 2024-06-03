import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../repo/user_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository();
}

@riverpod
class UserNotifier extends _$UserNotifier {
  late final UserRepository repository;

  UserNotifier() : super();

  @override
  AsyncValue<Users?> build() {
    repository = ref.watch(userRepositoryProvider);
    return const AsyncValue<Users?>.data(null);
  }

  Future<Users?> loadUser(String userId) async {
    try {
      final user = await repository.getUser(userId);
      state = AsyncValue.data(user);
      return user;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  Future<void> addUser(Users user) async {
    state = const AsyncValue.loading();
    try {
      await repository.addUser(user);
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateUser(Users user) async {
    state = const AsyncValue.loading();
    try {
      await repository.updateUser(user);
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

}
