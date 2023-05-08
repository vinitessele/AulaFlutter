import 'package:flutter/material.dart';
import 'package:gerenciadorsenhas/cadsenhas.dart';
import 'Data/senha_entity.dart';
import 'Data/senha_sqlite_datasource.dart';

class listaSenhas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lista de senhas",
      theme: ThemeData(
        primarySwatch: Colors.red,
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
  late  TextEditingController textEditingController ; 

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de senhas"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              senhaSQLiteDatasource().deletarSenhas();
              setState(() {});
            },
            child: Text(
              "Excluir todos",
              style: TextStyle(color: Colors.yellow),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<SenhaEntity>>(
        future: senhaSQLiteDatasource().getAllSenha(),
        builder: (BuildContext context, AsyncSnapshot<List<SenhaEntity>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                SenhaEntity item = snapshot.data![index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    senhaSQLiteDatasource().deletarSenhaID(item.senhaID);
                  },
                  child: ListTile(
                    title: Text(item.descricao!),
                    subtitle: Text(item.login!),
                    leading: CircleAvatar(child: Text(item.senhaID.toString())),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => cadsenhas()));
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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => cadsenhas()));
          }),
    );
  }
}
