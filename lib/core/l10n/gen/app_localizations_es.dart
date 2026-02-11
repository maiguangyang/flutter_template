// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get sendTimeout => 'Tiempo de espera de conexión agotado';

  @override
  String get authException => 'No autorizado';

  @override
  String get serverException => 'Error del servidor';

  @override
  String get networkException => 'Error de red';

  @override
  String get appException => 'Error desconocido';

  @override
  String get loading => 'Cargando...';

  @override
  String get retry => 'Intentar de nuevo';

  @override
  String get page => 'página';

  @override
  String get model => 'Modelo';

  @override
  String get modelName => 'Nombre del modelo';

  @override
  String get type => 'Tipo';

  @override
  String get status => 'estado';

  @override
  String get action => 'Operación';

  @override
  String get size => 'Tamaño';

  @override
  String get paramsSize => 'Cantidad de parámetros';

  @override
  String get updateTime => 'Fecha de modificación';

  @override
  String get homePage => 'Página principal';

  @override
  String get modelPage => 'Gestión de modelos';

  @override
  String get loginPage => 'Página de inicio';

  @override
  String get testPage => 'Página de prueba';
}
