import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class LocalDBService {
  static String dbPath = 'ajari.db';
  static DatabaseFactory dbFactory = databaseFactoryIo;

  static Database? db;

  void setDatabase() async {
    try {
      db = await dbFactory.openDatabase(dbPath);
    } catch (e) {}
  }

  void storeProfile() async {
    try {
      var store = StoreRef.main();

      if (db == null) return;
      if (db != null) {
        await store.record('title').put(db!, 'Simple application');
        await store.record('version').put(db!, 10);
        await store.record('settings').put(db!, {'offline': true});

        var title = await store.record('title').get(db!) as String;
        var version = await store.record('version').get(db!) as int;
        var settings = await store.record('settings').get(db!) as Map;

        await store.record('version').delete(db!);
      }
    } catch (e) {}
  }

  void getProfile(){

  }
}
