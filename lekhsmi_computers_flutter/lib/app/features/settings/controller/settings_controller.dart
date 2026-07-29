import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';

class SettingsController extends GetxController {
  final RxString storeName = 'LEKSHMI COMPUTERS'.obs;
  final RxString storePhone = '+91 9876543210'.obs;
  final RxString storeEmail = 'lekhsmicomputers@gmail.com'.obs;
  final RxString storeWebsite = 'www.lekhsmicomputers.com'.obs;
  final RxString storeAddress = '35/111-A, Court Road, Thuckalay'.obs;

  final RxBool isLoading = false.obs;
  int? _currentId;

  @override
  void onInit() {
    super.onInit();
    fetchStoreSettings();
  }

  Future<void> fetchStoreSettings() async {
    try {
      isLoading.value = true;
      final client = Get.find<Client>();
      final profile = await client.profile.getProfile();
      _currentId = profile.id;
      storeName.value = profile.storeName;
      storePhone.value = profile.phone;
      storeEmail.value = profile.email;
      storeWebsite.value = profile.website ?? '';
      storeAddress.value = profile.address;
    } catch (e) {
      debugPrint('Error fetching store profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateStoreSettings({
    required String name,
    required String phone,
    required String email,
    required String website,
    required String address,
  }) async {
    try {
      isLoading.value = true;
      final client = Get.find<Client>();
      final profile = Profile(
        id: _currentId,
        storeName: name,
        phone: phone,
        email: email,
        website: website.trim().isEmpty ? null : website.trim(),
        address: address,
      );

      final updated = await client.profile.saveProfile(
        profile: profile,
      );
      _currentId = updated.id;
      storeName.value = updated.storeName;
      storePhone.value = updated.phone;
      storeEmail.value = updated.email;
      storeWebsite.value = updated.website ?? '';
      storeAddress.value = updated.address;

      Get.snackbar(
        'Success',
        'Store information updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
      return true;
    } catch (e) {
      debugPrint('Error updating store profile: $e');
      Get.snackbar(
        'Error',
        'Failed to update store information: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
