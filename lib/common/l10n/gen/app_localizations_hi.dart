// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get sendTimeout => 'कनेक्शन टाइमआउट हो गया।';

  @override
  String get authException => 'अनधिकृत';

  @override
  String get serverException => 'सर्वर में त्रुटि है।';

  @override
  String get networkException => 'नेटवर्क त्रुटि';

  @override
  String get appException => 'अज्ञात त्रुटि';

  @override
  String get loading => 'लोड हो रहा है…';

  @override
  String get retry => 'पुनः प्रयास करें।';

  @override
  String get page => 'पृष्ठ';

  @override
  String get model => 'मॉडल';

  @override
  String get modelName => 'मॉडल का नाम';

  @override
  String get type => 'प्रकार';

  @override
  String get status => 'स्थिति';

  @override
  String get action => 'संचालन';

  @override
  String get size => 'आकार';

  @override
  String get paramsSize => 'पैरामीटर की मात्रा';

  @override
  String get updateTime => 'संशोधन तिथि';

  @override
  String get homePage => 'होम पेज';

  @override
  String get modelPage => 'मॉडल प्रबंधन';

  @override
  String get loginPage => 'लॉगिन पेज';

  @override
  String get testPage => 'परीक्षण पृष्ठ';
}
