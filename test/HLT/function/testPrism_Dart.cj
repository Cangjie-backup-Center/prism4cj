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
public class TestDart {
    var assertTag = false
    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("dart")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("dart")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("dart")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("dart")) {
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
        let fileArr: Collection<File> = TestUtils.testFiles("dart")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = PrismDart.create(prism)
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test04(): Unit {
        let grammar: Grammar = GrammarImpl("dart")
        let pattern1: Pattern = Prism.pattern(Regex("\\w+(?=\\s*\\()"))
        let pattern2: Pattern = Prism.pattern(Regex("(\\.)\\w+(?=\\s*\\{)"), true)
        let pattern3: Pattern = Prism.pattern(Regex("hello"), true, false)
        let arrL: Array<Pattern> = [pattern1, pattern2]
        let token: Token = Prism.token("Token_presonal", arrL)
        let arrL2: Array<Pattern> = [pattern1, pattern3]
        let token2: Token = Prism.token("Token_presonal", arrL2)
        let tokens: ArrayList<Token> = ArrayList<Token>([token, token2])
        let grammar2: Grammar = GrammarImpl("GrammarImpl", tokens)

        var grammar_clone: Grammar = GrammarUtils.clone(grammar)
        @Assert(grammar_clone.toString().contains("name=\"dart\",tokens=[]"),true)
        @Assert(grammar_clone.name(),"dart")
        @Assert(grammar_clone == grammar ,false)
        @Assert(grammar_clone.hashCode() , grammar.hashCode())
        var tokens_r: ArrayList<Token> = grammar_clone.tokens()
        @Assert(tokens_r.size,0)
        grammar_clone = GrammarUtils.clone(grammar2)
        @Assert(grammar_clone.name(),"GrammarImpl")
        @Assert(grammar_clone != grammar2 ,true)
        @Assert(grammar_clone.hashCode() , grammar2.hashCode())
        tokens_r = grammar_clone.tokens()
        @Assert(tokens_r.size,2)
        @Assert(tokens_r[1].toString().contains("regex=\"hello\",lookbehind=true"),true)
    }

    @TestCase
    public func test05(): Unit {
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        let cpp_personal: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "cpp_personal",
            ArrayList<Token>(
                Prism.token(
                    "personal",
                    Prism.pattern(Regex("\\w+(?=\\s*\\()")),
                    Prism.pattern(Regex("(\\.)\\w+(?=\\s*\\{)"), true),
                    Prism.pattern(Regex("hello"), true, false, "cpp_personal")
                )
            )
        )
        var grammar_clone: Grammar = GrammarUtils.clone(cpp_personal)
        @Assert(grammar_clone.name(),"cpp_personal")
        @Assert(grammar_clone == cpp_personal ,false)
        @Assert(grammar_clone.hashCode() , cpp_personal.hashCode())
    }
}
