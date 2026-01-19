// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get sendTimeout => 'Thời gian kết nối hết hạn';

  @override
  String get authException => 'Chưa được cấp quyền';

  @override
  String get serverException => 'Lỗi máy chủ';

  @override
  String get networkException => 'Lỗi mạng';

  @override
  String get appException => 'Lỗi chưa được xác định';

  @override
  String get loading => 'Đang tải...';

  @override
  String get retry => 'Thử lại';

  @override
  String get page => 'trang';

  @override
  String get model => 'mô hình';

  @override
  String get modelName => 'Tên mô hình';

  @override
  String get type => 'Loại hình';

  @override
  String get status => 'trạng thái';

  @override
  String get action => 'thao tác';

  @override
  String get size => 'Kích thước';

  @override
  String get paramsSize => 'Số lượng tham số';

  @override
  String get updateTime => 'Ngày sửa đổi';

  @override
  String get homePage => 'Trang chủ';

  @override
  String get modelPage => 'Quản lý mô hình';

  @override
  String get loginPage => 'Trang đăng nhập';

  @override
  String get testPage => 'Trang kiểm thử';
}
