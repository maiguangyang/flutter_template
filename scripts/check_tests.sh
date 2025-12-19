#!/bin/bash

# =============================================================================
# 测试文件检查脚本
# 用于强制要求开发者为特定类型的文件编写对应的测试
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

MISSING_TESTS=()

# 检查测试文件是否存在
check_test_exists() {
  local source_file=$1
  local test_file=""
  local test_type=""

  # 跳过生成的文件
  if [[ $source_file == *".g.dart" ]] || [[ $source_file == *".freezed.dart" ]]; then
    return 0
  fi

  # Entity 文件 -> test/units/models/ 或对应模块目录
  if [[ $source_file == *"_entity.dart" ]]; then
    local name=$(basename "$source_file" .dart)
    # 尝试从路径中获取模块名
    if [[ $source_file == *"/models/user/"* ]]; then
      test_file="test/units/user/${name}_test.dart"
    elif [[ $source_file == *"/models/model/"* ]]; then
      test_file="test/units/models/${name}_test.dart"
    else
      test_file="test/units/models/${name}_test.dart"
    fi
    test_type="单元测试"
  fi

  # Notifier 文件 -> test/integration/notifiers/
  if [[ $source_file == *"_notifier.dart" ]]; then
    local name=$(basename "$source_file" .dart)
    test_file="test/integration/notifiers/${name}_test.dart"
    test_type="集成测试"
  fi

  # Repository 文件 -> test/units/repository/
  if [[ $source_file == *"_repository.dart" ]]; then
    local name=$(basename "$source_file" .dart)
    test_file="test/units/repository/${name}_test.dart"
    test_type="单元测试"
  fi

  # API Service 文件 -> test/units/services/
  if [[ $source_file == *"_api_service.dart" ]] || [[ $source_file == *"_service.dart" ]]; then
    local name=$(basename "$source_file" .dart)
    test_file="test/units/services/${name}_test.dart"
    test_type="单元测试"
  fi

  # Response DTO 文件 -> 对应 entity 测试中应该覆盖
  if [[ $source_file == *"_response_dto.dart" ]]; then
    # DTO 测试通常和 Entity 测试放在一起
    return 0
  fi

  # 如果有需要检查的测试文件
  if [[ -n "$test_file" ]]; then
    if [[ ! -f "$test_file" ]]; then
      MISSING_TESTS+=("$source_file -> $test_file ($test_type)")
    fi
  fi

  return 0
}

# 主函数
main() {
  local mode=${1:-"staged"}  # staged 或 all
  local changed_files=""

  if [[ "$mode" == "all" ]]; then
    # 检查所有文件
    changed_files=$(find lib -name "*.dart" -type f 2>/dev/null | grep -v ".g.dart" | grep -v ".freezed.dart" || true)
  else
    # 只检查暂存的文件
    changed_files=$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null | grep '\.dart$' || true)
  fi

  if [[ -z "$changed_files" ]]; then
    echo -e "${GREEN}✅ 没有需要检查的 Dart 文件${NC}"
    exit 0
  fi

  echo -e "${YELLOW}🔍 检查测试文件...${NC}"
  echo ""

  for file in $changed_files; do
    check_test_exists "$file"
  done

  if [[ ${#MISSING_TESTS[@]} -gt 0 ]]; then
    echo -e "${RED}❌ 发现以下文件缺少对应的测试:${NC}"
    echo ""
    for missing in "${MISSING_TESTS[@]}"; do
      echo -e "   ${RED}•${NC} $missing"
    done
    echo ""
    echo -e "${YELLOW}请为上述文件添加对应的测试后再提交。${NC}"
    echo ""
    exit 1
  fi

  echo -e "${GREEN}✅ 所有文件都有对应的测试${NC}"
  exit 0
}

main "$@"
