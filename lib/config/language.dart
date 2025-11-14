import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable(explicitToJson: true)
class LanguageItem {
  const LanguageItem({
    required this.label,
    required this.value,
    required this.name,
  });

  /// 语言label
  final String label;

  /// 语言value
  final String value;

  /// 语言name
  final String name;

  /// 是否中文
  bool get isChinese => value == "zh" || value == "zh-Hant";

  factory LanguageItem.fromJson(Map<String, dynamic> json) =>
      _$LanguageItemFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageItemToJson(this);
}

/// 多语言
List<LanguageItem> get Languages => [
  LanguageItem(label: "Chinese", value: "zh", name: "中文"),
  LanguageItem(label: "Traditional Chinese", value: "zh-Hant", name: "繁体中文"),
  LanguageItem(label: "English", value: "en", name: "英语"),
  LanguageItem(label: "French", value: "fr", name: "法语"),
  LanguageItem(label: "Korean", value: "ko", name: "韩语"),
  LanguageItem(label: "Japanese", value: "ja", name: "日语"),
  LanguageItem(label: "German", value: "de", name: "德语"),
  LanguageItem(label: "Spanish", value: "es", name: "西班牙语"),
  LanguageItem(label: "Portuguese", value: "pt", name: "葡萄牙语"),
  LanguageItem(label: "Turkish", value: "tr", name: "土耳其语"),
  LanguageItem(label: "Russian", value: "ru", name: "俄语"),
  LanguageItem(label: "Arabic", value: "ar", name: "阿拉伯语"),
  LanguageItem(label: "Thai", value: "th", name: "泰语"),
  LanguageItem(label: "Italian", value: "it", name: "意大利语"),
  LanguageItem(label: "Vietnamese", value: "vi", name: "越南语"),
  LanguageItem(label: "Malay", value: "ms", name: "马来语"),
  LanguageItem(label: "Indonesian", value: "id", name: "印尼语"),
  LanguageItem(label: "Filipino", value: "tl", name: "菲律宾语"),
  LanguageItem(label: "Hindi", value: "hi", name: "印地语"),
  LanguageItem(label: "Polish", value: "pl", name: "波兰语"),
  LanguageItem(label: "Czech", value: "cs", name: "捷克语"),
  LanguageItem(label: "Dutch", value: "nl", name: "荷兰语"),
  LanguageItem(label: "Khmer", value: "km", name: "高棉语"),
  LanguageItem(label: "Burmese", value: "my", name: "缅甸语"),
  LanguageItem(label: "Persian", value: "fa", name: "波斯语"),
  LanguageItem(label: "Gujarati", value: "gu", name: "古吉拉特语"),
  LanguageItem(label: "Urdu", value: "ur", name: "乌尔都语"),
  LanguageItem(label: "Telugu", value: "te", name: "泰卢固语"),
  LanguageItem(label: "Marathi", value: "mr", name: "马拉地语"),
  LanguageItem(label: "Hebrew", value: "he", name: "希伯来语"),
  LanguageItem(label: "Bengali", value: "bn", name: "孟加拉语"),
  LanguageItem(label: "Tamil", value: "ta", name: "泰米尔语"),
  LanguageItem(label: "Ukrainian", value: "uk", name: "乌克兰语"),
];
