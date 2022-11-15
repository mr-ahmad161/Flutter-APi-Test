// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';

import '../model/user.dart';
import '../service/user_api.dart';

enum HomeState {
  Initial,
  Loading,
  Loaded,
  Error,
}

class UserModel extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  List<User> users = [];
  String message = '';

  UserModel() {
    _fetchUsers();
  }

  HomeState get homeState => _homeState;

  Future<void> _fetchUsers() async {
    _homeState = HomeState.Loading;
    try {
      //  await Future.delayed(const Duration(seconds: 5));
      final apiusers = await UserApi.instance?.getAllUser();
      users = apiusers!;
      _homeState = HomeState.Loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }
}
