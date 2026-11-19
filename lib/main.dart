import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/constants.dart';
import 'controllers/auth_controller.dart';
import 'controllers/favorite_controller.dart';
import 'pages/login_page.dart';
import 'pages/main_page.dart';
import 'services/favorite_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await _initHive();
    final prefs = await SharedPreferences.getInstance();

    Get.put(AuthController(prefs), permanent: true);
    Get.put(FavoriteController(FavoriteService()), permanent: true);

    runApp(const MyApp());
  } catch (e, st) {
    debugPrint('INIT ERROR: $e\n$st');
    runApp(InitErrorApp(message: '$e\n\n$st'));
  }
}

/// Hive.initFlutter() memakai path_provider. Kalau gagal (bug JNI di sebagian
/// versi), pakai folder cadangan supaya app tetap bisa jalan.
Future<void> _initHive() async {
  try {
    await Hive.initFlutter();
  } catch (e) {
    debugPrint('Hive.initFlutter gagal, pakai folder cadangan: $e');
    Hive.init(Directory.systemTemp.path);
  }
  await Hive.openBox(kFavoriteBox);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return GetMaterialApp(
      title: 'Keripikroll',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: kAccent,
          surface: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: kAccent,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      // Sudah login? langsung ke Main. Belum? ke Login.
      home: auth.isLoggedIn ? MainPage() : const LoginPage(),
    );
  }
}

/// Ditampilkan kalau inisialisasi gagal, supaya error terlihat di layar.
class InitErrorApp extends StatelessWidget {
  final String message;
  const InitErrorApp({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: const Text('Gagal memulai app')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SelectableText(message),
        ),
      ),
    );
  }
}
