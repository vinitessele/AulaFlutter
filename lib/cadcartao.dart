// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class cadcartao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro cartões'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Body(),
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

Widget FieldNumero() {
  return Container(
    padding: const EdgeInsets.all(10),
    child: TextField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Número',
      ),
    ),
  );
}

Widget FieldValidade() {
  return Container(
    padding: const EdgeInsets.all(10),
    child: TextField(
      keyboardType: TextInputType.datetime,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Validade',
      ),
    ),
  );
}

Widget FieldCvv() {
  return Container(
    padding: const EdgeInsets.all(10),
    child: TextField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'CVV',
      ),
    ),
  );
}

Widget FieldDescricao() {
  return Container(
    padding: const EdgeInsets.all(10),
    child: TextField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Descrição',
      ),
    ),
  );
}

Widget FieldSenha() {
  return Container(
    padding: const EdgeInsets.all(10),
    child: TextField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Senha',
      ),
    ),
  );
}

void setState(Null Function() param0) {}

Widget textNome() {
  return Expanded(
      child: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            'Seu Nome',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )));
}

Widget CartaoFrente(context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [cartaoFront(context)],
    ),
  );
}

Widget cartaoFront(context) {
  return Container(
    width: MediaQuery.of(context).size.width * .9,
    height: 250,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 16, 121, 22)),
    child: Column(
      children: [FieldNumero(), FieldValidade(), textNome()],
    ),
  );
}

Widget CartaoAtras(context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [cartaoBack(context)],
    ),
  );
}

Widget cartaoBack(context) {
  return Container(
    width: MediaQuery.of(context).size.width * .9,
    height: 250,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.amber),
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(height: 40, color: Colors.black),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 40,
          color: Colors.grey,
        ),
        FieldCvv(),
      ],
    ),
  );
}

class Body extends StatelessWidget {
  bool mostraSenha = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FieldDescricao(),
        SizedBox(
          height: 20,
        ),
        CartaoFrente(context),
        SizedBox(
          height: 20,
        ),
        CartaoAtras(context),
        SizedBox(
          height: 20,
        ),
        FieldSenha(),
      ],
    );
  }
}
