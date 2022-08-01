##常量/变量
类常量/变量顺序定义如下，不同部分用空行隔开。
```
name=类常量/变量顺序
- private: 
    - TypeVar

    - constant:
        - _repr_type
        - _repr_attrs
        - _repr_maxlevel

        - others

    - attr

- public:
    - TypeVar

    - constant

    - attr

```
---
##函数
类内函数顺序定义如下
```
name=类内函数顺序
- __new__
- __init__
- 魔法方法
- 私有方法:
    - 静态方法
    - 类方法
    - 属性(property)
    - 普通私有方法
    - 其他
- 公有方法:
    - 静态方法
    - 类方法
    - 属性(property)
    - 普通公有方法
    - 其他

```

其中**魔法方法**内顺序定义如下表

| 魔法方法类别            | 方法名                                                                                                                                                                    |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 实例创建和销毁          | `__new__` 、 `__init__` 、 `__del__`                                                                                                                                      |
| 字符串/字节序列表示形式 | `__repr__` 、 `__str__` 、 `__format__` 、 `__bytes__`                                                                                                                    |
| 数值转换                | `__abs__` 、 `__bool__` 、 `__complex__` 、 `__int__` 、 `__float__` 、 `__hash__` 、 `__index__`                                                                         |
| 集合模拟                | `__len__` 、 `__getitem__` 、 `__setitem__` 、 `__delitem__` 、 `__contains__`、`__missing__`                                                                                            |
| 迭代枚举                | `__iter__` 、 `__reversed__` 、 `__next__`                                                                                                                                |
| 可调用模拟              | `__call__`                                                                                                                                                                |
| 上下文管理              | `__enter__` 、 `__exit__`                                                                                                                                                 |
| 属性管理                | `__getattr__` 、 `__getattribute__` 、 `__setattr__` 、 `__delattr__` 、 `__dir__`                                                                                        |
| 属性描述符              | `__get__` 、 `__set__` 、 `__delete__`                                                                                                                                    |
| 跟类相关的服务          | `__prepare__` 、 `__instancecheck__` 、 `__subclasscheck__`                                                                                                               |
| 一元运算符              | `__neg__` - 、 `__pos__` + 、 `__abs__` `abs()`                                                                                                                           |
| 众多比较运算符          | `__lt__` < 、 `__le__` <= 、 `__eq__` == 、 `__ne__` != 、 `__gt__` > 、 `__ge__` >=                                                                                      |
| 算术运算符              | `__add__` + 、 `__sub__` - 、 `__mul__` * 、 `__truediv__` / 、 `__floordiv__` // 、 `__mod__` % 、 `__divmod__` divmod() 、 `__pow__` ** 或 pow() 、 `__round__` round() |
| 反向算术运算符          | `__radd__` 、 `__rsub__` 、 `__rmul__` 、 `__rtruediv__` 、 `__rfloordiv__` 、 `__rmod__` 、 `__rdivmod__` 、 `__rpow__`                                                  |
| 增量赋值算术运算符      | `__iadd__` 、 `__isub__` 、 `__imul__` 、 `__itruediv__` 、 `__ifloordiv__` 、 `__imod__` 、 `__ipow__`                                                                   |
| 位运算符                | `__invert__` ~ 、 `__lshift__` << 、 `__rshift__` >> 、 `__and__` & 、 `__or__`、 `__xor__` ^                                                                               |
| 反向位运算符            | `__rlshift__` 、 `__rrshift__` 、 `__rand__` 、 `__rxor__` 、 `__ror__`                                                                                                   |
| 增量赋值位运算符        | `__ilshift__` 、 `__irshift__` 、 `__iand__` 、 `__ixor__` 、 `__ior__`                                                                                                   |

NOTE: 算数或位运算符中，同一运算符的正向、反向与增量赋值方法放在一起，且按上述顺序排列。

```
- 算数/位运算符
    - 正向
    - 反向
    - 增量赋值
```
