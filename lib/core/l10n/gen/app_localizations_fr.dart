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
  String get serverException => 'Erreur du serveur';

  @override
  String get networkException => 'Erreur de réseau';

  @override
  String get appException => 'Erreur inconnue';

  @override
  String get loading => 'En chargement…';

  @override
  String get retry => 'Essayer à nouveau';

  @override
  String get page => 'page';

  @override
  String get model => 'modèle';

  @override
  String get modelName => 'Nom du modèle';

  @override
  String get type => 'Type';

  @override
  String get status => 'état';

  @override
  String get action => 'Manipulation';

  @override
  String get size => 'Dimensions';

  @override
  String get paramsSize => 'Nombre de paramètres';

  @override
  String get updateTime => 'Date de modification';

  @override
  String get homePage => 'Page d\'accueil';

  @override
  String get modelPage => 'Gestion des modèles';

  @override
  String get loginPage => 'Page d\'accueil';

  @override
  String get testPage => 'Page de test';
}
