import 'package:gerenciadorsenhas/Data/perfil_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'conexcao.dart';
import 'data_container.dart';

Future inserirPerfil(PerfilEntity perfil) async {
  try {
    final Database db = await Conexao.getConexaoDB();
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
  Database db = await Conexao.getConexaoDB();
  return await db.query(PERFIL_TABLE_NAME);
}

Future<List<PerfilEntity>> getAllPerfil() async {
  Database db = await Conexao.getConexaoDB();
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

Future<void> atualizarPerfil(PerfilEntity perfil) async {
  Database db = await Conexao.getConexaoDB();
  await db.transaction((txn) async {
    await txn.rawUpdate(
        'update $PERFIL_TABLE_NAME set $PERFIL_COLUMN_NOME = ?, $PERFIL_COLUMN_EMAIL = ?, $PERFIL_COLUMN_SENHA = ? where id = ?',
        [perfil.nome, perfil.email, perfil.senha]);
  });
}

Future<void> deletarPerfil(PerfilEntity perfil) async {
  Database db = await Conexao.getConexaoDB();
  await db.transaction((txn) async {
    await txn.rawUpdate(
        'delete from $PERFIL_TABLE_NAME where id = ?', [perfil.perfilID]);
  });
}

Future<List<PerfilEntity>> pesquisarPerfil(String filtro) async {
  List<PerfilEntity> perfis = [];
  Database db = await Conexao.getConexaoDB();
  List<Map> dbResult = await db.rawQuery(
      'SELECT * from $PERFIL_TABLE_NAME where $PERFIL_COLUMN_NOME like ?',
      ['%$filtro%']);
  for (var row in dbResult) {
    PerfilEntity perfil = PerfilEntity();
    perfil.perfilID = row['perfilID'];
    perfil.nome = row['nome'];
    perfil.email = row['email'];
    perfis.add(perfil);
  }
  return perfis;
}
