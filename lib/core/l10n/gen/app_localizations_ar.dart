// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get sendTimeout => 'انتهاء وقت الاتصال';

  @override
  String get authException => 'غير مصرح به';

  @override
  String get serverException => 'خطأ في الخادم';

  @override
  String get networkException => 'خطأ في الشبكة';

  @override
  String get appException => 'خطأ غير معروف';

  @override
  String get loading => 'يتم التحميل حالياً.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get page => 'صفحة';

  @override
  String get model => 'نموذج';

  @override
  String get modelName => 'اسم النموذج';

  @override
  String get type => 'النوع';

  @override
  String get status => 'الحالة';

  @override
  String get action => 'التشغيل';

  @override
  String get size => 'الأبعاد';

  @override
  String get paramsSize => 'كمية المعاملات';

  @override
  String get updateTime => 'تاريخ التعديل';

  @override
  String get homePage => 'الصفحة الرئيسية';

  @override
  String get modelPage => 'إدارة النماذج';

  @override
  String get loginPage => 'صفحة تسجيل الدخول';

  @override
  String get testPage => 'صفحة الاختبار';
}
