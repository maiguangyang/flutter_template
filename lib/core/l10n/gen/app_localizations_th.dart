// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get sendTimeout =>
      'การเชื่อมต่อล้มเหลวเนื่องจากเวลาที่ใช้ในการเชื่อมต่อนานเกินไป';

  @override
  String get authException => 'ไม่ได้รับอนุญาต';

  @override
  String get serverException => 'ข้อผิดพลาดของเซิร์ฟเวอร์';

  @override
  String get networkException => 'ข้อผิดพลาดของเครือข่าย';

  @override
  String get appException => 'ข้อผิดพลาดที่ยังไม่ทราบสาเหตุ';

  @override
  String get loading => 'กำลังโหลดอยู่…';

  @override
  String get retry => 'ลองใหม่';

  @override
  String get page => 'หน้า';

  @override
  String get model => 'แบบจำลอง';

  @override
  String get modelName => 'ชื่อแบบจำลอง';

  @override
  String get type => 'ประเภท';

  @override
  String get status => 'สถานะ';

  @override
  String get action => 'การดำเนินการ';

  @override
  String get size => 'ขนาด';

  @override
  String get paramsSize => 'จำนวนพารามิเตอร์';

  @override
  String get updateTime => 'วันที่ที่มีการเปลี่ยนแปลง';

  @override
  String get homePage => 'หน้าแรก';

  @override
  String get modelPage => 'การจัดการแบบจำลอง';

  @override
  String get loginPage => 'หน้าเข้าสู่ระบบ';

  @override
  String get testPage => 'หน้าทดสอบ';
}
