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
public class TestC {
    var assertTag = false
    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("c")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("c")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("c")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("c")) {
                case Some(v) =>
                    let grammar: Grammar = GrammarUtils.clone(v)
                    assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test_Swift_03(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("c")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar = PrismC.create(prism)
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test04(): Unit {
        let regex: Regex = Regex(
            "(?:\\b0x[\\da-f]+|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:e[+-]?\\d+)?)[ful]*",
            RegexOption().ignoreCase()
        )
        let pattern: Pattern = Prism.pattern(regex, true)
        let pattern2: Pattern = Prism.pattern(regex, false)
        var str: String = pattern.toString()
        @Assert(pattern.lookbehind(),true)
        @Assert(pattern.greedy(),false)
        @Assert(pattern2.lookbehind(),false)
        let arrL: ArrayList<Pattern> = ArrayList<Pattern>([pattern, pattern2])
        let token: Token = Prism.token("C语言", arrL)
        str = token.name()
        @Assert(str,"C语言")
        str = token.toString()
        @Assert(str.contains("Token{id=0x"),true)
        @Assert(str.contains("name=\"C语言\",patterns=[Pattern{id=0x"),true)
    }

    @TestCase
    public func test05(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let regex2: Regex = Regex("hello")
        let pattern: Pattern = Prism.pattern(regex, true, true)
        let pattern2: Pattern = Prism.pattern(regex, false, false)
        let pattern3: Pattern = Prism.pattern(regex2, true, false)
        let pattern4: Pattern = Prism.pattern(regex, false, true)
        var str: String = pattern.toString()
        @Assert(str.contains("regex=\"(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)\",lookbehind=true,greedy=true"),true)
        @Assert(pattern.greedy(),true)
        @Assert(pattern3.greedy(),false)
        let arrL: ArrayList<Pattern> = ArrayList<Pattern>([pattern, pattern2, pattern3, pattern4])
        let token: Token = Prism.token("|C\"", arrL)
        str = token.name()
        @Assert(str,"|C\"")
        let arrL2: ArrayList<Pattern> = token.patterns()
        @Assert(arrL2.size,4)
        let pattern_r: Pattern = arrL2[2]
        str = pattern_r.toString()
        @Assert(str.contains("Pattern{id=0x"),true)
        @Assert(str.contains("regex=\"hello\",lookbehind=true"),true)
    }
}
