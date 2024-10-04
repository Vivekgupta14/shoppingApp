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

          await db.execute('''CREATE TABLE wishlist(
  id INTEGER PRIMARY KEY,
  name TEXT,
  image TEXT,       
  price REAL
)''');
        }
    );
  }

  Future<int> addToWishlist(Map<String, dynamic> wishlistItem) async {
    final dbClient = await db;
    int result =await dbClient!.insert('wishlist', wishlistItem, conflictAlgorithm: ConflictAlgorithm.replace);
    print('add to wishlist called');
    return result;
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
      final int existingQuantity = existingItem['quantity'] ; // Ensure this is not null
      final num newQuantity = existingQuantity + (cartItem['quantity'] ); // Handle possible null


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

      return result;
    } else {
      int result = await dbClient.insert('cart', cartItem);
      return result;
    }
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final dbClient = await db;
    return await dbClient!.query('cart');
  }
  Future<List<Map<String, dynamic>>> getWishlistItems() async {
    final dbClient = await db;
    return await dbClient!.query('wishlist');
  }

  Future<int> deleteCartItem(int id) async {
    final dbClient = await db;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteWishlistItem(int id) async {
    final dbClient = await db;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
  Future<void> clearTable(String cart) async {
    final dbClient = await db;
    await dbClient!.delete(cart);
    print('$cart has been cleared.');
  }
  Future<double> getTotalAmount() async {
    final dbClient = await db;
    final result = await dbClient!.rawQuery(
        'SELECT SUM(price * quantity) as total FROM cart'
    );
    return result.first['total'] != null ? result.first['total'] as double : 0.0;
  }
}
