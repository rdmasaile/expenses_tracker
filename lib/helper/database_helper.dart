import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Transaction {
  int? id;
  String name;
  num amount;
  String type;
  String? imagePath;
  String? addedOn;
  String? updatedOn;

  // String get name1 => name;
  Transaction({
    this.id,
    required this.name,
    required this.amount,
    required this.type,
    this.imagePath,
    this.addedOn,
    this.updatedOn,
  });

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        name: json['name'],
        amount: json['amount'],
        type: json['type'],
        imagePath: json['image_path'],
        addedOn: json['added_on'],
        updatedOn: json['updated_on'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'type': type,
      'image_path': imagePath,
      'added_on': addedOn,
      'updated_on': updatedOn,
    };
  }
}

class User {
  int? id;
  String fname;
  String lname;
  String username;
  String password;
  String? imagePath;

  // String get name1 => name;
  User({
    this.id,
    required this.fname,
    required this.lname,
    required this.username,
    required this.password,
    this.imagePath,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        fname: json['fname'],
        lname: json['lname'],
        username: json['username'],
        password: json['password'],
        imagePath: json['image_path'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'username': username,
      'password': password,
      'image_path': imagePath,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructer();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructer();

  static Database? _database;

  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // deleteDatabase(join(documentsDirectory.path, 'transactions.db'));

    String path = join(documentsDirectory.path, 'expense_tracker.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS transactions (
            id INTEGER PRIMARY KEY , 
            name VARCHAR(100),
            amount DECIMAL(30), 
            type VARCHAR(7), 
            image_path TEXT,
            added_on TIMESTAMP,
            updated_on TIMESTAMP
          )
      ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS users(
            id INTEGER PRIMARY KEY, 
            fname VARCHAR(50), 
            lname VARCHAR(50),
            username VARCHAR(50),
            password VARCHAR(255),
            image_path TEXT
          )
      ''');
    await db.execute('''CREATE UNIQUE INDEX index_name ON users (username);''');
  }

  Future<List<Transaction>> getTransactions() async {
    Database db = await instance.database;
    print("getting devices");
    var transactions = await db.query('transactions');
    List<Transaction> transactionList = transactions.isNotEmpty
        ? transactions
            .map((transaction) => Transaction.fromMap(transaction))
            .toList()
        : [];
    return transactionList;
  }

  Future<List<Transaction>> getTransactionsWhere(String name) async {
    Database db = await instance.database;
    List transactions =
        await db.query('transactions', where: 'name LIKE "%$name%"');
    List<Transaction> transactionList = transactions.isNotEmpty
        ? transactions
            .map((transaction) => Transaction.fromMap(transaction))
            .toList()
        : [];
    return transactionList;
  }

  Future add(Transaction transaction) async {
    Database db = await instance.database;
    try {
      return db.insert('transactions', transaction.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future remove(int id) async {
    Database db = await instance.database;
    return await db.delete('transactions', where: "id = ?", whereArgs: [id]);
  }

  Future addUser(User user) async {
    Database db = await instance.database;
    try {
      return db.insert('users', user.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> auth(String username, String password) async {
    Database db = await instance.database;
    var user = await db.query('users',
        where: 'username = ?', whereArgs: [username], distinct: true);
    print(user);
    if (user.isEmpty) {
      return false;
    }
    User existingUser = User.fromMap(user[0]);
    return (existingUser.password == password);
  }
}
