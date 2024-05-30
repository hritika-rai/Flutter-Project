import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/request_model.dart';
import '../repo/request_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_provider.g.dart';

@riverpod
RequestRepository requestRepository(RequestRepositoryRef ref) {
  return RequestRepository();
}

@riverpod
class RequestNotifier extends _$RequestNotifier {
  late final RequestRepository repository;

  @override
  AsyncValue<Request?> build() {
    repository = ref.watch(requestRepositoryProvider);
    return const AsyncValue<Request?>.data(null);
  }

  Future<Request?> loadRequest(String requestId, String userId) async {
    try {
      final request = await repository.getRequest(requestId, userId);
      state = AsyncValue.data(request);
      return request;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  Future<void> addRequest(Request request) async {
    state = const AsyncValue.loading();
    try {
      await repository.addRequest(request);
      state = AsyncValue.data(request);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateRequest(Request request) async {
    state = const AsyncValue.loading();
    try {
      await repository.updateRequest(request);
      state = AsyncValue.data(request);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}