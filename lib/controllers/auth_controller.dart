import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constants.dart';
import '../pages/login_page.dart';
import '../pages/main_page.dart';

/// Login / logout + session di SharedPreferences.
class AuthController extends GetxController {
  final SharedPreferences _prefs;
  AuthController(this._prefs);

  final username = ''.obs;

  bool get isLoggedIn => _prefs.getBool(kPrefIsLoggedIn) ?? false;

  @override
  void onInit() {
    super.onInit();
    username.value = _prefs.getString(kPrefUsername) ?? '';
  }

  Future<void> login(String user, String pass) async {
    final u = user.trim();

    // Handling input kosong
    if (u.isEmpty || pass.isEmpty) {
      _toast('Login gagal', 'Username dan password wajib diisi');
      return;
    }

    // Handling salah kredensial
    if (u != kUsername || pass != kPassword) {
      _toast('Login gagal', 'Username atau password salah');
      return;
    }

    await _prefs.setBool(kPrefIsLoggedIn, true);
    await _prefs.setString(kPrefUsername, u);
    username.value = u;
    Get.offAll(() => MainPage());
  }

  Future<void> logout() async {
    await _prefs.remove(kPrefIsLoggedIn);
    await _prefs.remove(kPrefUsername);
    username.value = '';
    Get.offAll(() => const LoginPage());
  }

  void _toast(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }
}
