import 'package:flutter/material.dart';

import 'package:test_app/bloc/login_bloc.dart';
export 'package:test_app/bloc/login_bloc.dart';

import 'package:test_app/bloc/signup_bloc.dart';
export 'package:test_app/bloc/signup_bloc.dart';

import 'package:test_app/bloc/reports_bloc.dart';
export 'package:test_app/bloc/reports_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = new LoginBloc();
  final signupBloc = new SignupBloc();
  final reportsBloc = new ReportsBloc();
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc authBloc(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        .loginBloc;
  }

  static SignupBloc signupBlocP(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        .signupBloc;
  }

  static ReportsBloc reportsBlocP(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        .reportsBloc;
  }
}
