// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get sendTimeout => '연결 시간 초과';

  @override
  String get authException => '무단 접근';

  @override
  String get serverException => '서버 오류';

  @override
  String get networkException => '네트워크 오류';

  @override
  String get appException => '알 수 없는 오류';

  @override
  String get loading => '로딩 중';

  @override
  String get retry => '다시 시도해보세요';

  @override
  String get page => '페이지';

  @override
  String get model => '모델';

  @override
  String get modelName => '모델 이름';

  @override
  String get type => '유형';

  @override
  String get status => '상태';

  @override
  String get action => '조작';

  @override
  String get size => '크기';

  @override
  String get paramsSize => '숫자 개수';

  @override
  String get updateTime => '변경된 날짜';

  @override
  String get homePage => '홈페이지';

  @override
  String get modelPage => '모델 관리';

  @override
  String get loginPage => '로그인 페이지';

  @override
  String get testPage => '테스트 페이지';
}
