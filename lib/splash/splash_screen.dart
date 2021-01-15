import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/splash/splash_bloc.dart';
import 'package:flutter_app/splash/splash_repository.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen(this._repository);

  final PreferencesRepository _repository;

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashBloc _splashBloc;

  @override
  void initState() {
    _splashBloc = SplashBloc(widget._repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc'),
      ),
      body: SafeArea(
        child: StreamBuilder<UserState>(
          stream: _splashBloc.user,
          initialData: UserLoadingState(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.data is UserExistState) {
              UserExistState state = snapshot.data;
              return _buildContent(state.user);
            }
            if (snapshot.data is UserNeedLoginState) {
              return _buildLoginPage();
            }
            if (snapshot.data is UserLoadingState) {
              return _buildLoading();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoginPage() {
    return Center(
      child: RaisedButton(
        child: const Text('need log in'),
        onPressed: () {
          _splashBloc.getStoredUser();
        },
      ),
    );
  }

  Widget _buildContent(User user) {
    return Center(
      child: Text('Hello ${user.title} ${user.id}'),
    );
  }

  Widget _buildLoading() {
    _splashBloc.getStoredUser();
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    _splashBloc.dispose();
    super.dispose();
  }
}
