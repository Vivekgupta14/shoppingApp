import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'cart.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE cart(
  id INTEGER PRIMARY KEY,
  name TEXT,
  image TEXT,       
  price REAL,       
  quantity INTEGER  
)''');
      },
    );
  }

  Future<int> addToCart(Map<String, dynamic> cartItem) async {
    final dbClient = await db;

    final List<Map<String, dynamic>> existingItems = await dbClient!.query(
      'cart',
      where: 'id = ?',
      whereArgs: [cartItem['id']],
    );

    if (existingItems.isNotEmpty) {
      final existingItem = existingItems.first;
      final int existingQuantity = existingItem['quantity'];
      final num newQuantity = existingQuantity + cartItem['quantity'];

      // Update the quantity in the cart
      int result = await dbClient.update(
        'cart',
        {
          'quantity': newQuantity,
          'price': cartItem['price'],
          'image': cartItem['image'],
        },
        where: 'id = ?',
        whereArgs: [existingItem['id']],
      );

      print('updated card item $result');
      return result;
    } else {
       int result = await dbClient.insert('cart', cartItem);
       print('new cart item $result');
       return result;
    }
  }


  Future<List<Map<String, dynamic>>> getCartItems() async {
    final dbClient = await db;
    return await dbClient!.query('cart');
  }

  Future<int> deleteCartItem(int id) async {
    final dbClient = await db;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
