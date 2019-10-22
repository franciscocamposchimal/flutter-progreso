import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:test_app/bloc/validators.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperamos los datos del stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  // Insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el ultimo valor
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() async {
    await _emailController.drain();
    _emailController?.close();

    await _passwordController.drain();
    _passwordController?.close();
  }
}
