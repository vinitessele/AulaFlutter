import 'package:flutter/material.dart';
import 'package:gerenciadorsenhas/Data/cartao_entity.dart';
import 'package:gerenciadorsenhas/Data/cartao_sqlite_datasource.dart';
import 'package:gerenciadorsenhas/cadcartao.dart';
import 'package:gerenciadorsenhas/cadsenhas.dart';
import 'Data/senha_entity.dart';
import 'Data/senha_sqlite_datasource.dart';

class listaCartao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lista de",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController textEditingController;

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de senhas"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              cartaoSQLiteDatasource().deletarCartoes();
              setState(() {});
            },
            child: Text(
              "Excluir todos",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<CartaoEntity>>(
        future: cartaoSQLiteDatasource().getAllCartoes(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CartaoEntity>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                CartaoEntity item = snapshot.data![index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.green),
                  onDismissed: (direction) {
                    cartaoSQLiteDatasource().deletarCartaoID(item.cartaoID);
                  },
                  child: ListTile(
                    title: Text(item.descricao!),
                    subtitle: Text(item.numero!),
                    leading: CircleAvatar(child: Text(item.cartaoID.toString())),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(item.numero!),
                              content: Text(item.senha!),
                            );
                          });
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => cadcartao()));
          }),
    );
  }
}
