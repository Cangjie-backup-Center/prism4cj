/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism4cj

internal import prism4cj.languages.*
internal import prism4cj.prism.*
internal import std.collection.ArrayList
internal import std.collection.HashMap
internal import std.collection.HashSet

public class GrammarLocatorGrammarUtils <: GrammarLocator {
    let cache: HashMap<String, Grammar> = HashMap<String, Grammar>(4)
    let NULL = GrammarImpl("this is a null value", ArrayList<Token>())
    public init() {
    }

    public func register(name: String, grammar: Grammar): Unit {
        this.cache.add(name, grammar)
    }

    public func grammar(prism: Prism, language: String): ?Grammar {
        let name: String = this.realLanguageName(language)
        var grammar: ?Grammar = this.cache.get(name)
        match (grammar) {
            case Some(v: GrammarImpl) where refEq(v, NULL) => return None
            case Some(v) => return v
            case None =>
                grammar = this.obtainGrammar(prism, name)
                if (grammar.isNone()) {
                    this.cache.add(name, NULL)
                } else {
                    this.cache.add(name, grammar.getOrThrow())
                }
                this.triggerModify(prism, name)
                return grammar
        }
    }

    protected func realLanguageName(name: String): String {
        var out: String = ""
        match (name) {
            case "c++" => out = "cpp"
            case "js" | "typescript" | "ts" => out = "javascript"
            case "xml" => ()
            case "html" => ()
            case "mathml" => ()
            case "svg" => out = "markup"
            case "dotnet" | "c#" => out = "csharp"
            case "golang" => out = "go"
            case "jsonp" => out = "json"
            case "cj" => out = "cangjie"
            case "md" => out = "markdown"
            case "python3" | "py" | "py3" | "python ml" | "pythonml" | "pandas" | "pythondata" => out = "python"
            case "mysql" | "oracle" | "sqlserver" | "ms sql server" | "mssql" | "oraclesql" | "postgresql" | "pgsql" => out = "sql"
            case "css_extras" | "css-extras" => out = "css"
            case _ => out = name
        }
        return out
    }

    protected func obtainGrammar(prism: Prism, name: String): ?Grammar {
        var grammar: ?Grammar = None
        match (name) {
            case "brainfuck" => grammar = PrismBrainfuck.create()
            case "c" => grammar = PrismC.create(prism)
            case "clike" => grammar = PrismClike.create()
            case "clojure" => grammar = PrismClojure.create()
            case "cpp" => grammar = PrismCpp.create(prism)
            case "csharp" => grammar = PrismCsharp.create(prism)
            case "css" => grammar = PrismCss.create()
            case "css-extras" => grammar = PrismCssExtras.create(prism)
            case "dart" => grammar = PrismDart.create(prism)
            case "git" => grammar = PrismGit.create()
            case "go" => grammar = PrismGo.create(prism)
            case "groovy" => grammar = PrismGroovy.create(prism)
            case "java" => grammar = PrismJava.create(prism)
            case "javascript" => grammar = PrismJavascript.create(prism)
            case "json" => grammar = PrismJson.create()
            case "kotlin" => grammar = PrismKotlin.create(prism)
            case "latex" => grammar = PrismLatex.create()
            case "makefile" => grammar = PrismMakefile.create()
            case "markdown" => grammar = PrismMarkdown.create(prism)
            case "markup" => grammar = PrismMarkup.create()
            case "python" => grammar = PrismPython.create()
            case "scala" => grammar = PrismScala.create(prism)
            case "sql" => grammar = PrismSql.create()
            case "swift" => grammar = PrismSwift.create(prism)
            case "yaml" => grammar = PrismYaml.create()
            case "cangjie" => grammar = PrismCangjie.create(prism)
            case "rust" => grammar = PrismRust.create(prism)
            case _ => grammar = None
        }
        return grammar
    }

    protected func triggerModify(prism: Prism, name: String): Unit {
        match (name) {
            case "markup" =>
                prism.grammar("css")
                prism.grammar("javascript")
            case "css" => prism.grammar("css-extras")
            case _ => ()
        }
    }

    public func languages(): HashSet<String> {
        var set: HashSet<String> = HashSet<String>(27)
        set.add("brainfuck")
        set.add("c")
        set.add("clike")
        set.add("clojure")
        set.add("cpp")
        set.add("csharp")
        set.add("css")
        set.add("css-extras")
        set.add("dart")
        set.add("git")
        set.add("go")
        set.add("groovy")
        set.add("java")
        set.add("javascript")
        set.add("json")
        set.add("kotlin")
        set.add("latex")
        set.add("makefile")
        set.add("markdown")
        set.add("markup")
        set.add("python")
        set.add("scala")
        set.add("sql")
        set.add("swift")
        set.add("yaml")
        set.add("cangjie")
        set.add("rust")
        return set
    }
}
