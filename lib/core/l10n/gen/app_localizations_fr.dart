// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get sendTimeout => 'Expiration de la connexion';

  @override
  String get authException => 'Non autorisé';

  @override
  String get serverException => 'Erreur sur le serveur';

  @override
  String get networkException => 'Erreur de réseau';

  @override
  String get appException => 'Erreurs inconnues';

  @override
  String get loading => 'En cours de chargement';

  @override
  String get retry => 'Réessayer';

  @override
  String get page => 'Page';

  @override
  String get model => 'modèle';

  @override
  String get modelName => 'Nom du modèle';

  @override
  String get type => 'Type';

  @override
  String get status => 'État';

  @override
  String get action => 'Opération';

  @override
  String get size => 'Dimensions';

  @override
  String get paramsSize => 'Nombres de participants';

  @override
  String get updateTime => 'Date de modification';

  @override
  String get homePage => 'Page d’accueil';

  @override
  String get modelPage => 'Gestion des modèles';

  @override
  String get loginPage => 'Page de connexion';

  @override
  String get testPage => 'Page de test';
}
