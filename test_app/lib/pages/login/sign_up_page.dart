import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  @override
  void dispose() async {
  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
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
                Text('Registro', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                //_crearEmail(),
                SizedBox(height: 30.0),
                //_crearPassword(),
                SizedBox(height: 30.0),
                //_crearPasswordVerification(),
                SizedBox(height: 30.0),
                //_crearBoton(),
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
        onPressed: () {
          Navigator.pop(context);
        });
  }

 /* Widget _crearEmail(SignupBloc bloc) {
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
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(SignupBloc bloc) {
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
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearPasswordVerification(SignupBloc bloc) {
    return StreamBuilder(
      stream: bloc.enableValidPassStream,
      builder: (BuildContext context, AsyncSnapshot snapshotValid) {
        return StreamBuilder(
          stream: bloc.passwordVerificationStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                obscureText: true,
                enabled: snapshotValid.hasData ? true : false,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline,
                        color: snapshotValid.hasData
                            ? Colors.deepPurple
                            : Colors.grey),
                    labelText: 'Repetir contraseña',
                    counterText: snapshot.data,
                    errorText: snapshot.error),
                onChanged: (data) {
                  bloc.changePasswordVerification({
                    "password": bloc.password,
                    "passwordVerification": data
                  });
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _crearBoton(SignupBloc bloc) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Crear cuenta'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _signup(bloc, context) : null);
      },
    );
  }

  _signup(SignupBloc bloc, BuildContext context) async {
    bool res = await AuthProvider().signUp(bloc.email, bloc.password);

    if (!res) {
      Navigator.pop(context);
      mostrarAlerta(context, '¡Error!',
          'Algo salió mal al crear una nueva cuenta.\nVerifique los datos porfavor...', true);
    } else {
      Navigator.pop(context);
      mostrarAlerta(context,'¡Exitoso!',
          'Cuenta nueva creada.\nComprueba tu identidad con el email de verificaión.\nGracias.', true);
    }
  }*/

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Nuevo usuario',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}