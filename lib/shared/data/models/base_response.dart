/*
 * @Author: Eric.T
 * @Email: 1354460764@qq.com
 * @Date: 2025-03-23 12:41:31
 */
import 'package:json_annotation/json_annotation.dart';

class BaseResponse<T> {
  BaseResponse();

  @JsonKey(defaultValue: 0)
  int code = 0;

  T? data;

  String msg = '';

  @JsonKey(defaultValue: false)
  bool success = false;

  /// 转化成返回目标数据，data 可以是任意组合数据
  BaseResponse<R> toEntity<R>(R? data) {
    return BaseResponse<R>()
      ..code = code
      ..msg = msg
      ..success = success
      ..data = data;
  }
}
