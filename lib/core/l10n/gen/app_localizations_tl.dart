// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tagalog (`tl`).
class AppLocalizationsTl extends AppLocalizations {
  AppLocalizationsTl([String locale = 'tl']) : super(locale);

  @override
  String get sendTimeout => 'Nagkaroon ng timeout sa pagkonekta';

  @override
  String get authException => 'Hindi awtorisadong gumawa nito.';

  @override
  String get serverException => 'Mga error sa server';

  @override
  String get networkException => 'Mga error sa network';

  @override
  String get appException => 'Di-kilalang error';

  @override
  String get loading => 'Naglo-load…';

  @override
  String get retry => 'Subukang muli';

  @override
  String get page => 'pahina';

  @override
  String get model => 'Modelo';

  @override
  String get modelName => 'Pangalan ng modelo';

  @override
  String get type => 'uri';

  @override
  String get status => 'kalagayan';

  @override
  String get action => 'pagpapatakbo';

  @override
  String get size => 'Laki';

  @override
  String get paramsSize => 'Halaga ng parametro';

  @override
  String get updateTime => 'Tarikh ng pagbabago';

  @override
  String get homePage => 'Pangunahing Pahina';

  @override
  String get modelPage => 'Pamamahala ng mga modelong pang-teknoloiya';

  @override
  String get loginPage => 'Pahina ng Pag-log-in';

  @override
  String get testPage => 'Pahina para sa pagsubok';
}
