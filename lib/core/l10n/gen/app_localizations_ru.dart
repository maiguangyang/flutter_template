// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get sendTimeout => 'Переговоры прервались из-за таймаута соединения';

  @override
  String get authException => 'Не имею права доступа';

  @override
  String get serverException => 'Ошибка сервера';

  @override
  String get networkException => 'Сетевая ошибка';

  @override
  String get appException => 'Неизвестные ошибки';

  @override
  String get loading => 'Загрузка в процессе';

  @override
  String get retry => 'Попробуйте снова';

  @override
  String get page => 'страница';

  @override
  String get model => 'модель';

  @override
  String get modelName => 'Название модели';

  @override
  String get type => 'Тип';

  @override
  String get status => 'Статус';

  @override
  String get action => 'Командование';

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
