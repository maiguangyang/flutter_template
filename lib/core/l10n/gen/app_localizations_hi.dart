// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get sendTimeout => 'कनेक्शन ओवरटाइम';

  @override
  String get authException => 'अनधिकृत/अवैध';

  @override
  String get serverException => 'सर्वर समस्या';

  @override
  String get networkException => 'नेटवर्क समस्या/अप्रत्याशित स्थिति';

  @override
  String get appException => 'अज्ञात त्रुटियाँ/समस्याएँ';

  @override
  String get loading => 'लोडिंग के दौरान…';

  @override
  String get retry => 'फिर से प्रयास करें';

  @override
  String get page => 'पृष्ठ';

  @override
  String get model => 'मॉडल';

  @override
  String get modelName => 'मॉडल का नाम';

  @override
  String get type => 'प्रकार/वर्ग';

  @override
  String get status => 'स्थिति/चरित्र';

  @override
  String get action => 'ऑपरेशन/कार्यवाही';

  @override
  String get size => 'आकार/साइज़';

  @override
  String get paramsSize => 'संख्यात्मक मान';

  @override
  String get updateTime => 'संशोधन तिथि/दिनांक';

  @override
  String get homePage => 'प्रथम पृष्ठ';

  @override
  String get modelPage => 'मॉडल प्रबंधन';

  @override
  String get loginPage => 'लॉगिन पेज';

  @override
  String get testPage => 'टेस्ट पृष्ठ';
}
