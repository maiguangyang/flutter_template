/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-02-13 20:22:48
 */
class AndroidConfig {
  /// 依赖列表
  static List<Map<String, String>> get dependencies {
    return [
      {
        'name': 'coreLibraryDesugaring',
        'value': 'com.android.tools:desugar_jdk_libs:2.1.4',
      }
    ];
  }
}
