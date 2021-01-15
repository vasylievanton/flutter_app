import 'dart:async';

import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/splash/splash_repository.dart';

class SplashBloc {
  SplashBloc(this._repository);

  final PreferencesRepository _repository;

  final _userStreamController = StreamController<UserState>();

  Stream<UserState> get user => _userStreamController.stream;

  void getStoredUser() {
    _userStreamController.sink.add(UserState._userLoading());
    _repository.getUser().then((user) {
      if (user == null) {
        _userStreamController.sink.add(UserState._userNeedLogin());
      } else {
        _userStreamController.sink.add(UserState._userExist(user));
      }
    });
  }

  void dispose() {
    _userStreamController.close();
  }
}

class UserState {
  UserState();

  factory UserState._userExist(User user) = UserExistState;

  factory UserState._userNeedLogin() = UserNeedLoginState;

  factory UserState._userLoading() = UserLoadingState;
}

class UserInitState extends UserState {}

class UserLoadingState extends UserState {}

class UserNeedLoginState extends UserState {}

class UserExistState extends UserState {
  UserExistState(this.user);

  final User user;
}
