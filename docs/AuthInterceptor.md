# AuthInterceptor 使用指南

## 
```dart
// 1. 初始化拦截器
final authInterceptor = ref.read(authInterceptorProvider);

// 使用方法 1 回调函数调用
// 包裹需要认证的业务逻辑
// 默认情况下，登录成功后不会自动执行原操作
// 你可以通过配置 executeOnSuccess 为 true 来改变这一行为
final result = await authInterceptor.runWithAuth(
  () async {
    // 执行需要已登录的操作
    return await _postComment(comment);
  }
);

// 使用方法 2  await 调用
final result = await authInterceptor.runWithAuth(() => {});
// 执行需要已登录的操作

// 3. 有需要可以处理结果
result.when(
  success: (data) => print('操作成功: $data'),
  loginFailure: (e) => print('登录失败: $e'),
  actionFailure: (e) => print('操作失败: $e'),
  aborted: () => print('用户取消登录'),
);
```

---

### 参数
| **参数**            | **类型** | **默认值** | **说明**                                                                 |
|---------------------|----------|------------|--------------------------------------------------------------------------|
| `executeOnSuccess`   | `bool`   | `false`    | `true`: 登录成功后自动执行原操作<br>`false`: 仅返回登录成功状态          |

---
