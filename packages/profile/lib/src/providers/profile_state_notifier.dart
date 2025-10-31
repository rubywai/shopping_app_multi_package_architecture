import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../data/models/customer_model.dart';
import '../data/services/profile_service.dart';

class ProfileState {
  final bool isLoading;
  final CustomerModel? customer;
  final String? error;

  ProfileState({
    this.isLoading = false,
    this.customer,
    this.error,
  });

  ProfileState copyWith({
    bool? isLoading,
    CustomerModel? customer,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      customer: customer ?? this.customer,
      error: error,
    );
  }
}

class ProfileStateNotifier extends Notifier<ProfileState> {
  late final ProfileService _profileService;

  @override
  ProfileState build() {
    _profileService = GetIt.instance.get<ProfileService>();
    return ProfileState();
  }

  Future<void> loadProfile(String customerId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final customer = await _profileService.getCustomer(customerId);
      state = state.copyWith(
        isLoading: false,
        customer: customer,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> updateCustomer(
      String customerId, Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _profileService.updateCustomer(customerId, data);

      // Reload profile to get fresh data
      final customer = await _profileService.getCustomer(customerId);
      state = state.copyWith(
        isLoading: false,
        customer: customer,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  void clearProfile() {
    state = ProfileState();
  }
}

final profileStateNotifierProvider =
    NotifierProvider<ProfileStateNotifier, ProfileState>(
  () => ProfileStateNotifier(),
);
