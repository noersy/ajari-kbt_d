library ajari.globals;

import 'package:ajari/model/Kelas.dart';
import 'package:ajari/model/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

late User? _user;
late Profile? _profile;
late Kelas? _kelas;
late bool isUserNotNull = false;
late bool isKelasNotNull = false;
late bool isProfileNotNull = false;

class Get {
  static User usr() => _user!;

  static Kelas kls() => _kelas!;

  static Profile prf() => _profile!;
}

class Set {
  static void usr(User usr) {
    isUserNotNull = true;
    _user = usr;
  }

  static void kls(Kelas kls) {
    isKelasNotNull = true;
    _kelas = kls;
  }

  static void prf(Profile prf) {
    isProfileNotNull = true;
    _profile = prf;
  }

  static void clearAll(){
    isProfileNotNull = false;
    isKelasNotNull = false;
    isUserNotNull = false;
    _user = null;
    _profile = null;
    _kelas = null;
  }
}
