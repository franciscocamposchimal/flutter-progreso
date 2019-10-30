import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:test_app/bloc/validators.dart';
import 'package:test_app/providers/auth_provider.dart';
import 'package:test_app/utils/utils.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _isLoadingController = BehaviorSubject<bool>();

  //Recuperamos los datos del stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  //Observable combine
  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  // Obtener el ultimo valor
  String get email => _emailController.value;
  String get password => _passwordController.value;

  Future<void> signInWithGoogle() async {
    try {
      _setIsLoading(true);
      return await AuthProvider().loginWithGoogle();
    } catch (e) {
      printError(e);
      _isLoadingController.addError(e);
    } finally {
      _setIsLoading(false);
    }
  }

  Future<bool> submit() async {
    return await AuthProvider().signInWithEmail(email, password);
  }

  dispose() async {
    await _emailController.drain();
    _emailController?.close();

    await _passwordController.drain();
    _passwordController?.close();

    await _isLoadingController.drain();
    _isLoadingController?.close();
  }
}
