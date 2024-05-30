import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donate_model.dart';
import '../repo/donate_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'donate_provider.g.dart';

@riverpod
DonateRepository donateRepository(DonateRepositoryRef ref) {
  return DonateRepository();
}

@riverpod
class DonateNotifier extends _$DonateNotifier {
  late final DonateRepository repository;

  @override
  AsyncValue<Donate?> build() {
    repository = ref.watch(donateRepositoryProvider);
    return const AsyncValue<Donate?>.data(null);
  }

  Future<List<Donate>> loadDonates(String userId) async {
    try {
      final donates = await repository.getDonates(userId);
      return donates;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return [];
    }
  }

  Future<void> addDonate(Donate donate) async {
    state = const AsyncValue.loading();
    try {
      await repository.addDonate(donate);
      state = AsyncValue.data(donate);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateDonate(Donate donate) async {
    state = const AsyncValue.loading();
    try {
      await repository.updateDonate(donate);
      state = AsyncValue.data(donate);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
