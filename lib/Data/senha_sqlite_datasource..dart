import 'package:gerenciadorsenhas/Data/senha_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'data_container.dart';

class senhaSQLiteDatasource {
  Future<Database> _getDatabase() async {
    // await deleteDatabase(
    //   join(await getDatabasesPath(),DATABASE_NAME),
    // );
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(CREATE_SENHA_TABLE_SCRIPT);

       /* await db.rawInsert('''insert into $SENHA_TABLE_NAME(
              $SENHA_COLUMN_DESCRICAO,
              $SENHA_COLUMN_LOGIN,
              $SENHA_COLUMN_SENHA)
              values(
                'admin','admin@admin','123') 
              ''');*/
      },
      version: 1,
    );
  }

  Future inserirSenha(descricao, login, senha) async {
    try {
      final Database db = await _getDatabase();
      senha.senhaID = await db.rawInsert('''insert into $SENHA_TABLE_NAME(
              $SENHA_COLUMN_DESCRICAO,
              $SENHA_COLUMN_LOGIN,
              $SENHA_COLUMN_SENHA)
              values(
                '${senha.descricao}','${senha.login}','${senha.senha}') 
              ''');
      queryAllRows();        
    } catch (ex) {
      return;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await _getDatabase();
    return await db.query(SENHA_TABLE_NAME);
  }

  Future<List<SenhaEntity>> getAllSenha() async {
    Database db = await _getDatabase();
    List<Map> dbResult = await db.rawQuery('SELECT * from $SENHA_TABLE_NAME');

    List<SenhaEntity> senhas = [];    
    for (var row in dbResult) {
      SenhaEntity senha = SenhaEntity();
      senha.senhaID = row['senhaID'];
      senha.descricao = row['descricao'];
      senha.login = row['login'];
      senha.senha = row['senha'];      
      senhas.add(senha);
    }
    return senhas;
  }

  Future<void> atualizarSenha(SenhaEntity senha) async {
    Database db = await _getDatabase();
    await db.transaction((txn) async {
      await txn.rawUpdate('update $SENHA_TABLE_NAME set $SENHA_COLUMN_DESCRICAO = ?, $SENHA_COLUMN_LOGIN = ?, $SENHA_COLUMN_SENHA = ? where id = ?', [senha.descricao, senha.login, senha.senha]);
    });
  }    

  Future<void> deletarSenha(SenhaEntity senha) async {
    Database db = await _getDatabase();
    await db.transaction((txn) async {
      await txn.rawUpdate('delete from $SENHA_TABLE_NAME where id = ?', [senha.senhaID]);
    });
  }

  Future<List<SenhaEntity>> pesquisarSenha(String filtro) async {
  List<SenhaEntity> senhas = [];
  Database db = await _getDatabase();
  List<Map> dbResult = await db.rawQuery('SELECT * from $SENHA_TABLE_NAME where $SENHA_COLUMN_DESCRICAO like ?', ['%$filtro%']);
  for (var row in dbResult) {
    SenhaEntity senha = SenhaEntity();
    senha.senhaID = row['senhaID'];
    senha.descricao = row['descricao'];
    senha.login = row['login'];
    senha.senha = row['senha'];      
    senhas.add(senha);
  }
    return senhas;
  }
}
