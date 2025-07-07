
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/fav_screen.dart';
import 'package:riverpod_sample/login_screen.dart';
import 'package:riverpod_sample/packages_screen.dart';

void main() {
  runApp(ProviderScope(child: PackagesScreen()));
}