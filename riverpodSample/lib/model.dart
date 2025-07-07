import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/helper.dart';

class Bulb {
  final bool isOn;
  final double brightnessPercentage;

  Bulb({required this.isOn, required this.brightnessPercentage});

  Bulb copyWith({bool? isOn, double? brightnessPercentage}) {
    return Bulb(
      isOn: isOn ?? this.isOn,
      brightnessPercentage: brightnessPercentage ?? this.brightnessPercentage,
    );
  }
}

class AuthenticationNotifier extends StateNotifier<LoginModel> {
  AuthenticationNotifier()
    : super(LoginModel(email: null, password: null, isValidCredential: false));

  void updateEmail(String email) {
    bool isValidCredential =
        email.isNotEmpty &&
        validateEmail(email) &&
        state.password?.trim().isNotEmpty == true;
    state = state.copyWith(email: email, isValidCredential: isValidCredential);
  }

  void updatePassword(String password) {
    bool isValidCredential =
        state.email?.isNotEmpty == true &&
        validateEmail(state.email ?? "") &&
        password.trim().isNotEmpty;
    state = state.copyWith(
      password: password,
      isValidCredential: isValidCredential,
    );
  }

  void loginUser() {
    state = state.copyWith(isLoading: true);
  }
}

class LoginModel {
  final String? email;
  final String? password;
  final bool isValidCredential;
  final bool isLoading;

  LoginModel({
    required this.email,
    required this.password,
    required this.isValidCredential,
    this.isLoading = false,
  });

  LoginModel copyWith({
    String? email,
    String? password,
    bool? isValidCredential,
    bool? isLoading,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      isValidCredential: isValidCredential ?? this.isValidCredential,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class Item {
  final int id;
  final String name;
  bool isFavourite;

  Item({required this.id, required this.name, required this.isFavourite});

  Item copyWith({int? id, String? name, bool? isFavourite}) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}

class FavouriteState {
  final List<Item> itemList;
  final List<Item> filteredItemList;
  final String searchQuery;

  FavouriteState({
    required this.itemList,
    required this.filteredItemList,
    required this.searchQuery,
  });

  FavouriteState copyWith({
    List<Item>? itemList,
    List<Item>? filteredItemList,
    String? searchQuery,
  }) {
    return FavouriteState(
      itemList: itemList ?? this.itemList,
      filteredItemList: filteredItemList ?? this.filteredItemList,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class FavouriteStateNotifier extends StateNotifier<FavouriteState> {
  FavouriteStateNotifier()
    : super(
        FavouriteState(
          itemList: getItemList(),
          filteredItemList: getItemList(),
          searchQuery: "",
        ),
      );

  void toggleFavItem(int id, bool isFav) {
    state.itemList.firstWhere((item) => item.id == id).isFavourite = isFav;
    state = state.copyWith();
  }

  void searchItem(String query) {
    if (query.trim().isEmpty) {
      state = state.copyWith(
        searchQuery: query,
        filteredItemList: state.itemList,
      );
    } else {
      state = state.copyWith(
        searchQuery: query,
        filteredItemList:
            state.itemList
                .where(
                  (item) =>
                      item.name.toLowerCase().contains(query.toLowerCase()),
                )
                .toList(),
      );
    }
  }

  static List<Item> getItemList() {
    return [
      Item(id: 1, name: "Mac Book Pro", isFavourite: false),
      Item(id: 2, name: "iPhone s", isFavourite: false),
      Item(id: 3, name: "iPhone Pro Max", isFavourite: false),
      Item(id: 4, name: "Google Pixel", isFavourite: false),
      Item(id: 5, name: "One Plus", isFavourite: false),
      Item(id: 6, name: "Samsung S6", isFavourite: false),
      Item(id: 7, name: "Redmi", isFavourite: false),
    ];
  }
}
