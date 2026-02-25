// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get sendTimeout => 'Verbindungstimer ausgelaufen';

  @override
  String get authException => 'Unberechtigt';

  @override
  String get serverException => 'Serverfehler';

  @override
  String get networkException => 'Netzwerkfehler';

  @override
  String get appException => 'Unbekannte Fehler';

  @override
  String get loading => 'Laden in Arbeit';

  @override
  String get retry => 'Wiederholen des Versuchs';

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
  String get action => 'Bearbeitung';

  @override
  String get size => 'Größe';

  @override
  String get paramsSize => 'Anzahl der Parameter';

  @override
  String get updateTime => 'Datum der Änderung';

  @override
  String get homePage => 'Startseite';

  @override
  String get modelPage => 'Modellverwaltung';

  @override
  String get loginPage => 'Anmeldeseite';

  @override
  String get testPage => 'Testseite';
}
