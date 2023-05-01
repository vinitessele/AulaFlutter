import 'package:gerenciadorsenhas/Data/cartao_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'data_container.dart';

class cartaoSQLiteDatasource {
  Future<Database> _getDatabase() async {
    // await deleteDatabase(
    //   join(await getDatabasesPath(),DATABASE_NAME),
    // );
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(CREATE_CARTAO_TABLE_SCRIPT);

        /*await db.rawInsert('''insert into $CARTAO_TABLE_NAME(
              $PERFIL_COLUMN_NOME,
              $PERFIL_COLUMN_EMAIL,
              $PERFIL_COLUMN_SENHA)
              values(
                'admin','admin@admin','123') 
              ''');*/
      },
      version: 1,
    );
  }

  Future create(CartaoEntity cartao) async {
    try {
      final Database db = await _getDatabase();
      cartao.cartaoID = await db.rawInsert('''insert into $CARTAO_TABLE_NAME(
              $CARTAO_COLUMN_DESCRICAO,
              $CARTAO_COLUMN_NUMERO,
              $CARTAO_COLUMN_VALIDADE,
              $CARTAO_COLUMN_CVV)
              values(
                '${cartao.descricao}','${cartao.numero}','${cartao.validade}','${cartao.cvv}','${cartao.senha}') 
              ''');
      queryAllRows();        
    } catch (ex) {
      return;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await _getDatabase();
    return await db.query(CARTAO_TABLE_NAME);
  }

  Future<List<CartaoEntity>> getAllPerfil() async {
    Database db = await _getDatabase();
    List<Map> dbResult = await db.rawQuery('SELECT * from $CARTAO_TABLE_NAME');

    List<CartaoEntity> cartoes = [];    
    for (var row in dbResult) {
      CartaoEntity cartao = CartaoEntity();
      cartao.cartaoID = row['cartaoID'];
      cartao.descricao = row['descricao'];
      cartao.numero = row['numero'];
      cartao.validade = row['validade'];
      cartao.senha = row['senha'];
      
      cartoes.add(cartao);
      
    }
    return cartoes;
  }  

  Future<void> atualizarCartao(CartaoEntity cartao) async {
    Database db = await _getDatabase();
    await db.transaction((txn) async {
      await txn.rawUpdate('update $CARTAO_TABLE_NAME set $CARTAO_COLUMN_DESCRICAO = ?, $CARTAO_COLUMN_NUMERO = ?, $CARTAO_COLUMN_VALIDADE = ?, $CARTAO_COLUMN_CVV = ? $CARTAO_COLUMN_SENHA '
                          'where $CARTAO_COLUMN_ID = ?', [cartao.cartaoID, cartao.numero, cartao.validade, cartao.cvv, cartao.senha]);
    });
  }    

  Future<void> deletarCartao(CartaoEntity cartao) async {
    Database db = await _getDatabase();
    await db.transaction((txn) async {
      await txn.rawUpdate('delete from $CARTAO_TABLE_NAME where id = ?', [cartao.cartaoID]);
    });
  }

  Future<List<CartaoEntity>> pesquisarCartao(String filtro) async {
  List<CartaoEntity> cartoes = [];
  Database db = await _getDatabase();
  List<Map> dbResult = await db.rawQuery('SELECT * from $CARTAO_TABLE_NAME where $CARTAO_COLUMN_DESCRICAO like ?', ['%$filtro%']);
  for (var row in dbResult) {
    CartaoEntity cartao = CartaoEntity();
    cartao.cartaoID = row['cartaoID'];
    cartao.descricao = row['descricao'];
    cartao.numero = row['numero'];
    cartao.validade = row['validade'];
    cartao.senha = row['senha'];
    
    cartoes.add(cartao);
  }
    return cartoes;
  }  
}
