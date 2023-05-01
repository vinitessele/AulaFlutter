// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

Widget textoMaior() {
  return Text(
    'Esqueceu sua senha',
    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
    textAlign: TextAlign.center,
  );
}

Widget textoMenor() {
  return Text(
      'Informe seu e-mail associado a sua conta para recuperar sua senha',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,);
}

Widget fieldEmail() {
  return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: 'E-mail'));
}

Widget sizedBox() {
  return SizedBox(
    width: 200,
    height: 200,
    child: Image.network(
        "https://cdn.pixabay.com/photo/2019/10/06/11/40/lock-4529981_960_720.png"),
  );
}

class recuperarsenha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recuperar sua senha'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: _Body(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          onPressed: () {},
          child: Icon(Icons.password),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 40, right: 40),
      child: ListView(
        children: [sizedBox(), textoMaior(), textoMenor(), fieldEmail()],
      ),
    );
  }
}
