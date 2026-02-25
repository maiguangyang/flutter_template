// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get sendTimeout => 'Thời gian kết nối quá dài';

  @override
  String get authException => 'Không được phép';

  @override
  String get serverException => 'Lỗi máy chủ';

  @override
  String get networkException => 'Lỗi kết nối mạng';

  @override
  String get appException => 'Lỗi không xác định';

  @override
  String get loading => 'Đang được tải lên';

  @override
  String get retry => 'Làm lại lần nữa';

  @override
  String get page => 'Trang';

  @override
  String get model => 'mô hình';

  @override
  String get modelName => 'Tên mô hình';

  @override
  String get type => 'Loại hình';

  @override
  String get status => 'Trạng thái';

  @override
  String get action => 'Thao tác';

  @override
  String get size => 'Kích thước';

  @override
  String get paramsSize => 'Số lượng tham số';

  @override
  String get updateTime => 'Ngày chỉnh sửa';

  @override
  String get homePage => 'Trang chủ';

  @override
  String get modelPage => 'Quản lý mô hình';

  @override
  String get loginPage => 'Trang đăng nhập';

  @override
  String get testPage => 'Trang kiểm tra';
}
