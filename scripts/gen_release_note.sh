#!/bin/bash

# 获取远程仓库的 URL
remote_url=$(git config --get remote.origin.url)

# 使用 sed 提取仓库名称
repo_name=$(echo "$remote_url" | sed -E 's#.*/([^/]+)\.git#\1#')
repo_name=${repo_name^^}

# 获取最新的tag
latest_tag=$(git describe --tags --abbrev=0)

# 如果没有找到任何标签，则退出
if [ -z "$latest_tag" ]; then
  echo "No tags found in the repository."
  exit 1
fi

# 获取次新的tag
second_latest_tag=$(git describe --tags --abbrev=0 $(git rev-list --tags --skip=1 --max-count=1))

# 如果只有一个标签，则无法比较
if [ "$second_latest_tag" == "$latest_tag" ]; then
  echo "Only one tag found: $latest_tag. Cannot compare with a previous tag."
  exit 1
fi

# 构建消息内容
message="## $repo_name Release Notes: $latest_tag\n\n"

echo $message;

# 获取与关闭问题相关的提交（扩展关键词匹配）
closed_issues=$(git log $second_latest_tag..$latest_tag --pretty=format:"- %s (%an)" --grep="fix" --grep="close" --grep="closes" --grep="resolve" --grep="resolved" --grep="bugfix" --grep="处理问题" --grep="修复")

# 添加关闭的问题
if [ -n "$closed_issues" ]; then
  message+="\n\n### CLOSED ISSUES :\n$closed_issues\n\n"
else
  message+="\n\n"
fi

# 获取合并请求相关的提交（扩展关键词匹配，包括合并分支的提交）
merged_requests=$(git log $second_latest_tag..$latest_tag --pretty=format:"- %s (%an)" --grep="Merge branch" --grep="merge branch" --grep="Resolve" --grep="resolve" --grep="Draft: Resolve" --grep="draft: resolve" --grep="merge request" --grep="MR" --grep="feature" --grep="增加功能" --grep="添加功能" --grep="合并分支")

# 添加合并的请求
if [ -n "$merged_requests" ]; then
  message+="\n\n### MERGED REQUESTS:\n$merged_requests\n\n"
else
  message+="\n\n"
fi

# 调试：显示所有提交，帮助确认是否有遗漏
# all_commits=$(git log $second_latest_tag..$latest_tag --pretty=format:"* %s (%an)")
# message+="\n\n### ALL COMMITS:\n$all_commits"

# 企业微信机器人的 Webhook URL
webhook_url="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=525f0d95-2dac-447e-8480-02315214e256"

# 使用 curl 发送消息到企业微信机器人
response=$(curl -s -X POST -H 'Content-Type: application/json' -d "
{
  \"msgtype\": \"markdown\",
  \"markdown\": {
    \"content\": \"$message\"
  }
}" "$webhook_url")

# 检查响应是否成功
if echo "$response" | grep -q '"errcode":0'; then
  echo "Message sent successfully to WeChat Work bot."
else
  echo "Failed to send message to WeChat Work bot. Response: $response"
fi