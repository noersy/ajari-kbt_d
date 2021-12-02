

class PathIqro{
  static String mainImagePath = "assets/images/iqro";
  static String mainAudioPath = "assets/audio";
}


class RecordFile{
  static String recordFile({required String nomorJilid, required String nomorHalaman,}) => 'record/jilid$nomorJilid/halaman$nomorHalaman/';
}