// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get sendTimeout => 'সংযোগ স্থাপনে সময় অতিবাহিত হয়ে গেছে';

  @override
  String get authException => 'অনুমোদন ছাড়াই';

  @override
  String get serverException => 'সার্ভারে ত্রুটি রয়েছে।';

  @override
  String get networkException => 'নেটওয়ার্ক ত্রুটি';

  @override
  String get appException => 'অজানা ত্রুটি';

  @override
  String get loading => 'লোডিং হচ্ছে…';

  @override
  String get retry => 'পুনরায় চেষ্টা করুন।';

  @override
  String get page => 'পৃষ্ঠা';

  @override
  String get model => 'মডেল';

  @override
  String get modelName => 'মডেলের নাম';

  @override
  String get type => 'ধরন';

  @override
  String get status => 'অবস্থা';

  @override
  String get action => 'পরিচালনা';

  @override
  String get size => 'আকার';

  @override
  String get paramsSize => 'প্যারামিটারের পরিমাণ';

  @override
  String get updateTime => 'পরিবর্তনের তারিখ';

  @override
  String get homePage => 'প্রধান পৃষ্ঠা';

  @override
  String get modelPage => 'মডেল ব্যবস্থাপনা';

  @override
  String get loginPage => 'লগইন পেজ';

  @override
  String get testPage => 'পরীক্ষামূলক পৃষ্ঠা';
}
