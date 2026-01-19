// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get sendTimeout => 'Connection timeout';

  @override
  String get authException => 'Unauthorized';

  @override
  String get serverException => 'Server error';

  @override
  String get networkException => 'Network error';

  @override
  String get appException => 'Unknown error';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Retry';

  @override
  String get page => 'page';

  @override
  String get model => 'model';

  @override
  String get modelName => 'Model name';

  @override
  String get type => 'type';

  @override
  String get status => 'status';

  @override
  String get action => 'operation';

  @override
  String get size => 'Dimensions';

  @override
  String get paramsSize => 'number of parameters';

  @override
  String get updateTime => 'Modification date';

  @override
  String get homePage => 'Home page';

  @override
  String get modelPage => 'Model management';

  @override
  String get loginPage => 'Login page';

  @override
  String get testPage => 'test page';
}
