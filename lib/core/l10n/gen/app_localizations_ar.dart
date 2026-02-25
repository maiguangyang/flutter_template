// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get sendTimeout => 'تأخر في الاتصال';

  @override
  String get authException => 'غير مصرح بها';

  @override
  String get serverException => 'خطأ في الخادم';

  @override
  String get networkException => 'خطأ في الشبكة';

  @override
  String get appException => 'خطأ غير معروف';

  @override
  String get loading => 'قيد التحميل';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get page => 'الصفحة';

  @override
  String get model => 'النموذج';

  @override
  String get modelName => 'اسم النموذج';

  @override
  String get type => 'النوع/التصنيف';

  @override
  String get status => 'الحالة';

  @override
  String get action => 'التشغيل/الاستخدام';

  @override
  String get size => 'الحجم';

  @override
  String get paramsSize => 'عدد المشاركين';

  @override
  String get updateTime => 'تاريخ التعديل';

  @override
  String get homePage => 'الصفحة الأولى';

  @override
  String get modelPage => 'إدارة النماذج';

  @override
  String get loginPage => 'صفحة التسجيل';

  @override
  String get testPage => 'صفحة الاختبار';
}
