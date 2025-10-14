// ignore_for_file: avoid_print

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

// 管理平台测试地址： https://appversion.wiltechs.com/
// api文档： https://apifox.com/apidoc/shared-8e77e926-d84c-421d-92dd-79e2babf2836 （附带有api-key）
// 对接测试：// dart ./scripts/upload_package.dart baseUrl=https://appversionapi.wiltechs.com/uploadPackageFile apiKey=eGNxN3RueXNwb3l projectId=4b7c8560-ef62-11ef-a7b5-df0361a8b5c2 packagePath=/Users/work/proton/easypos/dist/lemon_pos-test_0.0.0_011513.apk

class Params {
  Params();

  String? baseUrl;

  String? apiKey;

  String? projectId;

  String? packagePath;

  factory Params.fromJson(Map<String, dynamic> json) => Params()
    ..baseUrl = json["baseUrl"]
    ..apiKey = json["apiKey"]
    ..projectId = json["projectId"]
    ..packagePath = json["packagePath"];
}

Map<String, String> extractParams(List<String> arguments) {
  Map<String, String> paramsMap = {};
  for (var param in arguments) {
    if (param.contains("=")) {
      var splitParam = param.split("=");
      if (splitParam.length == 2) {
        var key = splitParam[0].trim();
        var value = splitParam[1].trim();
        paramsMap[key] = value;
      }
    }
  }
  return paramsMap;
}

String formatBytes(int bytes) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB"];
  final i = (log(bytes) / log(1024)).floor();
  return "${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}";
}

String getType(String suffix) {
  switch (suffix) {
    case ".ipa":
      return "0";
    case ".apk":
      return "1";
    case ".dmg":
      return "2";
    case ".exe":
      return "3";
    default:
      return "";
  }
}

Future<void> upload(List<String> arguments) async {
  final params = Params.fromJson(extractParams(arguments));

  if (params.baseUrl == null ||
      params.apiKey == null ||
      params.projectId == null ||
      params.packagePath == null) {
    throw ("推送失败，参数不能为空");
  }

  Dio dio = Dio();
  dio.options.headers["api-key"] = params.apiKey;
  final formData = FormData.fromMap({
    "items_id": params.projectId,
    "description": "",
    "requisite": "1", // 注意：如果后端需要数字类型，可能需要改为 1（不带引号）
    "type": getType(path.extension(params.packagePath!)),
    "App_Store": "",
    "file": await MultipartFile.fromFile(
      params.packagePath!,
      filename: path.basename(params.packagePath!), // 自动获取文件名
    ),
  });

  print("baseUrl: ${Uri(
    path: params.baseUrl,
    queryParameters: {
      "items_id": params.projectId,
      "description": "",
      "requisite": "1",
      "type": getType(path.extension(params.packagePath!)),
      "App_Store": "",
      "filePath": params.packagePath!,
      "filename": path.basename(params.packagePath!),
    },
  ).toString()}");

  try {
    final response = await dio.post(
      params.baseUrl!,
      data: formData,
      options: Options(
        contentType: "multipart/form-data",
      ),
      onSendProgress: (count, total) {
        final percent = (count / total * 100).toStringAsFixed(1);
        print("上传进度: $percent% (${formatBytes(count)}/${formatBytes(total)})");
      },
    );

    if (response.statusCode == 200 && response.data["status"] == true) {
      print("上传成功: ${response.data}");
    } else {
      throw Exception("上传失败 error: ${response.data["message"]}");
    }
  } on DioException catch (e) {
    throw Exception(
      "请求失败 错误响应数据: ${e.response?.data} 错误状态码: ${e.response?.statusCode} 错误信息: ${e.message}",
    );
  }
}

Future<void> main(List<String> arguments) async {
  await upload(arguments);
}
