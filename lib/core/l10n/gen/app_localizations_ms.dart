// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get sendTimeout =>
      'Percubaan untuk menyambung gagal kerana masa yang terlalu lama.';

  @override
  String get authException => 'Tidak diluluskan';

  @override
  String get serverException => 'Ralat pada server';

  @override
  String get networkException => 'Kegagalan rangkaian';

  @override
  String get appException => 'Kegagalan yang tidak diketahui';

  @override
  String get loading => 'Sedang dimuat naik';

  @override
  String get retry => 'Ulang cara tersebut sekali lagi';

  @override
  String get page => 'Halaman';

  @override
  String get model => 'model';

  @override
  String get modelName => 'Nama model';

  @override
  String get type => 'Jenis';

  @override
  String get status => 'Keadaan/Status';

  @override
  String get action => 'Pengendalian';

  @override
  String get size => 'Saiz';

  @override
  String get paramsSize => 'Jumlah parameter';

  @override
  String get updateTime => 'Tarikh perubahan';

  @override
  String get homePage => 'Halaman Utama';

  @override
  String get modelPage => 'Pengurusan model';

  @override
  String get loginPage => 'Halaman Log In';

  @override
  String get testPage => 'Halaman ujian';
}
