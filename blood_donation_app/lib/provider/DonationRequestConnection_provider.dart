import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/DonationRequestConnection_model.dart';
import '../repo/DonationRequestConnection_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'DonationRequestConnection_provider.g.dart';

@riverpod
DonationRequestConnectionRepository donationRequestConnectionRepository(DonationRequestConnectionRepositoryRef ref) {
  return DonationRequestConnectionRepository();
}

@riverpod
class DonationRequestConnectionNotifier extends _$DonationRequestConnectionNotifier {
  late final DonationRequestConnectionRepository repository;

  @override
  AsyncValue<DonationRequestConnection?> build() {
    repository = ref.watch(donationRequestConnectionRepositoryProvider);
    return const AsyncValue<DonationRequestConnection?>.data(null);
  }

  Future<List<DonationRequestConnection>> loadConnections() async {
    try {
      final connections = await repository.getConnections();
      return connections;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return [];
    }
  }

  Future<void> addConnection(DonationRequestConnection connection) async {
    state = const AsyncValue.loading();
    try {
      await repository.addConnection(connection);
      state = AsyncValue.data(connection);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
