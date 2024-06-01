import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donor_model.dart';
import '../repo/donor_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'donor_provider.g.dart';

@riverpod
DonateRepository donateRepository(DonateRepositoryRef ref) {
  return DonateRepository();
}

@riverpod
class DonateNotifier extends _$DonateNotifier {
  late final DonateRepository repository;

  @override
  AsyncValue<Donor?> build() {
    repository = ref.watch(donateRepositoryProvider);
    return const AsyncValue<Donor?>.data(null);
  }

  Future<List<Donor>> loadDonates(String userId) async {
    try {
      final donors = await repository.getDonates(userId);
      return donors;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return [];
    }
  }

  Future<void> addDonate(Donor donor) async {
    state = const AsyncValue.loading();
    try {
      await repository.addDonate(donor);
      state = AsyncValue.data(donor);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<List<Donor>> loadDonorsByBloodGroupAndLocation(String userId, String bloodGroup, String location) async {
    try {
      final donors = await repository.getDonorsByBloodGroupAndLocation(userId, bloodGroup, location);
      return donors;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return [];
    }
  }

  Future<void> updateDonate(Donor donor) async {
    state = const AsyncValue.loading();
    try {
      await repository.updateDonate(donor);
      state = AsyncValue.data(donor);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
