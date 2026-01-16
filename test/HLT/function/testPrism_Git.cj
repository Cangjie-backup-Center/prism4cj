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
public class TestGit {
    var assertTag = false
    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("git")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("git")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("git")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("git")) {
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
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("git")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = PrismGit.create()
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test04(): Unit {
        let pattern1: Pattern = Prism.pattern(Regex("\\w+(?=\\s*\\()"))
        let pattern2: Pattern = Prism.pattern(Regex("(\\.)\\w+(?=\\s*\\{)"), true)
        let pattern3: Pattern = Prism.pattern(Regex("hello"), true, false)
        let hashkey_pattern1: MyHashKey<Pattern> = MyHashKey<Pattern>(pattern1)
        let hashkey_pattern3: MyHashKey<Pattern> = MyHashKey<Pattern>(pattern3)
        @Assert(hashkey_pattern1.hashCode() != hashkey_pattern3.hashCode())
        @Assert(hashkey_pattern1 != hashkey_pattern3 ,true)
        @Assert(hashkey_pattern1 == hashkey_pattern3 ,false)
        let ins: GrammarLocatorGrammarUtils = GrammarLocatorGrammarUtils()
        let arrL: Array<Pattern> = [pattern1, pattern2]
        let token: Token = Prism.token("Token_presonal_1", arrL)
        let arrL2: Array<Pattern> = [pattern1, pattern3]
        let token2: Token = Prism.token("Token_presonal_2", arrL2)
        let tokens: ArrayList<Token> = ArrayList<Token>([token, token2])
        let grammar2: Grammar = GrammarImpl("GrammarImpl", tokens)
        ins.register("presonal", grammar2)
        let token_find: Token = match (GrammarUtils.findToken(grammar2, "Token_presonal_1")) {
            case Some(V) => V
            case None => TokenImpl("None", ArrayList<Pattern>())
        }
        @Assert(token_find.toString().contains("Token{id=0x"),true)
        @Assert(token_find.toString().contains("regex=\"(\\.)\\w+(?=\\s*\\{)\",lookbehind=true"),true)
    }
}
