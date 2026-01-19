// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get sendTimeout => 'Verbindungszeitüberschreitung';

  @override
  String get authException => 'Nicht autorisiert';

  @override
  String get serverException => 'Serverfehler';

  @override
  String get networkException => 'Netzwerkfehler';

  @override
  String get appException => 'Unbekannter Fehler';

  @override
  String get loading => 'Ladet sich gerade…';

  @override
  String get retry => 'Wiederholen';

  @override
  String get page => 'Seite';

  @override
  String get model => 'Modell';

  @override
  String get modelName => 'Modellname';

  @override
  String get type => 'Typ';

  @override
  String get status => 'Zustand';

  @override
  String get action => 'Bedienung';

  @override
  String get size => 'Abmessungen';

  @override
  String get paramsSize => 'Anzahl der Parameter';

  @override
  String get updateTime => 'Änderungsdatum';

  @override
  String get homePage => 'Startseite';

  @override
  String get modelPage => 'Modellmanagement';

  @override
  String get loginPage => 'Anmeldeseite';

  @override
  String get testPage => 'Testseite';
}
