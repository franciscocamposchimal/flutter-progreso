import 'dart:async';

import 'package:test_app/utils/utils.dart';

class Validators {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (isEmail(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (isPass(password)) {
      sink.add(password);
    } else {
      sink.addError('Más de 6 caracteres por favor');
    }
  });

  final matchPassword =
      StreamTransformer<Map<String, String>, String>.fromHandlers(
          handleData: (data, sink) {
    print(data);
    if (data['password'] == data['passwordVerification']) {
      sink.add(data['passwordVerification']);
    } else {
      sink.addError('Las contraseñas no coinciden');
    }
  });
}
