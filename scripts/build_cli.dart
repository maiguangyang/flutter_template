/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-02-13 16:23:37
 */
import 'package:flutter_oxygen/scripts/builds/index.dart';
import 'package:flutter_oxygen/scripts/params.dart';
import 'package:flutter_oxygen/scripts/utils.dart';
import 'package:recase/recase.dart';
import 'package:sugar_talk/config/android_config.dart';
import 'package:sugar_talk/config/config.dart';

/// pubspec.yaml
const String pubspecPath = "pubspec.yaml";

/// 项目配置文件路径
const String configPath = "lib/config/config.dart";

/// android template
const String androidTemplate = "scripts/templates/android/build.gradle.kts";

/// android gradle
const String androidGradle = "android/app/build.gradle.kts";

/// web index.html
const String webHtmlTemplateInput = "scripts/templates/web/index.html";
const String webHtmlTemplateOutput = "web/index.html";

const String webManifestTemplateInput = "scripts/templates/web/manifest.json";
const String webManifestTemplateOutput = "web/manifest.json";

/// 获取项目配置
Map<String, dynamic> getProject(Map<String, String> params) {
  final projectName = params["projectName"];
  if (projectName != null) {
    Config.setProjectName(projectName);
  }

  // 获取项目配置
  final project = Config.getProject;
  final projectMap = project.toJson();

  params.forEach((key, value) {
    if (projectMap[key] != null) {
      projectMap[key] = value;
    }
  });

  String env = projectMap["env"];
  bool isPrd = env == "prd";

  String appName = !isPrd
      ? "${projectMap["appName"]} ${ReCase(env.toUpperCase()).titleCase}"
      : projectMap["appName"];

  // appName = ReCase(appName).titleCase;

  String namespace = ReCase(projectMap["projectName"]).camelCase;
  // namespace = isDev ? "com.example.$namespace.$env" : "com.$namespace.$env";

  namespace = isPrd ? "com.proton.$namespace" : "com.proton.$namespace.$env";

  projectMap["appName"] = appName;
  projectMap["namespace"] = namespace;

  return projectMap;
}

/// 设置项目配置
void setProjectData({required Map<String, dynamic> params}) {
  /// 设置项目配置
  updateConfig(params: {"projectJson": params}, inputPath: configPath);
}

/// build cli 入口
void main(List<String> arguments) async {
  final params = Params().get(arguments);

  // 获取项目配置
  final project = getProject(params);
  String projectName = project["projectName"];

  /// 设置项目配置
  setProjectData(params: project);

  updateProjectNameInConfig(inputPath: configPath, projectName: projectName);

  /// 复制图片
  Utils.copyFiles(
    inputDir: "assets/images/projects/$projectName",
    outputDir: "assets/images/app",
  );

  /// 复安卓jks文件
  await Utils.deleteDirectory("android/jks");
  Utils.copyFiles(
    inputDir: "assets/jks/$projectName",
    outputDir: "android/jks",
  );

  project["dependencies"] = AndroidConfig.dependencies;

  /// 删除一些配置文件
  await Utils.deleteDirectory("macos/Flutter");
  await Utils.deleteDirectory("windows/runner/resources");
  await Utils.deleteFile("macos/Runner.xcodeproj/project.pbxproj");
  await Utils.deleteFile(
    "macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme",
  );

  /// web
  BuildCli().web(
    data: project,
    template: webHtmlTemplateInput,
    output: webHtmlTemplateOutput,
  );

  BuildCli().web(
    data: project,
    template: webManifestTemplateInput,
    output: webManifestTemplateOutput,
  );

  /// android build.gradle
  BuildCli().android(
    data: project,
    template: androidTemplate,
    output: androidGradle,
  );

  /// windows
  BuildCli().window(
    data: project,
    template: "scripts/templates/windows/CMakeLists.txt",
    output: "windows/CMakeLists.txt",
  );

  BuildCli().window(
    data: project,
    template: "scripts/templates/windows/Runner.rc",
    output: "windows/runner/Runner.rc",
  );

  /// macos
  /// 生成macos ios project.pbxproj
  await BuildCli().runFlutterCreateMacOS(
    domain: project["namespace"],
    platforms: "macos,ios",
    projectName: projectName,
  );

  BuildCli().macos(
    data: project,
    template: "scripts/templates/macos/AppInfo.xcconfig",
    output: "macos/Runner/Configs/AppInfo.xcconfig",
  );

  // BuildCli().ios(
  //   data: project,
  //   template:
  //       "scripts/templates/ios/project.pbxproj",
  //   output: "ios/Runner.xcodeproj/project.pbxproj",
  // );

  /// ios/Runner/Info.plist
  await BuildCli().updateXmlValue(
    filePath: "ios/Runner/Info.plist",
    key: "CFBundleName",
    value: project["projectName"],
  );

  await BuildCli().updateXmlValue(
    filePath: "ios/Runner/Info.plist",
    key: "CFBundleDisplayName",
    value: project["appName"],
  );

  await BuildCli().replaceBundleIdentifier(
    filePath: "ios/Runner.xcodeproj/project.pbxproj",
    newIdentifier: project["namespace"],
  );
}
