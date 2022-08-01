##此文档主要描述!!单元测试规则!!, !!pytest使用!!和!!集成测试!!

参考: 
* [[ https://docs.pytest.org/en/stable/ | pytest官方文档 ]]
* [[ https://learning-pytest.readthedocs.io/zh/latest/doc/intro/getting-started.html | pytest快速入门 ]]
* [[ https://github.com/Graviti-AI/tensorbay-python-sdk/blob/main/tensorbay/dataset/tests/test_data.py | TensorbaySDK示例: test_data.py ]]

---


### 单元测试基础规则

#### 命名规则:
 
* 测试文件放在模块对应`tests`文件夹中
* 测试文件名以`test_`开头
* 测试类以`Test_`开头
* 测试函数以`test_`开头

#### 编写规则: 

* 测试代码也需要良好的命名规范和可读性(即使linter不检查)
* 测试函数需要有固定的输入和输出
* 尽量覆盖每一个函数
* 使用断言来检验结果
* 预计抛出的异常也需要在测试中得以体现

---

###安装pytest
```
pip3 install pytest
```


###编写测试函数：

#### 使用`assert`进行结果检验，示例：
```
name=test_pass.py, lang=python
def test_passing():
    assert 3 == (1+2)
```

#### 捕获异常
测试预期需要抛出的异常，示例:
```
name=test_raise.py, lang=python
def test_raises():
    with pytest.raises(ValueError):
        int("a")
```

绝大多数情况仅比较异常类型即可，如果需要更进一步的匹配抛出的异常
可以使用match进行正则匹配异常是否发生, 示例:
```
name=test_raise.py, lang=python
def test_match(self):
    with pytest.raises(ValueError, match=r"invalid literal for int().*"):
        int("a")
```

##### ps:
```
lang=shell
[1] int("a")
ValueError: invalid literal for int() with base 10: 'a'
```

#### 参数化
需要给同一组函数传递多组数据运行测试时，可以考虑使用参数化
如以下示例，pytest会自动使用passwd列表里的三组参数运行三次test_passwd_length()
```
name=test_parametrize.py, lang=python
@pytest.mark.parametrize('passwd',['123456','abcdefdfs','as52345fasdf4'])

def test_passwd_length(passwd):
    assert len(passwd) >= 8
```


#### fixture

可以理解为pytest中的可定制的固件，可以进行参数化的测试
也可以通过fixture完成测试数据注入和mock功能
如下示例中，可以通过传递data参数进入param固件中，完成预定好的操作流程再返回特定的值
```
lang=python
data = "a"

@pytest.fixture
def param(request):
    return request.param

@pytest.mark.parametrize("param", data)
def test_load(param):
    assert param == data

```

### 运行测试

执行命令`pytest`即可自动运行符合命名规则的测试函数
```
zhen@amax:~/enigma/python/graviti$ pytest
======================================= test session starts ========================================
platform linux -- Python 3.7.4, pytest-6.2.2, py-1.10.0, pluggy-0.13.1
rootdir: /home/zhen/zhen_code/enigma/python/graviti
collected 17 items

dataset/tests/test_data.py .............                                                      [ 76%]                                                                                                                                                                                                                        
geometry/tests/test_vector.py ....                                                            [100%]                                                                                                                                                                                                                        

======================================== 17 passed in 4.08s ========================================
```

NOTE: 也可以运行单独的模块，使用`pytest “模块名”`即可，类似`pytest dataset`

NOTE: pytest 使用 `.` 标识测试成功（`PASSED`）

NOTE: 后面的分数仅代表测试的运行进度

---

#### 运行时的常见参数示例

##### 运行特定的文件/函数

```
pytest tests/test_segmentclient.py::TestSegmentClient::test_upload_file
```

##### 查看DEBUG的来回报文信息
```
pytest tests --log-cli-level=DEBUG
```

##### 查看print()输出
```
pytest tests -s
```

---

###集成测试

我们需要测试相应的环境下SDK中各个功能与否与TensorBayAPI正常交互

####集成测试存放位置
集成测试代码放在与tensorbay同级的tests文件夹中
```
├── tensorbay
│   ├── __init__.py
│   ├── client
│   ...
└── tests   # 集成测试文件夹
    ├── __pycache__
    └── conftest.py
```

####获取所需参数
集成测试需要与后端进行交互，所以需要配置相应的AccessKey和Url
如需配置其他参数，可以参考`tests/conftest.py`文件，也可以联系@zhen.chen

#####传递参数
目前已经配置了`--accesskey`和`--url`参数
你可以在运行测试时将对应值传入
```
pytest tests --accesskey key --url prod.cn
```

#####测试中获取参数
可以通过以下方式在测试代码中获取传入的值
```
def test_fun(accesskey, url):
    gas = GAS(accesskey, url)
```

####在GitHub中运行集成测试
也可以通过相应的githu actions，在云上手动运行集成测试

#####配置私有变量
1. 点击仓库的`setting` -> `Secrets`
2. 点击右上角`New repository secret`
{F133680, width=700}
3. 配置`accesskey`和`url`两个字段

#####手动运行集成测试
1. 点击仓库的`Actions`
2. 点击左侧All workflows中的`Run integration test`
3. 选择`Run workflow`
{F133684, width=700}

---

##pytest插件

###检测覆盖率
使用pytest-cov插件
####安装
```pip install pytest-cov```
####在项目根目录运行
```pytest --cov=tensorbay tensorbay

Name                                                       Stmts   Miss  Cover
------------------------------------------------------------------------------
tensorbay/label/__init__.py                                   12      0   100%
tensorbay/label/attributes.py                                 98      1    99%
tensorbay/label/basic.py                                     108      8    93%
tensorbay/label/catalog.py                                    42      4    90%
tensorbay/label/label_box.py                                  67      0   100%
...
------------------------------------------------------------------------------
TOTAL                                                       5954   2245    62%
```
字段解释:
* Name: 文件名

####生成html网页报告

运行
`pytest --cov=tensorbay tensorbay --cov-report=html`
进入`./htmlcov`目录，打开`index.html`查看详细报告

###查看代码仓库中覆盖率情况:

1. [[ https://coveralls.io/refresh?private=true | 初始化 ]]

2. 点击[[ https://coveralls.io/github/Graviti-AI/tensorbay-python-sdk | coeralls ]]查看

---


NOTE: 可以通过配置`alias pytest-dev='pytest --accesskey Accesskey --url https://gas.dev.graviti.cn/'`来设置快捷键
