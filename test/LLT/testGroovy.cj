// EXEC: cjc %import-path %L %l %f testUtils.cj
// EXEC: ./main
// DEPENDENCE: testUtils.cj

import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.collection.*
import std.regex.*
import prism4cj.prism.*
import prism4cj.GrammarLocatorGrammarUtils

main(): Int64 {
    var test = TestGroovy()
    test.test01()
    test.test02()
    test.test03()
    test.test04()
    test.test05()
    test.test06()
    test.test07()
    return 0
}

@Test
public class TestGroovy {

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("groovy")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("groovy")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("groovy")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("groovy")) {
                case Some(v) => 
                    let grammar: Grammar = GrammarUtils.clone(v)
                    TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test03(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("")
                var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("groovy")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }    
            }
        } catch (e: FSException) {
            println("测试文件读取有误...")   
        }
    }

    @TestCase
    public func test04(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("groovy")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }    
            }
        } catch (e: FSException) {
            println("测试文件读取有误...")   
        }
    }

    @TestCase
    public func test05(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("gogogo")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }    
            }
        } catch (e: FSException) {
            println("测试文件读取有误...")   
        }
    }

    @TestCase
    public func test06(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("groovy")
        let mv: MyVisitor = MyVisitor()
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("groovy")) {
                case Some(v) => 
                    let nodes: ArrayList<Node> = prism.tokenize(c.input, v)
                    mv.visit(nodes)
                case None => ()
            }       
        }
    }

    @TestCase
    public func test07(): Unit {
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        let glgu: GrammarLocatorGrammarUtils = GrammarLocatorGrammarUtils()
        glgu.languages()
        let cpp_personal: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "cpp_personal",
            ArrayList<Token>([
                Prism.token(
                    "function",
                    Prism.pattern(Regex("\\w+(?=\\s*\\()")),
                    Prism.pattern(Regex("(\\.)\\w+(?=\\s*\\{)"), true)
                ),
                Prism.token(
                    "atrule",
                    Prism.pattern(
                        Regex("@[\\w-]+?.*?(?:;|(?=\\s*\\{))", RegexOption().ignoreCase()),
                        false,
                        false,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>([Prism.token("rule", Prism.pattern(Regex("@[\\w-]+")))])
                        )
                    )
                )
            ])
        )

        GrammarUtils.insertBeforeToken(cpp_personal, "text",
            ArrayList<Token>([Prism.token("test", Prism.pattern(Regex("(\"\"\"|''')[\\s\\S]*?\\1"), false, false, "text")
        )]))
        glgu.register("hellocpp", cpp_personal)
        var token = match (GrammarUtils.findToken(cpp_personal, "function")) {
            case Some(v) => v
            case None => TokenImpl("None",ArrayList<Pattern>())
        }
        @Assert(token.toString().contains("name=\"function\",patterns=[Pattern{id=0x"),true)
        @Assert(token.toString().contains("regex=\"(\\.)\\w+(?=\\s*\\{)\",lookbehind=true"),true)
        try {
            match (GrammarUtils.findFirstInsideGrammar(token)) {
                case Some(grammar) => ()
                println("grammar > ${grammar.name()}")
                println("grammar > ${grammar.tokens()}")
                case None => throw NoneValueException("The token 'token' has no matched inside grammar.")
            }
        } catch (e: NoneValueException) {
            println("e41 > ${e.toString()}")
            @Assert(e.toString(),"NoneValueException: The token 'token' has no matched inside grammar.")
        }

        let token2 = match (GrammarUtils.findToken(cpp_personal, "atrule")) {
            case Some(t2) => t2
            case None => TokenImpl("None",ArrayList<Pattern>())
        }
        println("token42 > ${token2.toString()}")
        // @Assert(token2.toString().contains("name=\"atrule\",patterns=[Pattern{id=0x"),true)
        // @Assert(token.toString().contains("regex=\"(\\.)\\w+(?=\\s*\\{)\",lookbehind=true"),true)
        try {
            match (GrammarUtils.findFirstInsideGrammar(token2)) {
                case Some(grammar) => ()
                println("grammar > ${grammar.name()}")
                println("grammar > ${grammar.tokens()}")
                case None => throw NoneValueException("The token 'token2' has no matched inside grammar.")
            }
        } catch (e: NoneValueException) {
            println("e42 > ${e.toString()}")
        }
    }
}

public class MyVisitor <: AbsVisitor {

    protected func visitSyntax(x: Syntax): Unit {}

    protected func visitText(text: Text): Unit {}

    public func Myvisit(nodes: ArrayList<Node>): Unit {
        super.visit(nodes)
    }
}