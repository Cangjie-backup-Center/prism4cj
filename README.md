<div align="center">
<h1>prism4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.54.3-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-94.4%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

prism4cj 为以后的处理提供任意语法的标记化策略。

### 特性

- 🚀 支持标记不同类型的关键词
- 🚀 支持不同语言的解析器/分发器
- 🚀 支持预定义语法解析器

### 架构

```mermaid
flowchart LR
    md[/Markdown围栏代码Text/] -->grammar(语言查询)
    grammar --> tokenize(代码及grammar解析)
    tokenize --> renderer(Renderer渲染)
    renderer <--> visitor[[Visitor遍历]]
    renderer --> res[/渲染结果/]
```

### 源码目录

```shell
├── doc
├── src
    ├── languages                    语言包
        ├── prism_brainfuck.cj       brainfuck 语言规则
        ├── prism_c.cj               c 语言规则
        ├── prism_clike.cj           clike 类语言规则
        ├── prism_clojure.cj         clojure 类语言规则
        ├── prism_cpp.cj             cpp 类语言规则
        ├── prism_csharp.cj          csharp 语言规则
        ├── prism_css_extras.cj      css_extras 语言规则
        ├── prism_css.cj             css 类语言规则
        ├── prism_dart.cj            dart 类语言规则
        ├── prism_git.cj             git 类语言规则
        ├── prism_go.cj              go 语言规则
        ├── prism_groovy.cj          groovy 语言规则
        ├── prism_java.cj            java 类语言规则
        ├── prism_javascript.cj      javascript 类语言规则
        ├── prism_json.cj            json 类语言规则
        ├── prism_kotlin.cj          kotlin 语言规则
        ├── prism_latex.cj           latex 语言规则
        ├── prism_makefile.cj        makefile 类语言规则
        ├── prism_markdown.cj        markdown 类语言规则
        ├── prism_markup.cj          markup 类语言规则
        ├── prism_python.cj          python 类语言规则
        ├── prism_scala.cj           scala 语言规则
        ├── prism_sql.cj             sql 类语言规则
        ├── prism_swift.cj           swift 类语言规则
        ├── prism_yaml.cj            yaml 类语言规则
        ├── prism_cangjie.cj         cangjie 类语言规则
    ├── prism                        主函数包
        ├── cloner.cj                cloner 克隆类
        ├── grammar_locator.cj       语法加载器类
        ├── grammar_utils.cj         语法工具类
        ├── grammar.cj               语法类
        ├── node.cj                  节点类
        ├── pattern.cj               模式类
        ├── prism_tostring.cj        自定义 toString 工具类
        ├── prism.cj                 核心类
        ├── token.cj                 令牌类
        ├── visitor.cj               visitor 类
    ├── grammar_locator_grammar_utils.cj grammar加载器工具类
└── test
    ├── DOC                          文档示例
    ├── HLT                          HLT用例
    └── LLT                          LLT自测用例
├── CHANGELOG.md
├── gitee_gate.cfg
├── LICENSE
├── module.json
├── README.md
├── README.OpenSource
```

- `DOC` 存放本库使用文档
- `src` 是库源码目录
- `test` 是存放测试用例的文件夹，含有 DOC 功能示例、FUZZ 测试用例、HLT 测试用例、LLT 自测用例

### 接口说明

主要是核心类和成员函数说明,详情见 [API](./doc/feature_api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译构建

#### linux环境编译

编译描述和具体shell命令

```shell
cjpm build
```

#### Windows环境编译

编译描述和具体cmd命令

```cmd
cjpm build
```

### 执行用例
编译用例并执行，步骤如下：

#### 1. 进入 test/ 目录下创建 tmp 文件夹，然后编译测试用例
```shell
cd test/
mkdir tmp
cjc -O2 --import-path xxxxx/target/release -L xxxxx/target/release/prism4cj -l -l prism4cj_prism -l prism4cj_languages -l prism4cj_prism4cj LLT/testC.cj LLT/testUtils.cj -o tmp/testC.cj.out --test
```

##### 1.1 具体说明

- cjc命令, -O2表示开启优化
```shell
cjc -O2
```
- --import-path 导入 prism4cj 库编译出来的库文件地址, 注意地址最后有".."
- xxx 代表自己的工作目录，应替换成自己的实际工作目录
- -L 导入库文件的完整路径
- 导入多个库,每个库都需要--import-path和 -L

```shell
--import-path xxxxx/target/release -L xxxxx/target/release/prism4cj -l -l prism4cj_prism -l prism4cj_languages -l prism4cj_prism4cj
```
- -l 要导入的具体的包, 用"库名_包名",一般库文件生成时是"lib库名_包名.后缀"的格式
- 导入一个库中有多个包时,用多个 -l

- 测试用例的完整路径和用例中引入文件的完整路径
- -o 用例编译后输出的位置和名称, .out结尾, 一般使用"用例名称.out"
- --test 用例编译命令结尾
```shell
LLT/testC.cj LLT/testUtils.cj -o tmp/testC.cj.out --test
```

#### 2. 把编译好的文件复制到 .out 文件下(test/tmp/) 
- target/release/prism4cj 目录中的文件都复制到 .out 文件位置(test/tmp/ 中)

#### 3. 进入到.out文件位置，执行用例
- 进入到.out文件位置执行用例
```shell
cd test/tmp
```
- windows系统打开cmd,输入.out文件完整名称即可执行
- Linux系统使用 ./.out文件完整名称

### 功能示例

#### c 语言关键词标记示例

```cangjie
import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.collection.*
import prism4cj.prism.*
import prism4cj.prism4cj.GrammarLocatorGrammarUtils

main(): Int64 {
    var test = TestCReadme()
    let res = test.asTestSuite().runTests()
    let fail = res.failedCount + res.errorCount
    if (fail == 0) {
        return 0
    }
    return 1
}

@Test
public class TestCReadme {

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("c")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("c")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
            
        }
    }

}
```

执行结果如下：
```shell
0
```

## 约束与限制

在下述版本验证通过：
```shell
Cangjie Version: 0.54.3
```

## 开源协议

本项目基于 [Apache License 2.0](https://gitcode.com/Cangjie-TPC/prism4cj/blob/develop/LICENSE) ，请自由的享受和参与开源。

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

欢迎给我们提交 PR，欢迎给我们提交 issue，欢迎参与任何形式的贡献。
