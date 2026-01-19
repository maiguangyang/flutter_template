#!/usr/bin/env dart
/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2026-01-19
 *
 * Flutter L10n AI 翻译脚本
 *
 * 功能：
 * - 读取 zh-CN.json 作为翻译源
 * - 自动生成源语言 ARB 文件（app_zh.arb）
 * - 调用本地 AI API 翻译其他语言
 * - 增量翻译（基于哈希值检测变化）
 *
 * 使用方式：
 * - dart run scripts/translate_l10n.dart              翻译所有目标语言
 * - dart run scripts/translate_l10n.dart --lang en    仅翻译英语
 * - dart run scripts/translate_l10n.dart --force      强制重新翻译
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

// ============================================================================
// 配置
// ============================================================================

const String aiApiUrl = String.fromEnvironment(
  'AI_API_URL',
  defaultValue: 'http://192.167.167.129:1234/v1/chat/completions',
);

const String aiModel = String.fromEnvironment(
  'AI_MODEL',
  defaultValue: 'default',
);

// 路径配置
const String l10nDir = 'lib/common/l10n';
const String sourceFile = '$l10nDir/zh_CN.json';
const String cacheFile = '$l10nDir/.translation-cache.json';

// 目标语言配置（共 38 种目标语言，按使用热度排序）
const List<String> targetLocales = [
  // 第一梯队：全球主要语言（10亿+用户）
  'en', // 英语 - 全球通用
  'hi', // 印地语 - 6亿+用户
  'es', // 西班牙语 - 5亿+用户
  'ar', // 阿拉伯语 - 4亿+用户
  'bn', // 孟加拉语 - 3亿+用户
  'pt', // 葡萄牙语 - 2.5亿+用户
  'ru', // 俄语 - 2.5亿+用户
  'ja', // 日语 - 1.2亿+用户
  'fr', // 法语 - 2.8亿用户
  'de', // 德语 - 1亿+用户
  // 第二梯队：亚太地区热门语言
  'ko', // 韩语 - 8千万用户
  'vi', // 越南语 - 8千万用户
  'th', // 泰语 - 6千万用户
  'id', // 印尼语 - 4千万用户
  'ms', // 马来语 - 3千万用户
  'tl', // 菲律宾语 - 2.8千万用户
  'zh_TW', // 繁体中文 - 台港澳
  // 'yue', // 粤语 - 8千万用户
  // // 第三梯队：欧洲主要语言
  // 'it', // 意大利语 - 6千万用户
  // 'pl', // 波兰语 - 4千万用户
  // 'nl', // 荷兰语 - 2.5千万用户
  // 'uk', // 乌克兰语 - 4千万用户
  // 'tr', // 土耳其语 - 8千万用户
  // 'cs', // 捷克语 - 1千万用户
  // // 第四梯队：南亚及中东语言
  // 'ur', // 乌尔都语 - 2.3亿用户
  // 'ta', // 泰米尔语 - 8千万用户
  // 'te', // 泰卢固语 - 8千万用户
  // 'mr', // 马拉地语 - 8千万用户
  // 'gu', // 古吉拉特语 - 5千万用户
  // 'fa', // 波斯语 - 1.1亿用户
  // 'he', // 希伯来语 - 9百万用户
  // // 第五梯队：东南亚及少数民族语言
  // 'km', // 高棉语 - 1.6千万用户
  // 'my', // 缅甸语 - 3.3千万用户
  // 'bo', // 藏语
  // 'kk', // 哈萨克语
  // 'mn', // 蒙古语
  // 'ug', // 维吾尔语
];

// 语言代码 → 中文名映射（用于 AI 提示词，共 39 种语言含源语言）
const Map<String, String> languageMap = {
  // 源语言
  'zh': '中文',

  // 38 种目标语言
  'en': '英语',
  'fr': '法语',
  'pt': '葡萄牙语',
  'es': '西班牙语',
  'ja': '日语',
  'tr': '土耳其语',
  'ru': '俄语',
  'ar': '阿拉伯语',
  'ko': '韩语',
  'th': '泰语',
  'it': '意大利语',
  'de': '德语',
  'vi': '越南语',
  'ms': '马来语',
  'id': '印尼语',
  'tl': '菲律宾语',
  'hi': '印地语',
  'zh_TW': '繁体中文',
  'pl': '波兰语',
  'cs': '捷克语',
  'nl': '荷兰语',
  'km': '高棉语',
  'my': '缅甸语',
  'fa': '波斯语',
  'gu': '古吉拉特语',
  'ur': '乌尔都语',
  'te': '泰卢固语',
  'mr': '马拉地语',
  'he': '希伯来语',
  'bn': '孟加拉语',
  'ta': '泰米尔语',
  'uk': '乌克兰语',
  'bo': '藏语',
  'kk': '哈萨克语',
  'mn': '蒙古语',
  'ug': '维吾尔语',
  'yue': '粤语',
};

// ============================================================================
// 缓存工具
// ============================================================================

/// 计算字符串的哈希值（简单实现，无需外部依赖）
String hashString(String str) {
  // 使用 hashCode 和 base64 编码生成简单哈希
  var hash = 0;
  for (var i = 0; i < str.length; i++) {
    hash = ((hash << 5) - hash) + str.codeUnitAt(i);
    hash = hash & 0xFFFFFFFF;
  }
  return hash.toRadixString(16).padLeft(8, '0');
}

/// 缓存数据结构
class TranslationCache {
  Map<String, LanguageCache> languages;

  TranslationCache({Map<String, LanguageCache>? languages})
    : languages = languages ?? {};

  factory TranslationCache.fromJson(Map<String, dynamic> json) {
    final languages = <String, LanguageCache>{};
    final langData = json['languages'] as Map<String, dynamic>? ?? {};
    langData.forEach((key, value) {
      languages[key] = LanguageCache.fromJson(value as Map<String, dynamic>);
    });
    return TranslationCache(languages: languages);
  }

  Map<String, dynamic> toJson() {
    final langJson = <String, dynamic>{};
    languages.forEach((key, value) {
      langJson[key] = value.toJson();
    });
    return {'languages': langJson};
  }
}

class LanguageCache {
  Map<String, String> hashes;
  String updatedAt;

  LanguageCache({Map<String, String>? hashes, String? updatedAt})
    : hashes = hashes ?? {},
      updatedAt = updatedAt ?? '';

  factory LanguageCache.fromJson(Map<String, dynamic> json) {
    return LanguageCache(
      hashes: Map<String, String>.from(json['hashes'] ?? {}),
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'hashes': hashes, 'updatedAt': updatedAt};
  }
}

/// 加载缓存
TranslationCache loadCache() {
  final file = File(cacheFile);
  if (file.existsSync()) {
    try {
      final content = file.readAsStringSync();
      final data = json.decode(content) as Map<String, dynamic>;
      // 兼容旧格式
      if (data.containsKey('hashes') && !data.containsKey('languages')) {
        return TranslationCache();
      }
      return TranslationCache.fromJson(data);
    } catch (e) {
      // 缓存损坏，返回空缓存
    }
  }
  return TranslationCache();
}

/// 保存缓存
void saveCache(TranslationCache cache) {
  final file = File(cacheFile);
  const encoder = JsonEncoder.withIndent('  ');
  file.writeAsStringSync('${encoder.convert(cache.toJson())}\n');
}

/// 获取指定语言的缓存哈希
Map<String, String> getLanguageHashes(TranslationCache cache, String locale) {
  return cache.languages[locale]?.hashes ?? {};
}

/// 更新指定语言的缓存
void updateLanguageCache(
  TranslationCache cache,
  String locale,
  Map<String, String> hashes,
) {
  cache.languages[locale] = LanguageCache(
    hashes: hashes,
    updatedAt: DateTime.now().toIso8601String(),
  );
}

/// 生成源文件的哈希映射
Map<String, String> generateSourceHashes(Map<String, dynamic> source) {
  final hashes = <String, String>{};
  source.forEach((key, value) {
    if (value is String) {
      hashes[key] = hashString(value);
    }
  });
  return hashes;
}

// ============================================================================
// AI 翻译
// ============================================================================

/// 调用 AI API 进行翻译
Future<String> callAI(String text, String targetLang) async {
  final chineseName = languageMap[targetLang] ?? targetLang;
  final systemPrompt = '将以下文本翻译为$chineseName，注意只需要输出翻译后的结果，不要额外解释：';

  final client = HttpClient();
  try {
    final uri = Uri.parse(aiApiUrl);
    final request = await client.postUrl(uri);

    request.headers.set('Content-Type', 'application/json; charset=utf-8');

    final body = json.encode({
      'model': aiModel,
      'messages': [
        {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': text},
      ],
      'temperature': 0.3,
    });

    // 使用 UTF-8 编码写入请求体
    request.add(utf8.encode(body));
    final response = await request.close();

    if (response.statusCode != 200) {
      throw Exception('API 请求失败: ${response.statusCode}');
    }

    final responseBody = await response.transform(utf8.decoder).join();
    final data = json.decode(responseBody) as Map<String, dynamic>;

    final choices = data['choices'] as List<dynamic>?;
    if (choices == null || choices.isEmpty) {
      throw Exception('AI 返回空结果');
    }

    final message = choices[0]['message'] as Map<String, dynamic>?;
    final content = message?['content'] as String?;

    if (content == null || content.trim().isEmpty) {
      throw Exception('AI 返回空内容');
    }

    return content.trim();
  } finally {
    client.close();
  }
}

// ============================================================================
// 翻译逻辑
// ============================================================================

/// 找出需要翻译的键
({List<String> newKeys, List<String> changedKeys}) findKeysToTranslate(
  Map<String, dynamic> source,
  Map<String, dynamic> target,
  Map<String, String> cachedHashes,
  Map<String, String> currentHashes,
) {
  final newKeys = <String>[];
  final changedKeys = <String>[];

  source.forEach((key, value) {
    if (!target.containsKey(key)) {
      newKeys.add(key);
    } else if (cachedHashes.containsKey(key) &&
        cachedHashes[key] != currentHashes[key]) {
      changedKeys.add(key);
    }
  });

  return (newKeys: newKeys, changedKeys: changedKeys);
}

/// 翻译结果
class TranslateResult {
  final int added;
  final int updated;
  final int skipped;

  TranslateResult({this.added = 0, this.updated = 0, this.skipped = 0});
}

/// 翻译单个语言
Future<TranslateResult> translateFile(
  String targetLang,
  Map<String, dynamic> sourceData,
  Map<String, String> cachedHashes,
  Map<String, String> currentHashes, {
  bool forceAll = false,
}) async {
  final targetFile = File('$l10nDir/app_$targetLang.arb');

  // 读取目标文件
  Map<String, dynamic> targetData = {};
  if (targetFile.existsSync()) {
    try {
      targetData =
          json.decode(targetFile.readAsStringSync()) as Map<String, dynamic>;
    } catch (e) {
      // 文件损坏，当作空文件
    }
  }

  // 确定需要翻译的键
  List<String> newKeys;
  List<String> changedKeys;

  if (forceAll) {
    newKeys = sourceData.keys.where((k) => !targetData.containsKey(k)).toList();
    changedKeys = sourceData.keys
        .where((k) => targetData.containsKey(k))
        .toList();
  } else {
    final result = findKeysToTranslate(
      sourceData,
      targetData,
      cachedHashes,
      currentHashes,
    );
    newKeys = result.newKeys;
    changedKeys = result.changedKeys;
  }

  final keysToTranslate = [...newKeys, ...changedKeys];

  if (keysToTranslate.isEmpty) {
    print('  ✓ $targetLang: 无需翻译');
    return TranslateResult(skipped: targetData.length);
  }

  final actionDesc = changedKeys.isNotEmpty
      ? '翻译 ${newKeys.length} 新增 + ${changedKeys.length} 修改'
      : '翻译 ${newKeys.length} 新增';
  print('  $targetLang: $actionDesc...');

  // 翻译键
  final newTranslations = <String, String>{};
  for (final key in keysToTranslate) {
    final sourceText = sourceData[key] as String;
    final isChanged = changedKeys.contains(key);
    try {
      final translated = await callAI(sourceText, targetLang);
      newTranslations[key] = translated;
      final prefix = isChanged ? '🔄' : '✓';
      print('    $prefix $key: $sourceText → $translated');
    } catch (e) {
      print('    ✗ $key: 翻译失败 - $e');
      // 使用原文作为回退
      newTranslations[key] = sourceText;
    }
  }

  // 合并并写入
  final mergedData = {...targetData, ...newTranslations};
  mergedData['@@locale'] = targetLang;

  const encoder = JsonEncoder.withIndent('  ');
  targetFile.writeAsStringSync('${encoder.convert(mergedData)}\n');

  return TranslateResult(
    added: newKeys.length,
    updated: changedKeys.length,
    skipped: targetData.length - changedKeys.length,
  );
}

/// 生成源语言 ARB 文件
void generateSourceArb(Map<String, dynamic> sourceData) {
  final arbFile = File('$l10nDir/app_zh.arb');
  final arbData = {'@@locale': 'zh', ...sourceData};

  const encoder = JsonEncoder.withIndent('  ');
  arbFile.writeAsStringSync('${encoder.convert(arbData)}\n');
  print('  ✓ 已生成源语言 ARB: app_zh.arb');
}

// ============================================================================
// 清理
// ============================================================================

/// 清理不在 TARGET_LOCALES 中的语言文件和缓存
int cleanupOrphanedLocales() {
  const sourceLocale = 'zh';
  final allowedLocales = {sourceLocale, ...targetLocales};

  // 扫描 ARB 文件
  final dir = Directory(l10nDir);
  final arbFiles = dir
      .listSync()
      .where((f) => f is File && f.path.endsWith('.arb'))
      .map((f) => f.path.split('/').last)
      .toList();

  final orphanedFiles = <String>[];
  for (final file in arbFiles) {
    final match = RegExp(r'app_(.+)\.arb').firstMatch(file);
    if (match != null) {
      final locale = match.group(1)!;
      if (!allowedLocales.contains(locale)) {
        orphanedFiles.add(file);
      }
    }
  }

  // 清理文件
  if (orphanedFiles.isNotEmpty) {
    print('  🗑️ 清理 ${orphanedFiles.length} 个不再需要的语言文件...');
    for (final file in orphanedFiles) {
      File('$l10nDir/$file').deleteSync();
      print('    ✓ 已删除 $file');
    }
  }

  // 清理缓存
  final cache = loadCache();
  final orphanedCacheLocales = cache.languages.keys
      .where((locale) => !allowedLocales.contains(locale))
      .toList();

  if (orphanedCacheLocales.isNotEmpty) {
    print('  🧹 清理 ${orphanedCacheLocales.length} 个缓存条目...');
    for (final locale in orphanedCacheLocales) {
      cache.languages.remove(locale);
      print('    ✓ 已清理缓存: $locale');
    }
    saveCache(cache);
  }

  return orphanedFiles.length + orphanedCacheLocales.length;
}

// ============================================================================
// 命令行
// ============================================================================

class Args {
  String? lang;
  bool help = false;
  bool force = false;
  bool merge = false; // 是否合并 language.json
}

Args parseArgs(List<String> arguments) {
  final args = Args();
  for (var i = 0; i < arguments.length; i++) {
    if (arguments[i] == '--lang' && i + 1 < arguments.length) {
      args.lang = arguments[i + 1];
      i++;
    } else if (arguments[i] == '--help' || arguments[i] == '-h') {
      args.help = true;
    } else if (arguments[i] == '--force' || arguments[i] == '-f') {
      args.force = true;
    } else if (arguments[i] == '--merge' || arguments[i] == '-m') {
      args.merge = true;
    }
  }
  return args;
}

void showHelp() {
  print('''

Flutter L10n AI 翻译脚本

使用方式:
  dart run scripts/translate_l10n.dart               翻译所有目标语言
  dart run scripts/translate_l10n.dart --force       强制重新翻译所有键
  dart run scripts/translate_l10n.dart --lang en     仅翻译指定语言

选项:
  --lang <code>  指定目标语言代码 (如 en, es, ja)
  --force, -f    强制重新翻译所有键（包括已存在的）
  --merge, -m    合并 language.json 中的 zh 值（优先级更高）
  --help, -h     显示帮助信息

配置:
  TARGET_LOCALES: [${targetLocales.take(5).join(', ')}, ... (${targetLocales.length} 种语言)]
  AI_API_URL: $aiApiUrl
''');
}

// ============================================================================
// 主函数
// ============================================================================

Future<void> main(List<String> arguments) async {
  final args = parseArgs(arguments);

  if (args.help) {
    showHelp();
    return;
  }

  print('🌐 Flutter L10n AI 翻译脚本');
  print('   源文件: $sourceFile');
  print('   API: $aiApiUrl');
  if (args.force) {
    print('   模式: 强制重新翻译所有键');
  } else {
    print('   模式: 智能检测（新增 + 修改）');
  }
  print('');

  // 读取源文件 (zh_CN.json)
  final sourceFileObj = File(sourceFile);
  if (!sourceFileObj.existsSync()) {
    print('❌ 源文件不存在: $sourceFile');
    exit(1);
  }

  var sourceData =
      json.decode(sourceFileObj.readAsStringSync()) as Map<String, dynamic>;

  // 合并 language.json 中的 zh 语言数据（优先级更高）
  if (args.merge) {
    const languageJsonFile = '$l10nDir/language.json';
    final languageFile = File(languageJsonFile);
    if (languageFile.existsSync()) {
      try {
        final languageData =
            json.decode(languageFile.readAsStringSync())
                as Map<String, dynamic>;

        // 提取每个键的 zh 值
        var mergedCount = 0;
        languageData.forEach((key, value) {
          if (value is Map<String, dynamic> && value.containsKey('zh')) {
            final zhValue = value['zh'];
            if (zhValue is String) {
              // language.json 的值优先
              if (!sourceData.containsKey(key) || sourceData[key] != zhValue) {
                sourceData[key] = zhValue;
                mergedCount++;
              }
            }
          }
        });

        if (mergedCount > 0) {
          print('  📥 从 language.json 合并 $mergedCount 个键');
        }
      } catch (e) {
        print('  ⚠ 读取 language.json 失败: $e');
      }
    }
  }

  final currentHashes = generateSourceHashes(sourceData);

  // 生成源语言 ARB
  generateSourceArb(sourceData);

  // 加载缓存
  final cache = loadCache();

  final locales = args.lang != null ? [args.lang!] : targetLocales;

  var totalAdded = 0;
  var totalUpdated = 0;
  var totalSkipped = 0;

  for (final locale in locales) {
    if (!languageMap.containsKey(locale)) {
      print('  ⚠ 未知语言代码: $locale');
      continue;
    }

    final cachedHashes = getLanguageHashes(cache, locale);

    try {
      final result = await translateFile(
        locale,
        sourceData,
        cachedHashes,
        currentHashes,
        forceAll: args.force,
      );
      totalAdded += result.added;
      totalUpdated += result.updated;
      totalSkipped += result.skipped;

      // 翻译成功后更新缓存
      updateLanguageCache(cache, locale, currentHashes);
      saveCache(cache);
    } catch (e) {
      print('  ✗ $locale: $e');
    }
  }

  print('');
  print('📊 统计: 新增 $totalAdded 个，更新 $totalUpdated 个，跳过 $totalSkipped 个');

  // 清理废弃的语言文件
  print('');
  print('🧹 检查废弃的语言文件...');
  final deletedCount = cleanupOrphanedLocales();
  if (deletedCount == 0) {
    print('  ✓ 无需清理');
  }

  print('');
  print('✅ 完成！运行 flutter gen-l10n 生成本地化代码');
}
