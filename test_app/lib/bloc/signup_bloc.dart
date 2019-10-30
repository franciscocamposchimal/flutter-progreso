import 'dart:async';

import 'package:test_app/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_app/providers/auth_provider.dart';

class SignupBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _passwordVerificationController =
      BehaviorSubject<Map<String, String>>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<String> get passwordVerificationStream =>
      _passwordVerificationController.stream.transform(matchPassword);

  Stream<bool> get formValidStream => Observable.combineLatest3(emailStream,
      passwordStream, passwordVerificationStream, (a, b, c) => true);

  Stream<bool> get enableValidPassStream =>
      Observable.combineLatest2(emailStream, passwordStream, (a, b) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(Map<String, String>) get changePasswordVerification =>
      _passwordVerificationController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  Map<String, String> get passwordVerification =>
      _passwordVerificationController.value;

  Future<bool> signUp() async {
    return await AuthProvider().signUp(email, password);
  }

  dispose() async {
    await _emailController.drain();
    _emailController?.close();

    await _passwordController.drain();
    _passwordController?.close();

    await _passwordVerificationController.drain();
    _passwordVerificationController?.close();
  }
}
