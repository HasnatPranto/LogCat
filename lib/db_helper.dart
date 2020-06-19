import 'package:student_rec/student_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {

    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'student.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("DROP TABLE IF EXISTS student");
    await db
        .execute('CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, roll TEXT, cls TEXT, sec TEXT, grp TEXT, gp TEXT, pp TEXT)');
  }

  Future<Student> add(Student student) async {
    var dbClient = await db;
    student.id = await dbClient.insert('student', student.toMap());
    return student;
  }

  Future<List<Student>> getStudents(int cls) async {
    var dbClient = await db;
    List<Map> map = await dbClient.rawQuery('select * from student where cls=? ORDER BY name ASC', [cls]);
    List<Student> students = [];
    if (map.length > 0) {
      for (int i = 0; i < map.length; i++) {
        students.add(Student.fromMap(map[i]));
      }
    }
    return students;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'student',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Student student) async {
    var dbClient = await db;
    return await dbClient.update(
      'student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
