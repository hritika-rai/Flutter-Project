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
  
  Future<List<Request>> loadRequests(String userId) async {
    try {
      final requests = await repository.getRequests(userId);
      return requests;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return [];
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

  Future<List<Request>> loadOtherRequests(String userId) async {
    try {
      final otherRequests = await repository.getOtherRequests(userId);
      return otherRequests;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return [];
    }
  }

  Future<List<Request>> loadAllRequests() async {
    try {
      final otherRequests = await repository.getAllRequests();
      return otherRequests;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return [];
    }
  }

  Future<Request?> loadRequestById(String requestId) async {
    try {
      return await repository.getRequestById(requestId);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  Future<void> updateRequest(Request request) async {
    state = const AsyncValue.loading();
    try {
      await repository.updateRequest(request);
      state = AsyncValue.data(request);
      print('uodated');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
