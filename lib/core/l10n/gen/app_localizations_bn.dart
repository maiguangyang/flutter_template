// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get sendTimeout => 'কানেকশন টাইমআউট হয়ে গেছে';

  @override
  String get authException => 'অনুমোদন ছাড়া';

  @override
  String get serverException => 'সার্ভারের ত্রুটি';

  @override
  String get networkException => 'নেটওয়ার্কের সমস্যা';

  @override
  String get appException => 'অজানা ত্রুটি/ব্যাপার';

  @override
  String get loading => 'লোড করার প্রক্রিয়ায় রয়েছে।';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get page => 'পৃষ্ঠা';

  @override
  String get model => 'মডেল';

  @override
  String get modelName => 'মডেলের নাম';

  @override
  String get type => '类型';

  @override
  String get status => 'অবস্থা/পরিস্থিতি';

  @override
  String get action => 'কার্যকর করা/নিয়ন্ত্রণ করা';

  @override
  String get size => 'আকার/বর্গ';

  @override
  String get paramsSize => 'অংশের সংখ্যা';

  @override
  String get updateTime => 'পরিবর্তনের তারিখ';

  @override
  String get homePage => 'প্রথম পৃষ্ঠা';

  @override
  String get modelPage => 'মডেল ব্যবস্থাপনা';

  @override
  String get loginPage => 'লগইন পৃষ্ঠা';

  @override
  String get testPage => 'টেস্ট পৃষ্ঠা';
}
