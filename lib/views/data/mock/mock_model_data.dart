/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-10-09 09:37:26
 */

import '../models/index.dart';

const mockModelJson = [
  {
    "id": "1",
    "modelName": "ChatGPT-5",
    "type": 0,
    "paramsSize": 7,
    "size": 700,
    "url": "",
    "status": 0,
  },
  {
    "id": "2",
    "modelName": "Whisper-Large-V3",
    "type": 1,
    "paramsSize": 7,
    "size": 280,
    "url": "",
    "status": 0,
  },
];

final mockModels = mockModelJson
    .map((item) => ModelResponseDto.fromJson(item))
    .toList();
