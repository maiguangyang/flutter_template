// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get sendTimeout => 'Sambungan melebihi tempoh masa yang ditetapkan.';

  @override
  String get authException => 'Tidak diberi kuasa.';

  @override
  String get serverException => 'Ralat pelayan.';

  @override
  String get networkException => 'Ralat rangkaian.';

  @override
  String get appException => 'Ralat yang tidak diketahui';

  @override
  String get loading => 'Sedang dimuat turun.';

  @override
  String get retry => 'Cuba lagi.';

  @override
  String get page => 'halaman';

  @override
  String get model => 'model';

  @override
  String get modelName => 'Nama model';

  @override
  String get type => 'Jenis';

  @override
  String get status => 'keadaan';

  @override
  String get action => 'operasi';

  @override
  String get size => 'Saiz';

  @override
  String get paramsSize => 'bilangan parameter';

  @override
  String get updateTime => 'Tarikh pengubahsuaian';

  @override
  String get homePage => 'Halaman Utama';

  @override
  String get modelPage => 'Pengurusan Model';

  @override
  String get loginPage => 'Halaman log masuk';

  @override
  String get testPage => 'Halaman ujian';
}
