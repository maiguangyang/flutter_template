// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get sendTimeout =>
      'การเชื่อมต่อล้มเหลวเนื่องจากเวลาผ่านไปเกินขีดจำกัด';

  @override
  String get authException => 'ไม่ได้รับอนุญาต';

  @override
  String get serverException => 'ข้อผิดพลาดของเซิร์ฟเวอร์';

  @override
  String get networkException => 'ข้อผิดพลาดในเครือข่าย';

  @override
  String get appException => 'ข้อผิดพลาดที่ไม่ทราบสาเหตุ';

  @override
  String get loading => 'กำลังโหลดอยู่';

  @override
  String get retry => 'ลองทำอีกครั้ง';

  @override
  String get page => 'หน้า';

  @override
  String get model => 'โมเดล';

  @override
  String get modelName => 'ชื่อโมเดล';

  @override
  String get type => 'ประเภท/รูปแบบ';

  @override
  String get status => 'สถานะ';

  @override
  String get action => 'การควบคุม/การทำงาน';

  @override
  String get size => 'ขนาด';

  @override
  String get paramsSize => 'จำนวนองค์ประกอบ';

  @override
  String get updateTime => 'วันที่แก้ไข';

  @override
  String get homePage => 'หน้าปก';

  @override
  String get modelPage => 'การจัดการโมเดล';

  @override
  String get loginPage => 'หน้าล็อกอิน';

  @override
  String get testPage => 'หน้าทดสอบ';
}
