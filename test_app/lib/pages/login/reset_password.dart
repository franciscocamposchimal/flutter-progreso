import 'package:flutter/material.dart';
import 'package:test_app/providers/auth_provider.dart';
import 'package:test_app/utils/utils.dart' as utils;
import 'package:test_app/widgets/custom_widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final authProvider = AuthProvider();
  final _formKey = GlobalKey<FormState>();
  String _emailToreset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        crearFondo(context, '¿Olvidaste tu contraseña?'),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Resetea tu contraseña', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearEmail(),
                SizedBox(height: 30.0),
                _crearBoton(),
                SizedBox(height: 30.0),
              ],
            ),
          ),
          //SizedBox(height: 100.0)
          _goBack(context)
        ],
      ),
    );
  }

  Widget _goBack(BuildContext context) {
    return FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.arrow_back,
              color: Colors.blueAccent,
            ),
            SizedBox(width: 5.0),
            Text(
              'Regresar',
              style: TextStyle(color: Colors.blueAccent),
            )
          ],
        ),
        onPressed: () => Navigator.pop(context));
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
            ),
            validator: (value) {
              if (utils.isEmail(value)) {
                setState(() {
                  _emailToreset = value;
                });
                return null;
              } else {
                return 'Email no es correcto';
              }
            }),
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Enviar email'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 0.0,
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed: () =>
            _formKey.currentState.validate() ? _signup(context) : null);
  }

  void _signup(BuildContext context) async {
    bool res = await AuthProvider().resetPassword(_emailToreset);
    if (!res) {
      Navigator.pop(context);
      utils.mostrarAlerta(
          context,
          '¡Error!',
          'Algo salió mal al enviar email.\nVerifique los datos porfavor...',
          true);
    } else {
      Navigator.pop(context);
      utils.mostrarAlerta(context, '¡Exitoso!',
          'Verifica tu email para cambiar la contraseña.\nGracias.', true);
    }
  }
}
