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
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Drop old table and recreate with new schema
      await db.execute('DROP TABLE IF EXISTS cart_items');
      await _createDB(db, newVersion);
    }
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
        formatted_price TEXT,
        quantity $integerType,
        size TEXT,
        color TEXT,
        variation_id INTEGER,
        UNIQUE(product_id, size, color, variation_id)
      )
    ''');
  }

  Future<int> insertCartItem(CartItemModel item) async {
    final db = await instance.database;

    // Check if item already exists based on product_id, size, color, and variation_id
    String whereClause;
    List<dynamic> whereArgs;

    if (item.size != null && item.color != null) {
      // If both size and color are provided
      whereClause = 'product_id = ? AND size = ? AND color = ?';
      whereArgs = [item.productId, item.size, item.color];
    } else if (item.size != null) {
      // If only size is provided
      whereClause = 'product_id = ? AND size = ? AND color IS NULL';
      whereArgs = [item.productId, item.size];
    } else if (item.color != null) {
      // If only color is provided
      whereClause = 'product_id = ? AND color = ? AND size IS NULL';
      whereArgs = [item.productId, item.color];
    } else if (item.variationId != null) {
      // If no size/color but has variation_id
      whereClause = 'product_id = ? AND variation_id = ?';
      whereArgs = [item.productId, item.variationId];
    } else {
      // Simple product without variations
      whereClause =
          'product_id = ? AND size IS NULL AND color IS NULL AND variation_id IS NULL';
      whereArgs = [item.productId];
    }

    final existing = await db.query(
      'cart_items',
      where: whereClause,
      whereArgs: whereArgs,
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
    final db = await instance.database;
    final result = await db.query('cart_items');
    final items = result.map((json) => CartItemModel.fromMap(json)).toList();
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
