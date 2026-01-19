// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get sendTimeout =>
      'Terkaitan gagal karena waktu tunggu melebihi batas.';

  @override
  String get authException => 'Tidak berwenang';

  @override
  String get serverException => 'Kesalahan server';

  @override
  String get networkException => 'Kesalahan jaringan';

  @override
  String get appException => 'Kesalahan yang tidak diketahui';

  @override
  String get loading => 'Sedang diunduh…';

  @override
  String get retry => 'Coba lagi.';

  @override
  String get page => 'halaman';

  @override
  String get model => 'model';

  @override
  String get modelName => 'Nama model';

  @override
  String get type => 'tipe';

  @override
  String get status => 'keadaan';

  @override
  String get action => 'operasikan';

  @override
  String get size => 'ukuran';

  @override
  String get paramsSize => 'jumlah parameter';

  @override
  String get updateTime => 'Tanggal perubahan';

  @override
  String get homePage => 'Halaman Utama';

  @override
  String get modelPage => 'Manajemen Model';

  @override
  String get loginPage => 'Halaman login';

  @override
  String get testPage => 'Halaman uji coba';
}
