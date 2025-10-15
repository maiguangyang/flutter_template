/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-02-12 20:02:11
 */

import 'client_item.dart';

/// 客户列表 \
/// android签名证书jks文件以$projectName_xxx.jks命名 \
/// 例如：my_app_dev.jks、my_app_test.jks、my_app_prod.jks

class Clients {
  static const List<ClientItem> list = [
    ClientItem(
      clientName: '白牌',
      projectName: 'my_app',
      appName: 'My App',
      apiUrl: 'http://192.168.1.2:8081',
      primaryColor: "#0672FF",
      version: '0.0.1',
      defaultLanguage: 'en_US',
      password: '123456',
    ),
  ];
}
