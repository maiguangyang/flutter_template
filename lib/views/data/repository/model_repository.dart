/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-09-23 10:23:01
 */
import 'package:flutter_template/views/data/api/index.dart';

import '../models/index.dart';

class ModelRepository {
  final ModelApi _api;
  ModelRepository(this._api);

  /// 获取用户列表
  Future<BaseResponse<List<ModelEntity>>?> getModels() async {
    // 构建请求 DTO
    final request = GetModelsRequestDto();

    // 调用 API，返回 ModelDto
    final modelDto = await _api.getModel(request);

    // Dto 转成 Entity
    final data = modelDto?.data ?? [];
    final dtoToEntity = data.map((model) => model.toEntity()).toList();

    // 转换成最终输出数据
    final convertData = modelDto?.toEntity<List<ModelEntity>>(dtoToEntity);
    return convertData;
  }
}
