// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gerenciadorsenhas/Data/senha_sqlite_datasource..dart';
import 'package:gerenciadorsenhas/cadsenhas.dart';
import 'Data/perfil_sqlite_datasource.dart';
import 'cadcartao.dart';
import 'geradorsenha.dart';
import 'perfil.dart';

class menuprincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Sou Eu"),
                accountEmail: Text("Sou eu@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Favoritos"),
                  subtitle: Text("meus favoritos..."),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    debugPrint('toquei no drawer');
                  }),
              ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("Perfil"),
                  subtitle: Text("Perfil do usuário..."),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return perfilUsuario();
                    }));
                  }),
              ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("Cadastro de senhas"),
                  subtitle: Text("cadastre suas senhas..."),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return cadsenhas();
                    }));
                  }),
              ListTile(
                  leading: Icon(Icons.card_travel),
                  title: Text("Cadastro de Cartões"),
                  subtitle: Text("cadastre todos os seus cartões..."),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return cadcartao();
                    }));
                  }),
              ListTile(
                  leading: Icon(Icons.password_sharp),
                  title: Text("Gerador de senhas"),
                  subtitle: Text("Obtenha suas senhas..."),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return geradorSenha();
                    }));
                  }),
            ],
          ),
        ),
        appBar: AppBar(
            backgroundColor: Colors.teal, title: const Text('Menu Principal')),

        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Minha conta"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Senhas"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cartões"),
          ],
        ),
      ),
    );
  }
}
