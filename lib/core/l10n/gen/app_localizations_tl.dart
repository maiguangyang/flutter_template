// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tagalog (`tl`).
class AppLocalizationsTl extends AppLocalizations {
  AppLocalizationsTl([String locale = 'tl']) : super(locale);

  @override
  String get sendTimeout => 'Timeout sa pagkokonekta';

  @override
  String get authException => 'Hindi pinahihintulutan';

  @override
  String get serverException => 'Error sa server.';

  @override
  String get networkException => 'Maliit na problema sa network.';

  @override
  String get appException => 'Hindi kilalang mga error';

  @override
  String get loading => 'Naglo-load pa ako ng datos.';

  @override
  String get retry => 'subukan muli';

  @override
  String get page => 'pahina';

  @override
  String get model => 'model';

  @override
  String get modelName => 'Pangalan ng modelo';

  @override
  String get type => 'Type';

  @override
  String get status => 'kalagayan';

  @override
  String get action => 'Pagpapatakbo/Operasyon';

  @override
  String get size => 'Laki';

  @override
  String get paramsSize => 'Bilang ng mga parameter';

  @override
  String get updateTime => 'petsa ng pagbabago';

  @override
  String get homePage => 'Pahina ng Ulat';

  @override
  String get modelPage => 'Pamamahala sa modelo';

  @override
  String get loginPage => 'Pahina ng Pag-log-in';

  @override
  String get testPage => 'Pahina ng pagsubok';
}
