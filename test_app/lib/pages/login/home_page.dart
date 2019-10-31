import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:test_app/bloc/provider.dart';
import 'package:test_app/utils/utils.dart';
import 'package:test_app/widgets/custom_widgets.dart';

ProgressDialog pr;

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          crearFondo(context, 'Sesión de usuario'),
          _loginForm(context)
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final authBloc = Provider.authBloc(context);
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
            padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
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
                Text('Inicia sesión', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 40.0),
                _crearEmail(authBloc),
                SizedBox(height: 30.0),
                _crearPassword(authBloc),
                SizedBox(height: 30.0),
                _crearBoton(authBloc),
                SizedBox(height: 20.0),
                _passwordReset(context),
              ],
            ),
          ),
          _socialDivider(),
          SizedBox(height: 40.0),
          _signInButtons(context, authBloc),
          _newAccount(context),
          //SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _signInButtons(BuildContext context, LoginBloc bloc) {
    pr.style(message: 'Espere un momento porfavor...');
    return Column(
      children: <Widget>[
        StreamBuilder(
            stream: bloc.isLoadingStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              printDebug('SNAP: ${snapshot.data}');
              return SignInButton(Buttons.Google,
                  text: '   Entrar con Google',
                  onPressed: () async => _sigInGoogleTrue(bloc));
            }),
      ],
    );
  }

  _sigInGoogleTrue(LoginBloc bloc) async {
    // pr.show();
    // if (pr.isShowing()) {
    //   pr.hide();
    //   await bloc.signInWithGoogle();
    // }
    await bloc.signInWithGoogle();
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',
                counterText: snapshot.data,
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                    labelText: 'Contraseña',
                    counterText: snapshot.data,
                    errorText: snapshot.error),
                onChanged: bloc.changePassword),
          );
        });
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                child: Text('Ingresar'),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 10.0,
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: snapshot.hasData ? () => _login(bloc, context) : null);
        });
  }

  _login(LoginBloc bloc, BuildContext context) async {
    //bool res = await AuthProvider().signInWithEmail(bloc.email, bloc.password);
    bool res = await bloc.submit();
    if (!res) {
      mostrarAlerta(context, '¡Error!', 'Algo salió mal...', true);
    }
  }

  Widget _newAccount(BuildContext context) {
    return FlatButton(
        child: Text(
          '¿Crear cuenta nueva?',
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () => Navigator.pushNamed(context, '/signup'));
  }

  Widget _passwordReset(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
            child: Text(
              '¿Olvidó su contraseña?',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent),
            ),
            onPressed: () => Navigator.pushNamed(context, '/resetPassword')),
      ],
    );
  }

  Widget _socialDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        horizontalLine(),
        Text("Acceso rápido con",
            style: TextStyle(fontSize: 16.0, fontFamily: "Poppins-Medium")),
        horizontalLine()
      ],
    );
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 80.0,
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );
}
