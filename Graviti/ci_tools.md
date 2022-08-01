本文档主要描述以下三个持续性集成工具
* [[ https://azure.microsoft.com/en-us/services/devops/pipelines/ | Asure pipeline ]]
* [[ https://travis-ci.org/ | Travis CI ]]
* [[ https://circleci.com/ | CircleCI ]]

在tensorbay中使用持续集成工具的主要目的是在代码提交之后便可以通过工具自动进行代码样式检查，运行测试等流程，这将有助于减少负责代码审查的人员的工作量，节省时间并提高代码质量


##共有特性：
* 开源项目免费使用
* 支持使用云服务器和私有化部署服务器
* 支持 Docker，可以配置自定义环境
* 支持在不同环境中并行运行测试
* 使用.yaml文件作为配置文件

##Travis CI
Travis CI是一个为开源项目创建的工具，专注于CI(持续性集成)
* 支持环境: 
 * Ubuntu (20.04, 18.04, 16.04 default, 14.04, 12.04)
 * MacOs
 * Windows Server, version 1809
* 与github结合十分紧密
* 支持构建矩阵
* 没有免费的企业项目计划
* 配置文件逻辑：最开始定义语言版本和运行环境的配置矩阵，然后定义运行步骤
* 基于虚拟机

ps
构建矩阵: 方便快速使用不同版本的语言和程序包运行测试，可以使某些环境的失败触发通知，但整个构建会继续执行

配置文件示例:
```
lang=yml, name=.travis.yml
language: python            # this works for Linux but is an error on macOS or Windows
jobs:
  include:
    - name: "Python 3.8.0 on Xenial Linux"
      python: 3.8           # this works for Linux but is ignored on macOS or Windows
    - name: "Python 3.7.4 on macOS"
      os: osx
      osx_image: xcode11.2  
      language: shell       # 'language: python' is an error on Travis CI macOS
    - name: "Python 3.8.0 on Windows"
      os: windows           # Windows 10.0.17134 N/A Build 17134
      language: shell       
      before_install:
        - choco install python --version 3.8.0
        - python -m pip install --upgrade pip
      env: PATH=/c/Python38:/c/Python38/Scripts:$PATH
install: pip3 install --upgrade pip  
script: python3 test.py || python test.py
```

##Circle CI
CircleCI是一个基于云的工具，用于持续集成和部署
* 支持触发较新的构建时，自动取消排队或正在运行的构建
* 有一个免费的企业项目计划
* 配置文件逻辑：先定义每个工作流的节点，最后拼凑出整个工作流
* 提供Orbs
* 基于虚拟机

ps
Orbs: 可以直接使用别人开源的工作流节点，简化配置文件(拼凑workflow时可以传递配置好的自定义参数)
配置文件示例
```
lang=yml, name=.circle/config.yml
version: 2.1
orbs:
  python: circleci/python@1.0.0
jobs:
  publish:
    executor: python/default
    steps:
      - checkout
      - python/dist
      - run: pip install pytest
workflows:
  main:
    jobs:
      - python/test:
          args: '--dev'
          pkg-manager: pipenv
          test-tool: pytest
      - publish
```

##Asure pipeline
是微软推出Azure DevOps中的一项持续性集成和部署服务
* 支持环境:
 * Linux(Ubuntu, Red Hat, Oracle Linux, ...)
 * macOS Sierra (10.12) or higher
 * Windows(7, 8.1, 10)
* 可以通过构建管道一次性部署到多个服务器上
* 与Azure DevOps Service更好的结合
* 相比于前面两种工具覆盖的面更广，构建更灵活，相对的，使用也更加复杂
* 基于docker

##总结
三个项目的综合大小为Travis CI < Circle CI < Asure pipeline
三种工具对于持续性集成方面提供的功能基本都类似，不同的只是使用方法和易用性，以及特有的一些可以优化配置步骤的功能

