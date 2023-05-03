// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'Data/senha_entity.dart';
import 'Data/senha_sqlite_datasource..dart';

class cadsenhas extends StatefulWidget {
  const cadsenhas({Key? key}) : super(key: key);

  @override
  _cadsenhasState createState() {
    return _cadsenhasState();
  }
}

class _cadsenhasState extends State<cadsenhas> {
  TextEditingController descricaoController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de senhas'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView(children: <Widget>[
              fieldDescricao(),
              fieldLogin(),
              fieldSenha(),
            ])
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
          onPressed: () {
            senhaSQLiteDatasource().inserirSenha(descricaoController, loginController, senhaController);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget fieldDescricao() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: descricaoController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Informe a descrição',
        ),
      ),
    );
  }

  Widget fieldLogin() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: loginController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Login',
        ),
      ),
    );
  }

  Widget fieldSenha() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: senhaController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Senha',
        ),
      ),
    );
  }
}
