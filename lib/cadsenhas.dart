// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class cadsenhas extends StatefulWidget {
  const cadsenhas({Key? key}) : super(key: key);

  @override
  cadsenhasState createState() {
    return cadsenhasState();
  }
}

class cadsenhasState extends State<cadsenhas> {
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
        body: _Body(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(children: <Widget>[
          fieldDescricao(),
          fieldLogin(),
          fieldSenha(),
        ])
      ],
    );
  }


Widget fieldDescricao() {
  return Container(
    padding: const EdgeInsets.all(10),
    child: TextField(
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
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Senha',
      ),
    ),
  );
}
}
