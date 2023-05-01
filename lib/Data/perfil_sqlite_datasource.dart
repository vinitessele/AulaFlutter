import 'package:gerenciadorsenhas/Data/perfil_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'data_container.dart';

class PerfilSQLiteDatasource {
  Future<Database> _getDatabase() async {
    // await deleteDatabase(
    //   join(await getDatabasesPath(),DATABASE_NAME),
    // );
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(CREATE_PERFIL_TABLE_SCRIPT);

        await db.rawInsert('''insert into $PERFIL_TABLE_NAME(
              $PERFIL_COLUMN_NOME,
              $PERFIL_COLUMN_EMAIL,
              $PERFIL_COLUMN_SENHA)
              values(
                'admin','admin@admin','123') 
              ''');
      },
      version: 1,
    );
  }

  Future create(PerfilEntity perfil) async {
    try {
      final Database db = await _getDatabase();
      perfil.perfilID = await db.rawInsert('''insert into $PERFIL_TABLE_NAME(
              $PERFIL_COLUMN_NOME,
              $PERFIL_COLUMN_EMAIL,
              $PERFIL_COLUMN_SENHA)
              values(
                '${perfil.nome}','${perfil.email}','${perfil.senha}') 
              ''');
      queryAllRows();        
    } catch (ex) {
      return;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await _getDatabase();
    return await db.query(PERFIL_TABLE_NAME);
  }

  Future<List<PerfilEntity>> getAllPerfil() async {
    Database db = await _getDatabase();
    List<Map> dbResult = await db.rawQuery('SELECT * from $PERFIL_TABLE_NAME');

    List<PerfilEntity> perfis = [];    
    for (var row in dbResult) {
      PerfilEntity perfil = PerfilEntity();
      perfil.perfilID = row['perfilID'];
      perfil.nome = row['nome'];
      perfil.email = row['email'];
      
      perfis.add(perfil);
      
    }
    return perfis;
  }  

    Future<void> atualizarSenha(PerfilEntity perfil) async {
    Database db = await _getDatabase();
    await db.transaction((txn) async {
      await txn.rawUpdate('update $PERFIL_TABLE_NAME set $PERFIL_COLUMN_NOME = ?, $PERFIL_COLUMN_EMAIL = ?, $PERFIL_COLUMN_SENHA = ? where id = ?', [perfil.nome, perfil.email, perfil.senha]);
    });
  }    

  Future<void> deletarSenha(PerfilEntity perfil) async {
    Database db = await _getDatabase();
    await db.transaction((txn) async {
      await txn.rawUpdate('delete from $PERFIL_TABLE_NAME where id = ?', [perfil.perfilID]);
    });
  }

  Future<List<PerfilEntity>> pesquisarSenha(String filtro) async {
  List<PerfilEntity> perfis = [];
  Database db = await _getDatabase();
  List<Map> dbResult = await db.rawQuery('SELECT * from $PERFIL_TABLE_NAME where $PERFIL_COLUMN_NOME like ?', ['%$filtro%']);
  for (var row in dbResult) {
    PerfilEntity perfil = PerfilEntity();
    perfil.perfilID = row['perfilID'];
    perfil.nome = row['nome'];
    perfil.email = row['email'];
    perfis.add(perfil);
  }
    return perfis;
  }

}
