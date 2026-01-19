// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get sendTimeout => 'Tempo de espera para conexão expirou.';

  @override
  String get authException => 'Não autorizado';

  @override
  String get serverException => 'Erro no servidor';

  @override
  String get networkException => 'Erro de rede';

  @override
  String get appException => 'Erro desconhecido';

  @override
  String get loading => 'Carregando…';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get page => 'página';

  @override
  String get model => 'Modelo';

  @override
  String get modelName => 'Nome do modelo';

  @override
  String get type => 'tipo';

  @override
  String get status => 'estado';

  @override
  String get action => 'Operação';

  @override
  String get size => 'Tamanho';

  @override
  String get paramsSize => 'Quantidade de parâmetros';

  @override
  String get updateTime => 'Data de modificação';

  @override
  String get homePage => 'Página inicial';

  @override
  String get modelPage => 'Gerenciamento de modelos';

  @override
  String get loginPage => 'Página de login';

  @override
  String get testPage => 'Página de teste';
}
