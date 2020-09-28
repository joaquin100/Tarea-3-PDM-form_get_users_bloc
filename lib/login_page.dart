import 'package:flutter/material.dart';
import 'package:form_get_users_bloc/home/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  // ignore: override_on_non_overriding_member
  final _formKey = GlobalKey<FormState>();
  bool _isTextHidden = true;
  TextEditingController _userTextController;
  TextEditingController _passwordtextController;

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //Username tf
                TextFormField(
                  controller: _userTextController,
                  decoration: InputDecoration(
                    hintText: "Ingresar usuario",
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Favor de ingresar algo";
                    } else {
                      return null;
                    }
                  },
                ),
                //password tf
                TextFormField(
                  controller: _passwordtextController,
                  obscureText: _isTextHidden,
                  decoration: InputDecoration(
                    hintText: "Ingresar password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_isTextHidden
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        _isTextHidden = !_isTextHidden;
                      },
                    ),
                  ),
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Favor de ingresar algo";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  onPressed: _openHomePage,
                  child: Text("Ingresar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//validation method on pressed
  _openHomePage() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      );
    } else {
      return Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("Falta completar formulario"),
          ),
        );
    }
  }
}
