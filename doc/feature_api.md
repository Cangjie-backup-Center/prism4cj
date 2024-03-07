## prism4cj 库

### 介绍
本项目基于开源库 https://github.com/noties/Prism4j
prism4cj 为以后的处理提供任意语法的标记化策略。
(ps: 请注意！本库在实现 grammar_locator 语法加载器时默认将本库支持的所有语法对象都 create 建好，参考的 java 库实现逻辑是即用即创，所以在测试某语法时，传入的语法要一一对应，否则可能会出现 None 值及例如 OOM 异常的情况！)

### 1 语法解析及标记

前置条件：NA
场景：
仓颉开发者使用markdown时需要将一段代码中不同类型的关键词标记出来，语言标记模块提供把一段代码中不同类型的关键词标记出来以满足用户需求
约束：NA 
性能： 支持版本几何性能持平
可靠性： NA

#### 1.1 主要接口

prism 类

```cangjie
public class Prism {

    /**
    * Prism 的有参构造器
    *
    * @param grammarLocator - 语法加载器
    * 
    */
    public init(grammarLocator: GrammarLocator)

    /**
    * 根据语法名字获取语法对象
    *
    * @param name - String 字符串
    *
    * @return 返回 Option 类型 
    */
    public func grammar(name: String): ?Grammar

    /**
    * 根据标记名字和模式集合获取标记对象
    *
    * @param name - String 字符串
    * @param patterns - 模式集合
    *
    * @return 返回标记对象 
    */
    public static func token(name: String, patterns: ArrayList<Pattern>): Token

    /**
    * 根据标记名字和模式数组获取标记对象
    *
    * @param name - String 字符串
    * @param patterns - 模式数组
    *
    * @return 返回标记对象 
    */
    public static func token(name: String, patterns: Array<Pattern>): Token

    /**
    * 根据正则类对象获取模式对象
    *
    * @param regex - Regex 正则类
    *
    * @return 返回模式对象 
    */
    public static func pattern(regex: Regex): Pattern

    /**
    * 根据正则类对象与 lookbehind 属性获取模式对象
    *
    * @param regex - Regex 正则类
    * @param lookbehind - Bool 类型
    *
    * @return 返回模式对象 
    */
    public static func pattern(regex: Regex, lookbehind: Bool): Pattern

    /**
    * 根据正则类对象、lookbehind 属性及 greedy 属性获取模式对象
    *
    * @param regex - Regex 正则类
    * @param lookbehind - Bool 类型
    * @param greedy - Bool 类型
    *
    * @return 返回模式对象
    */
    public static func pattern(regex: Regex, lookbehind: Bool, greedy: Bool): Pattern

    /**
    * 根据正则类对象、lookbehind 属性、greedy 属性及别名获取模式对象
    *
    * @param regex - Regex 正则类
    * @param lookbehind - Bool 类型
    * @param greedy - Bool 类型
    * @param alias - 别名
    *
    * @return 返回模式对象
    */
    public static func pattern(regex: Regex, lookbehind: Bool, greedy: Bool, alias: ?String): Pattern

    /**
    * 根据正则类对象、lookbehind 属性、greedy 属性、别名及 inside 语法获取模式对象
    *
    * @param regex - Regex 正则类
    * @param lookbehind - Bool 类型
    * @param greedy - Bool 类型
    * @param alias - 别名
    * @param inside - inside 语法
    *
    * @return 返回模式对象
    */
    public static func pattern(regex: Regex, lookbehind: Bool, greedy: Bool, alias: ?String, inside: ?Grammar): Pattern

    /**
    * prism 标记核心方法
    *
    * @param text - 文字信息
    * @param grammar - 语法对象
    *
    * @return 返回节点集合
    */
    public func tokenize(text: String, grammar: Grammar): ArrayList<Node>
}
```

语法工具抽象类

```cangjie
public abstract class GrammarUtils {

    /**
    * 根据传入的 grammar 对象，返回克隆后的 grammar 对象
    *
    * @param grammar - 传入一个语法对象
    * 
    * @return 返回 Grammar 语法对象
    */
    public static func clone(grammar: Grammar): Grammar

    /**
    * 根据传入的 token 对象，返回克隆后的 token 对象
    *
    * @param token - 传入一个标记对象
    * 
    * @return 返回 token 标记对象
    */
    public static func clone(token: Token): Token

    /**
    * 根据传入的 pattern 对象，返回克隆后的 pattern 对象
    *
    * @param token - 传入一个模式对象
    * 
    * @return 返回 pattern 模式对象
    */
    public static func clone(pattern: Pattern): pattern

}
```

#### 1.2 其它接口

MyHashKey 自定义 HashKey 类

```cangjie
public class MyHashKey<T> <: Hashable & Equatable<MyHashKey<T>> where T <: Hashable & Equatable<T> {

    /**
    * MyHashKey<T> 的有参构造
    *
    * @param realkey - 泛型类型参数
    * 
    */
    public init(realKey: T)

    /**
    * 计算 hashCode 方法
    *
    * @return 返回 Int64 类型
    * 
    */
    public func hashCode(): Int64

    /**
    * 判断两个 MyHashKey<T> 类对象是否相等
    *
    * @param a - 传入的 MyHashKey<T> 类对象
    *
    * @return 返回 Bool 类型
    * 
    */
    public operator func ==(a: MyHashKey<T>): Bool

    /**
    * 判断两个 MyHashKey<T> 类对象是否不相等
    *
    * @param a - 传入的 MyHashKey<T> 类对象
    *
    * @return 返回 Bool 类型
    * 
    */
    public operator func !=(a: MyHashKey<T>): Bool
}
```

GrammarLocator 语法加载器

```cangjie
public interface GrammarLocator {

    /**
    * 根据 language 语言，解析出本库所支持的语言信息，并根据此信息从 prism 类对象中获取 grammar 对象
    *
    * @param prism - 传入的 prism 类对象
    * @param language - 传入的语言字符串
    *
    * @return 返回 Option 类型
    * 
    */
    func grammar(prism: Prism, language: String): ?Grammar

    /**
    * 获取本库支持的语言集合
    *
    * @return 返回 HashSet<String> 语言集合
    * 
    */
    func languages(): HashSet<String>
}
```

语法工具抽象类
```cangjie

public abstract class GrammarUtils {

    /**
    * 根据 path 路径查找语法中的标记对象
    *
    * @param grammar - 传入的语法对象
    * @param path - String 路径
    *
    * @return 返回 Option 类型
    * 
    */
    public static func findToken(grammar: Grammar, path: String): ?Token

    /**
    * 根据 path 路径向语法对象中插入 tokens 标记集合
    *
    * @param grammar - 传入的语法对象
    * @param path - String 路径
    * @param tokens - ArrayList<Token> 集合
    * 
    */
    public static func insertBeforeToken(grammar: Grammar, path: String, tokens: ArrayList<Token>): Unit

    /**
    * 根据标记对象在 inside 语法中查找 grammar 对象
    *
    * @param token - 传入的标记对象
    *
    * @return 返回 Options 类型
    * 
    */
    public static func findFirstInsideGrammar(token: Token): ?Grammar

    /**
    * 向父类预定义语法中添加标记集合并返回添加后的 grammar 对象
    *
    * @param grammar - 传入的语法对象
    * @name String - 父类预定义语法字符串，如 clike
    * @tokens ?ArrayList<Token> - Options 类型
    *
    * @return 返回语法对象
    * 
    */
    public static func extendGrammar(grammar: Grammar, name: String, tokens: ?ArrayList<Token>): Grammar

    /**
    * 向父类预定义语法中添加标记集合，并过滤掉不需要的标记，最后返回添加后的 grammar 对象
    *
    * @param grammar - 传入的语法对象
    * @name String - 父类预定义语法字符串，如 clike
    * @filter filter - 标记过滤器
    * @tokens ?ArrayList<Token> - Options 类型
    *
    * @return 返回语法对象
    * 
    */
    public static func extendGrammar(grammar: Grammar, name: String, filter: TokenFilter, tokens: ?ArrayList<Token>): Grammar

    /**
    * 从所规定的预定义语言中获取语法对象
    *
    * @param prism - 传入 prism 类对象
    * @name String - 所规定的预定义语言，如 cpp 被 c 规定
    *
    * @return 返回语法对象
    * 
    */
    public static func require(prism: Prism, name: String): Grammar
}
```

TokenFilter 标记过滤器

```cangjie
public interface TokenFilter {

    /**
     * 测试标记是否不需要
     *
     * @param token - 传入的标记对象
     *
     * @return 返回 Bool 类型
     */
    func test(token: Token): Bool
}
```

Grammar 语法抽象类

```cangjie
public abstract class Grammar <: Hashable & Equatable<Grammar> & ToString {

    /**
     * 获取语法名字
     *
     * @return 返回语法名字
     */
    public func name(): String

    /**
     * 获取标记集合
     *
     * @return 返回标记集合
     */
    public func tokens(): ArrayList<Token>
}
```

GrammarImpl 语法抽象类子类

```cangjie

public class GrammarImpl <: Grammar {

    /**
     * GrammarImpl 的有参构造器
     *
     * @param name - 传入 String 字符串
     */
    public init(name: String)

    /**
     * GrammarImpl 的有参构造器
     *
     * @param name - 传入 String 字符串
     * @param tokens - 传入标记集合
     */
    public init(name: String, tokens: ArrayList<Token>)

    /**
     * 获取语法名字
     *
     * @return 返回语法名字
     */
    public override func name(): String

    /**
     * 获取标记集合
     *
     * @return 返回标记集合
     */
    public override func tokens(): ArrayList<Token>

    /**
     * 判断两个 grammar 对象是否相等
     *
     * @param other - 传入的另一个 grammar 对象
     *
     * @return 返回两个 grammar 对象是否相等
     */
    public operator func ==(other: Grammar): Bool

    /**
     * 判断两个 grammar 对象是否不相等
     *
     * @param other - 传入的另一个 grammar 对象
     *
     * @return 返回两个 grammar 对象是否不相等
     */
    public operator func !=(other: Grammar): Bool

    /**
     * 计算 hash 值
     *
     * @return 返回 Int64 类型
     */
    public override func hashCode(): Int64

    /**
     * 自定义 toString 方法
     *
     * @return 返回 String 类型
     */
    public override func toString(): String
}
```

Node 节点接口

```cangjie
public interface Node <: ToString {

    /**
     * 获取节点原始数据长度
     *
     * @return 返回长度信息
     */
    func textLength(): Int64

    /**
     * 判断节点是否是 Syntax 类型
     *
     * @return 返回 Bool 类型
     */
    func isSyntax(): Bool
}
```

Syntax 句法接口

```cangjie
public interface Syntax <: Node & ToString {

    /**
     * 获取句法类型
     *
     * @return 返回 String 类型
     */
    func syntaxType(): String

    /**
     * 获取句法子节点集合
     *
     * @return 返回 ArrayList<Node> 集合
     */
    func children(): ArrayList<Node>

    /**
     * 获取句法别名
     *
     * @return 返回 String 类型
     */
    func alias(): ?String

    /**
     * 获取句法匹配规则
     *
     * @return 返回 String 类型
     */
    func matchedString(): String

    /**
     * 获取句法 greedy 属性值
     *
     * @return 返回 Bool 类型
     */
    func greedy(): Bool

    /**
     * 指示句法的子节点是否被标记化
     *
     * @return 返回 Bool 类型
     */
    func tokenized(): Bool
}
```

Syntax 句法接口实现类

```cangjie
public class SyntaxImpl <: Syntax {

    /**
     * SyntaxImpl 的有参构造器
     *
     * @param syntaxType - 句法类型
     * @param children - 子节点集合
     * @param alias - 句法别名
     * @param matchedString - 匹配规则
     * @param greedy - Bool 类型
     * @param tokenized - Bool 类型
     *
     */
    public init(syntaxType: String, children: ArrayList<Node>, alias: ?String, matchedString: String, greedy: Bool, tokenized: Bool)

    /**
     * 获取句法内容长度
     *
     * @return 返回 Int64 类型
     */
    public override func textLength(): Int64

    /**
     * 判断是否是 Syntax 类型
     *
     * @return 返回 Bool 类型
     */
    public override func isSyntax(): Bool

    /**
     * 获取句法类型
     *
     * @return 返回 String 类型
     */
    public func syntaxType(): String

    /**
     * 获取句法子节点集合
     *
     * @return 返回 ArrayList<Node> 集合
     */
    public override func children(): ArrayList<Node>

    /**
     * 获取句法别名
     *
     * @return 返回 String 类型
     */
    public override func alias(): ?String

    /**
     * 获取句法匹配规则
     *
     * @return 返回 String 类型
     */
    public override func matchedString(): String

    /**
     * 获取句法 greedy 属性值
     *
     * @return 返回 Bool 类型
     */
    public override func greedy(): Bool

    /**
     * 指示句法的子节点是否被标记化
     *
     * @return 返回 Bool 类型
     */
    public override func tokenized(): Bool

    /**
     * 自定义 toString 方法
     *
     * @return 返回 String 类型
     */
    public override func toString(): String
}
```

Text 文本接口

```cangjie
public interface Text <: Node {
    
    /**
     * 获取文本文字信息
     *
     * @return 返回 String 类型
     */
    func literal(): String
}
```

TextImpl 实现类

```cangjie
public class TextImpl <: Text {

    /**
     * TextImpl 的有参构造器
     *
     */
    public init(literal: String)

    /**
     * 获取文本内容长度
     *
     * @return 返回 Int64 类型
     */
    public override func textLength(): Int64

    /**
     * 判断是否是 Syntax 类型
     *
     * @return 返回 Bool 类型
     */
    public override func isSyntax(): Bool

    /**
     * 获取文本文字信息
     *
     * @return 返回 String 类型
     */
    public override func literal(): String

    /**
     * 自定义 toString 方法
     *
     * @return 返回 String 类型
     */
    public override func toString(): String
}
```

Pattern 模式抽象类

```cangjie
public abstract class Pattern <: Hashable & Equatable<Pattern> & ToString {

    /**
     * 获取模式 Regex 正则对象
     *
     * @return 返回 Regex 类型
     */
    public func regex(): Regex

    /**
     * 获取 lookbehind 信息
     *
     * @return 返回 Bool 类型
     */
    public func lookbehind(): Bool

    /**
     * 获取 greedy 信息
     *
     * @return 返回 Bool 类型
     */
    public func greedy(): Bool

    /**
     * 获取模式别名
     *
     * @return 返回 Option 类型
     */
    public func alias(): ?String

    /**
     * 获取 inside 语法下的 grammar 对象
     *
     * @return 返回 Option 类型
     */
    public func inside(): ?Grammar
}
```

PatternImpl 实现类

```cangjie
public class PatternImpl <: Pattern {

    /**
     * PatternImpl 的有参构造器
     *
     * @param regex - 正则类对象
     * @param lookbehind - Bool 类型
     * @param greedy - Bool 类型
     * @param alias - 别名
     * @grammar insize - 语法
     */
    public init(regex: Regex, lookbehind: Bool, greedy: Bool, alias: ?String, inside: ?Grammar)

    /**
     * 获取模式 Regex 正则对象
     *
     * @return 返回 Regex 类型
     */
    public override func regex(): Regex

    /**
     * 获取 lookbehind 信息
     *
     * @return 返回 Bool 类型
     */
    public override func lookbehind(): Bool

    /**
     * 获取 greedy 信息
     *
     * @return 返回 Bool 类型
     */
    public override func greedy(): Bool

    /**
     * 获取模式别名
     *
     * @return 返回 Option 类型
     */
    public override func alias(): ?String

    /**
     * 获取 inside 语法下的 grammar 对象
     *
     * @return 返回 Option 类型
     */
    public override func inside(): ?Grammar 

    /**
     * 判断两个 Pattern 模式对象是否相等
     *
     * @param other - 另一个模式对象
     *
     * @return 返回 Bool 类型
     */
    public operator func ==(other: Pattern): Bool

    /**
     * 判断两个 Pattern 模式对象是否不相等
     *
     * @param other - 另一个模式对象
     *
     * @return 返回 Bool 类型
     */
    public operator func !=(other: Pattern): Bool

    /**
     * 计算 hash 值
     *
     * @return 返回 Int64 类型
     */
    public override func hashCode(): Int64

    /**
     * 自定义 toString 方法
     *
     * @return 返回 String 类型
     */
    public override func toString(): String
}
```

Token 标记接口

```cangjie
public abstract class Token <: Hashable & Equatable<Token> & ToString {

    /**
     * 获取标记名字
     *
     * @return 返回 String 字符串
     */
    public func name(): String

    /**
     * 获取模式集合
     *
     * @return 返回 ArrayList<Pattern> 集合
     */
    public func patterns(): ArrayList<Pattern>
}
```

TokenImpl 实现类

```cangjie
public class TokenImpl <: Token {

    /**
     * TokenImpl 的有参构造器
     *
     * @param name - 标记的名字
     * @param patterns - 模式集合
     */
    public init(name: String, patterns: ArrayList<Pattern>)

    /**
     * 获取标记名字
     *
     * @return 返回 String 字符串
     */
    public override func name(): String

    /**
     * 获取模式集合
     *
     * @return 返回 ArrayList<Pattern> 集合
     */
    public override func patterns(): ArrayList<Pattern>

    /**
     * 判断两个 Token 标记对象是否相等
     *
     * @param other - 另一个标记对象
     *
     * @return 返回 Bool 类型
     */
    public operator func ==(other: Token): Bool

    /**
     * 判断两个 Token 标记对象是否不相等
     *
     * @param other - 另一个标记对象
     *
     * @return 返回 Bool 类型
     */
    public operator func !=(other: Token): Bool

    /**
     * 计算 hash 值
     *
     * @return 返回 Int64 类型
     */
    public override func hashCode(): Int64

    /**
     * 自定义 toString 方法
     *
     * @return 返回 String 类型
     */
    public override func toString(): String
}
```

Visitor 接口

```cangjie
public interface Visitor {

    /**
     * 节点访问方法
     *
     * @param nodes - 节点集合
     */
    func visit(nodes: ArrayList<Node>): Unit
}
```

AbsVisitor 抽象类

```cangjie
public abstract class AbsVisitor <: Visitor {

    /**
     * 节点访问方法
     *
     * @param nodes - 节点集合
     */
    public override func visit(nodes: ArrayList<Node>): Unit
}
```

grammar_locator_grammar_utils.cj 语法加载器工具类

```cangjie
public class GrammarLocatorGrammarUtils <: GrammarLocator {

    /**
     * GrammarLocatorGrammarUtils 的无参构造器
     *
     */
    public init()

    /**
     * 自定义注册语法方法
     *
     * @param name - 语法名字
     * @param grammar - 语法对象
     *
     */
    public func register(name: String, grammar: Grammar): Unit


    /**
    * 根据语言名字，从 prism 类对象中获取语法对象
    *
    * @param prism - prism 类对象
    * @param language - 语言
    *
    * @return 返回 Option 类型 
    */
    public func grammar(prism: Prism, language: String): ?Grammar

    /**
    * 获取本库支持的语言集合
    *
    * @return 返回 HashSet<String> 集合
    */
    public func languages(): HashSet<String>
}
```

#### 1.3 示例

```cangjie
from std import unittest.*
from std import unittest.testmacro.*
from std import fs.*
from std import collection.*
from prism4cj import prism.*
from prism4cj import prism4cj.GrammarLocatorGrammarUtils

main(): Int64 {
    var test = TestCangjie()
    test.execute()
    test.printResult()
    return 0
}

@Test
public class TestCangjie {

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("cangjie")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("cangjie")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
    }
}
```

执行结果如下：
```shell
[ PASSED ] CASE: test01
```

### 2 预定义语法

前置条件：NA
场景：
仓颉开发者使用markdown时需要预定义一些不同语法的解析器，提供解决方案满足用户需求
约束：NA 
性能： 支持版本几何性能持平
可靠性： NA

#### 2.1 主要接口

PrismBrainfuck 类

```cangjie
public class PrismBrainfuck {

    /**
    * 创建 BrainFuck 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): Grammar
}
```

PrismC 类

```cangjie
public class PrismC {

    /**
    * 创建 C 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(prism: Prism): Grammar
}
```

PrismClike 类

```cangjie
public class PrismClike {

    /**
    * 创建 Clike 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(prism: Prism): Grammar
}
```

PrismClojure 类

```cangjie
public class PrismClojure {

    /**
    * 创建 Clojure 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(prism: Prism): Grammar
}
```

PrismCpp 类

```cangjie
public class PrismCpp {

    /**
    * 创建 Cpp 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(prism: Prism): Grammar
}
```

PrismCsharp 类

```cangjie
public class PrismCsharp {

    /**
    * 创建 Csharp 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(prism: Prism): Grammar
}
```

PrismCss 抽象类

```cangjie
public abstract class PrismCss {

    /**
    * 创建 Css 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(prism: Prism): Grammar
}
```

PrismCssExtras 类

```cangjie
public class PrismCssExtras {

    /**
    * 创建 CssExtras 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismDart 类

```cangjie
public class PrismDart {

    /**
    * 创建 Dart 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismGit 类

```cangjie
public class PrismGit {

    /**
    * 创建 Git 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismGo 类

```cangjie
public class PrismGo {

    /**
    * 创建 Go 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismGroovy 类

```cangjie
public class PrismGroovy {

    /**
    * 创建 Groovy 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismJava 类

```cangjie
public class PrismJava {

    /**
    * 创建 Java 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismJavascript 类

```cangjie
public class PrismJavascript {

    /**
    * 创建 Javascript 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismJson 类

```cangjie
public class PrismJson {

    /**
    * 创建 Json 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismKotlin 类

```cangjie
public class PrismKotlin {

    /**
    * 创建 Kotlin 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismLatex 类

```cangjie
public class PrismLatex {

    /**
    * 创建 Latex 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismMakefile 类

```cangjie
public class PrismMakefile {

    /**
    * 创建 Makefile 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismMarkdown 类

```cangjie
public class PrismMarkdown {

    /**
    * 创建 Markdown 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismMarkup 抽象类

```cangjie
public abstract class PrismMarkup {

    /**
    * 创建 Markup 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismPython 类

```cangjie
public class PrismPython {

    /**
    * 创建 Python 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismScala 类

```cangjie
public class PrismScala {

    /**
    * 创建 Scala 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismSql 类

```cangjie
public class PrismSql {

    /**
    * 创建 Sql 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismSwift 类

```cangjie
public class PrismSwift {

    /**
    * 创建 Swift 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismYaml 类

```cangjie
public class PrismYaml {

    /**
    * 创建 Yaml 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```

PrismCangjie 类

```cangjie
public class PrismCangjie {

    /**
    * 创建 Cangjie 预定义语法类
    *
    * @return 返回 grammar 类对象
    */
    public static func create(): ?Grammar
}
```