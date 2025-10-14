/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2024-05-24 15:28:02
 */

import 'client_item.dart';
import 'clients.dart';

class Config {
  /// 项目名称 \
  /// 通过 CI 传入 projectName='xxx' \
  /// 会去 Clients.list 里面找出 对应 projectName 的配置
  static String projectName = "flutter_template";

  /// 项目配置
  static ClientItem get getProject =>
      Clients.list
          .where((item) => item.projectName == projectName)
          .firstOrNull ??
      Clients.list.first;

  /// projectJson \
  /// 由getProject自动生成，每次build都会重新生成，请不要手动修改
  /// dart ./scripts/build_cli.dart projectName="flutter_template"
  static Map<String, dynamic> projectJson = {
    "clientName": "白牌",
    "projectName": "flutter_template",
    "appName": "FLUTTER TEMPLATE Dev",
    "apiUrl": "http://192.168.1.2:8081",
    "version": "0.0.1",
    "password": "123456",
    "defaultLanguage": "en_US",
    "primaryColor": "#0672FF",
    "env": "dev",
    "namespace": "com.proton.flutterTemplate.dev"
};

  /// project
  static ClientItem get project => ClientItem.fromJson(projectJson);

  /// 运行时修改 `projectName`
  static void setProjectName(String name) {
    projectName = name;
  }
}
