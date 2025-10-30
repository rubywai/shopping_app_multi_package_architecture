import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/cart_item_model.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();
  static Database? _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
      CREATE TABLE cart_items (
        id $idType,
        product_id $integerType,
        product_name $textType,
        product_image $textType,
        price $realType,
        quantity $integerType,
        size TEXT,
        variation_id INTEGER,
        UNIQUE(product_id, variation_id)
      )
    ''');
  }

  Future<int> insertCartItem(CartItemModel item) async {
    final db = await instance.database;

    // Check if item already exists
    final existing = await db.query(
      'cart_items',
      where:
          'product_id = ? AND variation_id ${item.variationId == null ? 'IS NULL' : '= ?'}',
      whereArgs: item.variationId == null
          ? [item.productId]
          : [item.productId, item.variationId],
    );

    if (existing.isNotEmpty) {
      // Update quantity if exists
      final existingItem = CartItemModel.fromMap(existing.first);
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + item.quantity,
      );
      return await updateCartItem(updatedItem);
    } else {
      // Insert new item
      return await db.insert('cart_items', item.toMap());
    }
  }

  Future<List<CartItemModel>> getAllCartItems() async {
    print('🛒 CartDatabase: Getting database instance...');
    final db = await instance.database;
    print('🛒 CartDatabase: Querying cart_items table...');
    final result = await db.query('cart_items');
    print('🛒 CartDatabase: Query returned ${result.length} rows');
    if (result.isNotEmpty) {
      print('🛒 CartDatabase: First row: ${result.first}');
    }
    final items = result.map((json) => CartItemModel.fromMap(json)).toList();
    print('🛒 CartDatabase: Mapped to ${items.length} CartItemModel objects');
    return items;
  }

  Future<int> updateCartItem(CartItemModel item) async {
    final db = await instance.database;
    return db.update(
      'cart_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteCartItem(int id) async {
    final db = await instance.database;
    return await db.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> clearCart() async {
    final db = await instance.database;
    return await db.delete('cart_items');
  }

  Future<int> getCartItemCount() async {
    final db = await instance.database;
    final result =
        await db.rawQuery('SELECT COUNT(*) as count FROM cart_items');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<double> getCartTotal() async {
    final items = await getAllCartItems();
    return items.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
