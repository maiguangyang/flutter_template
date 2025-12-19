/*
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-12-19
 */

import 'package:flutter_oxygen/flutter_oxygen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/views/data/models/menu/menu_entity.dart';

void main() {
  group('MenuEntity Tests', () {
    group('creation', () {
      test('应该正确创建实体', () {
        final menu = MenuEntity(
          label: '首页',
          type: MenuTypeEnumCore.destination,
          badgeCount: 5,
          showBadge: true,
          isHideLabel: false,
        );

        expect(menu.label, equals('首页'));
        expect(menu.type, equals(MenuTypeEnumCore.destination));
        expect(menu.badgeCount, equals(5));
        expect(menu.showBadge, isTrue);
        expect(menu.isHideLabel, isFalse);
      });

      test('应该使用默认值创建实体', () {
        final menu = MenuEntity(label: '测试');

        expect(menu.label, equals('测试'));
        expect(menu.route, isNull);
        expect(menu.icon, isNull);
        expect(menu.type, equals(MenuTypeEnumCore.destination));
        expect(menu.badgeCount, isNull);
        expect(menu.showBadge, isFalse);
        expect(menu.isHideLabel, isFalse);
      });
    });

    group('business logic', () {
      test('hasBadgeCount 当 showBadge 为 true 应该返回 true', () {
        final menu = MenuEntity(label: '测试', showBadge: true);
        expect(menu.hasBadgeCount, isTrue);
      });

      test('hasBadgeCount 当 badgeCount > 0 应该返回 true', () {
        final menu = MenuEntity(label: '测试', badgeCount: 3);
        expect(menu.hasBadgeCount, isTrue);
      });

      test(
        'hasBadgeCount 当 showBadge 为 false 且 badgeCount 为 null 应该返回 false',
        () {
          final menu = MenuEntity(label: '测试', showBadge: false);
          expect(menu.hasBadgeCount, isFalse);
        },
      );

      test('hasBadgeCount 当 badgeCount 为 0 应该返回 false', () {
        final menu = MenuEntity(label: '测试', badgeCount: 0);
        expect(menu.hasBadgeCount, isFalse);
      });
    });

    group('serialization', () {
      test('toJson 应该正确序列化', () {
        final menu = MenuEntity(
          label: '首页',
          type: MenuTypeEnumCore.destination,
          badgeCount: 5,
          showBadge: true,
        );

        final json = menu.toJson();

        expect(json['label'], equals('首页'));
        expect(json['type'], equals('destination'));
        expect(json['badgeCount'], equals(5));
        expect(json['showBadge'], isTrue);
      });

      test('fromJson 应该正确反序列化', () {
        final json = {
          'label': '设置',
          'type': 'destination',
          'badgeCount': 10,
          'showBadge': true,
          'isHideLabel': false,
        };

        final entity = MenuEntity.fromJson(json);

        expect(entity.label, equals('设置'));
        expect(entity.badgeCount, equals(10));
        expect(entity.showBadge, isTrue);
      });
    });

    group('copyWith', () {
      test('copyWith 应该正确复制并修改字段', () {
        final menu = MenuEntity(label: '首页', badgeCount: 5);
        final modified = menu.copyWith(label: '新首页', badgeCount: 10);

        expect(modified.label, equals('新首页'));
        expect(modified.badgeCount, equals(10));
      });
    });

    group('edge cases', () {
      test('空 label 应该正常创建', () {
        final menu = MenuEntity(label: '');
        expect(menu.label, isEmpty);
      });
    });
  });
}
