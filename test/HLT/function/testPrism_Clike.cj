//3rd_party_lib:prism4cj/build/prism4cj
// dependence: testUtils.cj

import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.regex.*
import std.collection.*
import prism4cj.prism.*
import prism4cj.languages.*
import prism4cj.GrammarLocatorGrammarUtils

@Test
public class TestClike {
    var tag: Int64 = 0
    var assertTag = false
    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("clike")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("clike")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("clike")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("clike")) {
                case Some(v) =>
                    let grammar: Grammar = GrammarUtils.clone(v)
                    assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test03(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("clike")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = GrammarUtils.clone(PrismClike.create())
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }
    @TestCase
    public func test04(): Unit {
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        match (prism.grammar("clike")) {
            case Some(v) =>
                let pattern: Pattern = Prism.pattern(regex, true, true, "alias_CJ", v)
                match (pattern.inside()) {
                    case Some(X) =>
                        @Assert(X.name(),"clike")
                        let tokens: ArrayList<Token> = X.tokens()
                        @Assert(tokens.size,9)
                        @Assert(tokens[0].name(),"comment")
                        @Assert(tokens[0].patterns()[0].lookbehind(),true)
                        @Assert(tokens[0].patterns()[0].alias(),None)
                        @Assert(tokens[0].patterns()[0].regex().string(),"(^|[^\\\\])\\/\\*[\\s\\S]*?(?:\\*\\/|$)")
                    case None => ()
                }
            case None => ()
        }
    }

    @TestCase
    public func test05(): Unit {
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        try {
            match (prism.grammar("json")) { // json不含inside语法
                case Some(v) =>
                    let pattern: Pattern = Prism.pattern(regex, true, true, "alias_CJ", v)
                    match (pattern.inside()) {
                        case Some(X) =>
                            ()
                            @Assert(X.name(),"json")
                            let tokens: ArrayList<Token> = X.tokens()
                            @Assert(tokens.size,7)
                            @Assert(tokens[0].name(),"property")
                            @Assert(tokens[0].patterns()[0].lookbehind(),false)
                            @Assert(tokens[0].patterns()[0].alias(),None)
                            @Assert(tokens[0].patterns()[0].regex().string(),"\"(?:\\\\.|[^\\\\\"\\r\\n])*\"(?=\\s*:)")
                        case None => throw NoneValueException("The name of grammar is non-standard or does not exist.")
                    }
                case None => ()
            }
        } catch (e: NoneValueException) {
            tag = 1
        }
    }

    @TestCase
    public func test06(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let grammar = GrammarImpl(
            "inside",
            ArrayList<Token>(Prism.token("punctuation", Prism.pattern(Regex("[.\\\\]"))))
        )
        try {
            let pattern: Pattern = Prism.pattern(regex, true, true, None, grammar)
            match (pattern.inside()) {
                case Some(X) =>
                    ()
                    @Assert(X.name(),"inside")
                    let tokens: ArrayList<Token> = X.tokens()
                    @Assert(tokens.size,1)
                    @Assert(tokens[0].name(),"punctuation")
                    @Assert(tokens[0].patterns()[0].lookbehind(),false)
                    @Assert(tokens[0].patterns()[0].alias(),None)
                    @Assert(tokens[0].patterns()[0].regex().string(),"[.\\\\]")
                case None => throw NoneValueException("The name of grammar is non-standard or does not exist.")
            }
        } catch (e: NoneValueException) {
            tag = 2
        }
    }

    @TestCase
    public func test07(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let grammar = GrammarImpl(
            "text_else",
            ArrayList<Token>(Prism.token("punctuation", Prism.pattern(Regex("[.\\\\]"))))
        )
        try {
            let pattern: Pattern = Prism.pattern(regex, true, true, None, grammar)
            match (pattern.inside()) {
                case Some(X) =>
                    ()
                    @Assert(X.name(),"text_else")
                    let tokens: ArrayList<Token> = X.tokens()
                    @Assert(tokens.size,1)
                    @Assert(tokens[0].name(),"punctuation")
                    @Assert(tokens[0].patterns()[0].lookbehind(),false)
                    @Assert(tokens[0].patterns()[0].alias(),None)
                    @Assert(tokens[0].patterns()[0].regex().string(),"[.\\\\]")
                case None => throw NoneValueException("The name of grammar is non-standard or does not exist.")
            }
        } catch (e: NoneValueException) {
            tag = 3
        }
        @Assert(tag , 0)
    }
}
