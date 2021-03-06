import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen(this._repository);

  final PreferencesRepository _repository;

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        title: const Text('Log In'),
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

  @override
  void dispose() {
    _splashBloc.dispose();
    super.dispose();
  }
}
