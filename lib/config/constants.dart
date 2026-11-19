import 'package:flutter/material.dart';

/// Kredensial login (bebas, diganti di sini kalau mau).
const String kUsername = 'dmr';
const String kPassword = '123';

// Key penyimpanan
const String kFavoriteBox = 'favorites'; // box Hive
const String kPrefIsLoggedIn = 'is_logged_in'; // SharedPreferences
const String kPrefUsername = 'username'; // SharedPreferences

// API Kitsu
const String kApiHost = 'kitsu.io';
const String kApiPath = '/api/edge/anime/';

// Warna
const Color kAccent = Color(0xFFFF5722);
const Color kCard = Color(0xFF1C1C1E);
