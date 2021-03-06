import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passcontroller = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body:
          ScopedModelDescendant<UserModel>(builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator(),);
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Nome Completo",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (text) {
                    if (text.isEmpty) return "Nome Inválido!";
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "Email Inválido!";
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                TextFormField(
                  controller: _passcontroller,
                  decoration: InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválida!";
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: "Endereço",
                  ),
                  validator: (text) {
                    if (text.isEmpty) return "Endereço inválido!";
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                SizedBox(
                  height: 44,
                  child: FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {  
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "address": _addressController.text
                        };

                        model.signUp(  
                          onFail: _onFail,
                          onSucess: _onSuccess,
                          userData: userData,
                          pass: _passcontroller.text
                        );
                      }
                    },
                    child: Text(
                      "Criar Conta",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          );
        }));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar( 
      SnackBar(  
        content: Text("Usuário criado com sucesso"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pop(context);
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(  
      SnackBar(  
        content: Text("Falha ao criar usuário!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      )
    );
  }
  
}



