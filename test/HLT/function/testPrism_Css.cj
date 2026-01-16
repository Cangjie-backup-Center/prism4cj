//3rd_party_lib:prism4cj/build/prism4cj
// dependence: testUtils.cj

import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.regex.*
import std.collection.*
import cangjie_tpc::prism4cj.prism.*
import cangjie_tpc::prism4cj.languages.*
import cangjie_tpc::prism4cj.GrammarLocatorGrammarUtils

@Test
public class TestCss {
    var assertTag = false

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("css")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("css")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("css")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("css")) {
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
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("css")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = PrismCss.create()
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test04(): Unit {
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        let cpp_personal: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "cpp_personal",
            ArrayList<Token>([
                Prism.token(
                    "function",
                    Prism.pattern(Regex("\\w+(?=\\s*\\()")),
                    Prism.pattern(Regex("(\\.)\\w+(?=\\s*\\{)"), true)
                )
            ])
        )
        var token = match (GrammarUtils.findToken(cpp_personal, "function")) {
            case Some(v) => v
            case None => TokenImpl("None", ArrayList<Pattern>())
        }
        @Assert(token.toString().contains("name=\"function\",patterns=[Pattern{id=0x"),true)
        @Assert(token.toString().contains("regex=\"(\\.)\\w+(?=\\s*\\{)\",lookbehind=true"),true)
        var token_clone: Token = GrammarUtils.clone(token)
        @Assert(token_clone.toString().contains("name=\"function\",patterns=[Pattern{id=0x"),true)
        @Assert(token_clone.toString().contains("regex=\"(\\.)\\w+(?=\\s*\\{)\",lookbehind=true"),true)
        @Assert(token_clone.name(),"function")
        @Assert(token_clone == token ,false)
        @Assert(token_clone != token ,true)
        @Assert(token_clone.hashCode() , token.hashCode())
    }

    @TestCase
    public func test05(): Unit {
        let ins: GrammarLocatorGrammarUtils = GrammarLocatorGrammarUtils()
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let regex2: Regex = Regex("\\w+(?=\\s*\\()")
        var prism: Prism = Prism(ins)
        let grammar: Grammar = match (ins.grammar(prism, "css")) {  // swift 存在前后语法不对等，会有异常
            case Some(grammar) => grammar
            case None => GrammarImpl("None")
        }
        let pattern4: Pattern = Prism.pattern(regex, true, true, " ")
        let pattern5: Pattern = PatternImpl(regex2, true, false, "pattern_personal", grammar)
        let arrL: Array<Pattern> = [pattern4, pattern5]
        let token: Token = Prism.token("Token_presonal", arrL)
        var token_clone: Token = GrammarUtils.clone(token)
        @Assert(token_clone.name(),"Token_presonal")
        @Assert(token_clone != token ,true)
        @Assert(token_clone.hashCode() , token.hashCode())
        @Assert(token_clone.toString().contains("name=\"Token_presonal\",patterns=[Pattern{id=0x"),true)
    }

    @TestCase
    public func test06(): Unit {
        let ins: GrammarLocatorGrammarUtils = GrammarLocatorGrammarUtils()
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let regex2: Regex = Regex("\\w+(?=\\s*\\()")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        let grammar: Grammar = match (ins.grammar(prism, "swift")) {
            case Some(grammar) => grammar
            case None => GrammarImpl("None")
        }
        let pattern4: Pattern = Prism.pattern(regex, true, true, " ")
        let pattern5: Pattern = PatternImpl(regex2, true, false, "pattern_personal", grammar)
        let arrL: ArrayList<Pattern> = ArrayList<Pattern>([pattern4, pattern5])
        let token: Token = TokenImpl("TokenImpl", arrL)
        var token_clone: Token = GrammarUtils.clone(token)
        @Assert(token_clone.name(),"TokenImpl")
        @Assert(token_clone != token ,true)
        @Assert(token_clone.hashCode() , token.hashCode())
        try {
            token_clone.toString() //不满足使用约束
        } catch (err: OutOfMemoryError) {
            @Assert(err.toString(),"OutOfMemoryError")
        }
    }

    @TestCase
    public func test07(): Unit {
        assertTag = false
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("css")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (PrismCssExtras.create(prism)) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,false)
    }
}
