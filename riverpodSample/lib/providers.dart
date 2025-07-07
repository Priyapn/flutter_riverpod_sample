import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_sample/model.dart';

final helloProvider = Provider<String>((ref) => "Hello");

final counterProvider = StateProvider<int>((ref) => 0);

final bulbProvider = StateProvider<Bulb>(
  (ref) => Bulb(isOn: false, brightnessPercentage: 0),
);

final authenticationProvider =
    StateNotifierProvider<AuthenticationNotifier, LoginModel>(
      (ref) => AuthenticationNotifier(),
    );

final favouriteStateProvider =
    StateNotifierProvider<FavouriteStateNotifier, FavouriteState>(
      (ref) => FavouriteStateNotifier(),
    );

final packageProvider = FutureProvider<List<String>>((ref) async {
  final response = await http.get(
    Uri.https('pub.dev', '/api/package-name-completion-data'),
  );
  await Future.delayed(Duration(seconds: 2));
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  final itemList =
      (json["packages"] as List<dynamic>)
          .map((package) => package.toString())
          .toList();
  return itemList;
});
