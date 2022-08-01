[PEP 8 -- Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/)

# 命名规范

#### 1. 命名时尽量使用全称，少使用缩写

#### 2. Package 和 Module 命名

- Package：全部使用小写字符，不推荐使用下划线`_`
- Module：全部使用小写字符，可以使用下划线`_`分割单词

#### 3. 类型命名（类(class)，类型变量(Type Variable)，异常(Exception)）

- 不使用分隔符，每个单词首字母大写
- 当类(class)主要用于调用，并已被文档记录时，则使用函数的命名方法
- 类型变量(Type Variable)有 covariant 或者 contravariant 行为时，应该添加`_co`或者`_contra`作为后缀
```
lang=python
from typing import TypeVar

VT_co = TypeVar('VT_co', covariant=True)
KT_contra = TypeVar('KT_contra', contravariant=True)
```
- 异常(Exception)应该以`Error`作为前缀

#### 4. 函数和变量命名

- 全部使用小写字母，以下划线`_`分隔单词

#### 5. 函数与方法的参数命名

- 使用`self`作为实例方法的第一个参数
- 使用`cls`作为类方法的第一个参数

#### 6. 方法命名和实例变量

- 全部使用小写字母，以下划线`_`分隔单词
- 对于私有实例变量，变量名添加单下划线`_`作为前缀
- 双下划线`__`作为前缀（name mangling）仅用于防止和子类成员命名冲突

#### 7. 常数

- 全部使用大写字母，以下划线`_`分隔单词

# Docstring

统一采用 sphinx 的 docstring 格式
https://sphinx-rtd-tutorial.readthedocs.io/en/latest/docstrings.html
