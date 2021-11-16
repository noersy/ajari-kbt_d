library ajari.globals;

import 'package:firebase_auth/firebase_auth.dart';

late User? _user;
late bool isUserNotNull = false;

class Get {
  static User usr() => _user!;

}

class Set {
  static void usr(User usr) {
    isUserNotNull = true;
    _user = usr;
  }

}
