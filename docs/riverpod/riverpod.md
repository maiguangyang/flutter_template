

## 阶段2：按模块迁移（推荐顺序）

### Provider 转换

```dart
// 修改前
CustomProvider<IPickupTimeService>(create: (context) => PickupTimeService())

// 修改后
final pickupTimeServiceProvider = CustomProvider<IPickupTimeService>((ref) => PickupTimeService());
```

### ChangeNotifier 迁移

```dart
// 修改前
class Counter extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners();
  }
}

// 修改后
class CounterNotifier extends rp.StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
}

final counterProvider = rp.StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier()
);


// 使用 @riverpod 生成代码
@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  int build() => 0;
  void increment() => state++;
}

final counterProvider = CounterNotifier.provider;



```

### 组件迁移

ConsumerWidget 替代 StatelessWidget

```dart
// 修改前
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = context.watch<MyService>();
    return Text(service.value);
  }
}

// 修改后
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(myServiceProvider);
    return Text(service.value);
  }
}

```

ConsumerStatefulWidget 替代 StatefulWidget

```dart
// 修改前

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenController();
}

class _CheckoutScreenController extends State<CheckoutScreen> {
  
}

// 修改后
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutScreenController();
}

class _CheckoutScreenController extends ConsumerState<CheckoutScreen> {
  @override
  void initState() {
    super.initState();

    // 状态生命周期也可以访问“ref”。
    ref.listenManual(activityProvider, (previous, next) {
      // doing something
    });


  }

  @override
  Widget build(BuildContext context) {
    // “ref”不再作为参数传递，而是作为“ConsumerState”的属性。
    // 因此，我们可以继续在“build”中使用“ref.watch”。
    final AsyncValue<Activity> activity = ref.watch(activityProvider);

    return Center(/* ... */);
  }
}

```

### 代码生成

```dart
part 'product_detail_provider.g.dart';

@Riverpod()
class ProductDetailNotifier extends _$ProductDetailNotifier {
  late FetchProductDetailUseCase _fetchUseCase;

  @override
  AsyncValue<Product> build(String productId, String? promotionId) {
    // 依赖注入 UseCase
    _fetchUseCase = ref.read(fetchProductDetailUseCaseProvider);
    
    // 自动触发初始化加载
    _loadProductDetail();
    return const AsyncValue.loading();
  }
}

运行 `make code`

无需手动声明 Provider

自动生成 `ProductDetailNotifierProvider`

```dart
final productState = ref.watch(productDetailNotifierProvider(id, promotionId));
final notifier = ref.read(productDetailNotifierProvider(id,promotionId).notifier);

```


#### 注解

```dart

// keepalive 默认 true
@Riverpod(keepAlive: false) // 等效于autoDispose
class Counter extends _$Counter {
  @override
  int build() => 0;
}

// 效果：当所有监听者移除时自动销毁状态
```

## 应用层


UI Layer (Widget)
  └─> ProductDetailNotifier (Application State Management)
        └─> FetchProductDetailUseCase (Application Logic)
              └─> ProductStoreImpl (Repository 数据层 存)
                  └─> productService (Repository 数据层 取)

单向数据流：
UI Event → Notifier → UseCase → Repository → API

State Change ← Notifier ← UseCase ← Repository ← API

## 写法

1. 定义 useCase
```dart
FetchProductDetailUseCase

class FetchProductDetailUseCase {
  final ProductRepository _store;

  // 通过构造函数注入依赖
  FetchProductDetailUseCase(this._store);
  // ...
}
```

2. 创建 Provider 提供 UseCase 实例

```dart
// 1. 先定义 ProductRepository 的 Provider
final productRepositoryProvider = CustomProvider<ProductRepository>((ref) {
  return ProductRepositoryImpl(); // 具体实现
});

// 2. 创建 UseCase 的 Provider
final fetchProductDetailUseCaseProvider = CustomProvider<FetchProductDetailUseCase>((ref) {
  // 通过 ref 获取 ProductRepository 实例
  final repository = ref.read(productRepositoryProvider);
  
  // 注入依赖到 UseCase
  return FetchProductDetailUseCase(repository);
});
```

3. 在 Notifier 中使用 UseCase

```dart
@riverpod
class ProductDetailNotifier extends _$ProductDetailNotifier {
  @override
  FutureOr<Product> build(String productId) async {
    // 1. 通过 ref 获取 UseCase 实例
    final useCase = ref.read(fetchProductDetailUseCaseProvider);
    
    // 2. 执行用例
    return useCase.execute(productId);
  }

  // 其他方法...
}
```

4. 在 Widget 中使用 Provider
```dart
final productState = ref.watch(productDetailNotifierProvider(productId));
```

流程：
`UI` -> `Notifier` - ref.read -> `UseCaseProvider` - 获取实例 -> `UseCase` - 依赖 -> `Repository`

## 响应式更新

在 Riverpod 中，绝对不能直接修改 state 的属性，这样做会破坏响应式机制。

因为 Riverpod 依赖状态对象的引用变化来检测更新。如果直接修改属性，引用不会变化，因此不会触发 UI 更新。

```
// 错误！不会触发 UI 更新
state.customerProfile = response;
state.paymentList = response?.paymentMethodDtos ?? [];
```

正确的做法是使用 `state = state.copyWith(...)` 来创建一个新的状态对象。

只更新部分属性：

```dart
state = state.copyWith(paymentList: newList); // 只更新列表

在 UI 中使用 select 优化
final paymentList = ref.watch(
  creditCardHookProvider.select((state) => state.paymentList)
);
```

## 调试技巧

```dart
CreditCardState build() {

  print('CreditCardHookProvider build!');

  // Provider销毁时触发 建议加上 方便调试
  ref.onDispose(() {
    print('CreditCardHookProvider disposed!');
  });
  return const CreditCardState();

}
```

## Todo：

1. 处理 Api 多个 baseUrl 实例 (IM 要用)
2. 接口错误信息多语言