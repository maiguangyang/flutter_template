// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get sendTimeout => '接続タイムアウト';

  @override
  String get authException => '無許可';

  @override
  String get serverException => 'サーバーエラー';

  @override
  String get networkException => 'ネットワークエラー';

  @override
  String get appException => '不明なエラー';

  @override
  String get loading => 'ロード中です';

  @override
  String get retry => '再試行';

  @override
  String get page => 'ページ';

  @override
  String get model => 'モデル';

  @override
  String get modelName => 'モデル名';

  @override
  String get type => 'タイプ';

  @override
  String get status => '状態';

  @override
  String get action => '操作';

  @override
  String get size => 'サイズ';

  @override
  String get paramsSize => 'パラメータの数';

  @override
  String get updateTime => '変更日';

  @override
  String get homePage => 'ホームページ';

  @override
  String get modelPage => 'モデル管理';

  @override
  String get loginPage => 'ログインページ';

  @override
  String get testPage => 'テストページ';
}
