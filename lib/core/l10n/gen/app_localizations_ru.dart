// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get sendTimeout =>
      'Произошло истечение времени на установление соединения.';

  @override
  String get authException => 'Нет разрешения';

  @override
  String get serverException => 'Ошибка на сервере';

  @override
  String get networkException => 'Ошибка в сети';

  @override
  String get appException => 'Неизвестная ошибка';

  @override
  String get loading => 'Загрузка в процессе…';

  @override
  String get retry => 'попытка снова';

  @override
  String get page => 'страница';

  @override
  String get model => 'модель';

  @override
  String get modelName => 'Название модели';

  @override
  String get type => 'тип';

  @override
  String get status => 'состояние';

  @override
  String get action => 'манипуляции';

  @override
  String get size => 'Размеры';

  @override
  String get paramsSize => 'Количество параметров';

  @override
  String get updateTime => 'Дата изменения';

  @override
  String get homePage => 'Главная страница';

  @override
  String get modelPage => 'Управление моделями';

  @override
  String get loginPage => 'Страница входа';

  @override
  String get testPage => 'Тестовая страница';
}
