<!--
 * @Author: Marlon.M
 * @Email: maiguangyang@163.com
 * @Date: 2025-08-26 08:58:24
-->

## Notifiers

### 核心职责
	•	管理 可变状态（mutable state）
	•	承载 业务逻辑（state 变化的规则、处理异步请求等）
	•	通常与 StateNotifier/Notifier 结合使用

### 特点
	•	内部有 state，通过 state = newState 更新状态
	•	UI 通过 ref.watch(notifierProvider) 或 ref.watch(notifierProvider.select(...)) 监听状态变化
	•	支持组合复杂逻辑（比如登录、购物车、订单状态等）


## Providers

### 核心职责
	•	提供 不可变、可复用的数据或依赖
	•	比如单例服务、API、Repository、全局配置
	•	只是提供数据或对象，不直接管理状态

### 特点
	•	可以是 Provider、FutureProvider、StreamProvider 等
	•	一般没有内部状态变化逻辑，或者状态变化由其依赖的 Notifier 管理
	•	UI 直接依赖 Provider 获取实例，而不是管理状态