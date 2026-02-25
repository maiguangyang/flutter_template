// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get sendTimeout => 'Koneksi melewati batas waktu yang ditentukan';

  @override
  String get authException => 'Tidak diberi izin';

  @override
  String get serverException => 'Error pada server';

  @override
  String get networkException => 'Error di jaringan';

  @override
  String get appException => 'Kesalahan yang tidak diketahui';

  @override
  String get loading => 'Sedang dimuat';

  @override
  String get retry => 'Coba lagi';

  @override
  String get page => 'Halaman';

  @override
  String get model => 'model';

  @override
  String get modelName => 'Nama Model';

  @override
  String get type => 'Tipe';

  @override
  String get status => 'Keadaan/Status';

  @override
  String get action => 'Pengoperasian';

  @override
  String get size => 'Ukuran';

  @override
  String get paramsSize => 'Jumlah parameter';

  @override
  String get updateTime => 'Tanggal Perubahan';

  @override
  String get homePage => 'Halaman Utama';

  @override
  String get modelPage => 'Manajemen model';

  @override
  String get loginPage => 'Halaman login';

  @override
  String get testPage => 'Halaman uji coba';
}
