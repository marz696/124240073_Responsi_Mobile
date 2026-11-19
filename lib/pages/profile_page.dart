import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../controllers/auth_controller.dart';
import '../controllers/favorite_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final AuthController auth = Get.find<AuthController>();
  final FavoriteController fav = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundColor: kCard,
                child: Icon(Icons.person, size: 52, color: Colors.white70),
              ),
              const SizedBox(height: 28),

              // Username dari SharedPreferences
              Obx(() => _InfoRow('Username:', auth.username.value)),
              const SizedBox(height: 8),

              // Jumlah favorit dari Hive
              Obx(() => _InfoRow('Anime Disukai:', '${fav.favorites.length}')),
              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: auth.logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
