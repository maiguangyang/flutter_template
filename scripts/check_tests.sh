#!/bin/bash

# =============================================================================
# 测试文件检查脚本
# 1. 检查是否存在对应的测试文件
# 2. 检查测试文件是否包含必需的测试场景（基于 docs/test.md 清单）
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

MISSING_TESTS=()
INCOMPLETE_TESTS=()

# =============================================================================
# 检查 Entity 测试场景
# 必须包含: 创建测试, toJson, fromJson, 序列化往返, 业务方法, 边界值
# =============================================================================
check_entity_scenarios() {
  local test_file=$1
  local missing_scenarios=()
  
  # 1. 创建测试
  if ! grep -qE "(creation|创建|应该正确创建)" "$test_file" 2>/dev/null; then
    missing_scenarios+=("创建测试 (creation)")
  fi
  
  # 2. toJson 序列化
  if ! grep -qE "(toJson|序列化)" "$test_file" 2>/dev/null; then
    missing_scenarios+=("toJson 序列化")
  fi
  
  # 3. fromJson 反序列化
  if ! grep -qE "(fromJson|反序列化)" "$test_file" 2>/dev/null; then
    missing_scenarios+=("fromJson 反序列化")
  fi
  
  # 4. 边界值测试
  if ! grep -qE "(edge.?case|边界|空字符串|为 0|为空)" "$test_file" 2>/dev/null; then
    missing_scenarios+=("边界值测试 (edge cases)")
  fi
  
  echo "${missing_scenarios[@]}"
}

# =============================================================================
# 检查 Repository 测试场景
# 必须包含: 成功请求, 空数据, 错误处理
# =============================================================================
check_repository_scenarios() {
  local test_file=$1
  local missing_scenarios=()
  
  # 1. 成功请求
  if ! grep -qE "(success|成功|正确)" "$test_file" 2>/dev/null; then
    missing_scenarios+=("成功请求测试")
  fi
  
  # 2. 空数据
  if ! grep -qE "(空|empty|isEmpty|为 null)" "$test_file" 2>/dev/null; then
    missing_scenarios+=("空数据测试")
  fi
  
  # 3. 错误处理
  if ! grep -qE "(error|错误|失败|异常|throws)" "$test_file" 2>/dev/null; then
    missing_scenarios+=("错误处理测试")
  fi
  
  echo "${missing_scenarios[@]}"
}

# =============================================================================
# 检查 Notifier 测试场景
# 必须包含: 初始状态, 成功状态, 错误状态
# =============================================================================
check_notifier_scenarios() {
  local test_file=$1
  local missing_scenarios=()
  
  # 1. 初始状态
  if ! grep -qE "(initial|初始|build)" "$test_file" 2>/dev/null; then
    missing_scenarios+=("初始状态测试")
  fi
  
  # 2. 成功状态
  if ! grep -qE "(success|成功|hasValue|返回)" "$test_file" 2>/dev/null; then
    missing_scenarios+=("成功状态测试")
  fi
  
  # 3. 错误状态
  if ! grep -qE "(error|错误|失败|hasError)" "$test_file" 2>/dev/null; then
    missing_scenarios+=("错误状态测试")
  fi
  
  echo "${missing_scenarios[@]}"
}

# =============================================================================
# 检查测试文件是否存在，并验证场景覆盖
# =============================================================================
check_test_exists() {
  local source_file=$1
  local test_file=""
  local test_type=""
  local file_type=""

  # 跳过生成的文件
  if [[ $source_file == *".g.dart" ]] || [[ $source_file == *".freezed.dart" ]]; then
    return 0
  fi

  # Entity 文件
  if [[ $source_file == *"_entity.dart" ]]; then
    local name=$(basename "$source_file" .dart)
    if [[ $source_file == *"/models/user/"* ]]; then
      test_file="test/units/user/${name}_test.dart"
    else
      test_file="test/units/models/${name}_test.dart"
    fi
    test_type="单元测试"
    file_type="entity"
  fi

  # Notifier 文件
  if [[ $source_file == *"_notifier.dart" ]]; then
    local name=$(basename "$source_file" .dart)
    test_file="test/integration/notifiers/${name}_test.dart"
    test_type="集成测试"
    file_type="notifier"
  fi

  # Repository 文件
  if [[ $source_file == *"_repository.dart" ]]; then
    local name=$(basename "$source_file" .dart)
    test_file="test/units/repository/${name}_test.dart"
    test_type="单元测试"
    file_type="repository"
  fi

  # API Service 文件
  if [[ $source_file == *"_api_service.dart" ]] || [[ $source_file == *"_service.dart" ]]; then
    local name=$(basename "$source_file" .dart)
    test_file="test/units/services/${name}_test.dart"
    test_type="单元测试"
    file_type="service"
  fi

  # Response DTO 文件
  if [[ $source_file == *"_response_dto.dart" ]]; then
    return 0
  fi

  # 如果有需要检查的测试文件
  if [[ -n "$test_file" ]]; then
    # 1. 检查文件是否存在
    if [[ ! -f "$test_file" ]]; then
      MISSING_TESTS+=("$source_file -> $test_file ($test_type)")
      return
    fi
    
    # 2. 检查场景覆盖（仅对核心类型检查）
    local missing_scenarios=""
    
    case $file_type in
      "entity")
        missing_scenarios=$(check_entity_scenarios "$test_file")
        ;;
      "repository")
        missing_scenarios=$(check_repository_scenarios "$test_file")
        ;;
      "notifier")
        missing_scenarios=$(check_notifier_scenarios "$test_file")
        ;;
    esac
    
    if [[ -n "$missing_scenarios" ]]; then
      INCOMPLETE_TESTS+=("$test_file 缺少: $missing_scenarios")
    fi
  fi
}

# =============================================================================
# 主函数
# =============================================================================
main() {
  local mode=${1:-"staged"}  # staged 或 all
  local changed_files=""

  if [[ "$mode" == "all" ]]; then
    changed_files=$(find lib -name "*.dart" -type f 2>/dev/null | grep -v ".g.dart" | grep -v ".freezed.dart" || true)
  else
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

  local has_error=false

  # 显示缺失的测试文件
  if [[ ${#MISSING_TESTS[@]} -gt 0 ]]; then
    echo -e "${RED}❌ 发现以下文件缺少对应的测试:${NC}"
    echo ""
    for missing in "${MISSING_TESTS[@]}"; do
      echo -e "   ${RED}•${NC} $missing"
    done
    echo ""
    has_error=true
  fi

  # 显示场景不完整的测试文件
  if [[ ${#INCOMPLETE_TESTS[@]} -gt 0 ]]; then
    echo -e "${CYAN}⚠️  发现以下测试文件场景不完整 (参考 docs/test.md):${NC}"
    echo ""
    for incomplete in "${INCOMPLETE_TESTS[@]}"; do
      echo -e "   ${CYAN}•${NC} $incomplete"
    done
    echo ""
    has_error=true
  fi

  if [[ "$has_error" == true ]]; then
    echo -e "${YELLOW}请按照 docs/test.md 清单补充测试场景后再提交。${NC}"
    echo ""
    exit 1
  fi

  echo -e "${GREEN}✅ 所有文件都有对应的测试，且场景覆盖完整${NC}"
  exit 0
}

main "$@"
