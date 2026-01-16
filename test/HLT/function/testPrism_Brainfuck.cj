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
public class TestBrainfuck {
    var assertTag = false
    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("brainfuck")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("brainfuck")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("brainfuck")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = GrammarUtils.clone(PrismBrainfuck.create())
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test03(): Unit {
        let regex: Regex = Regex(
            "(?:\\b0x[\\da-f]+|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:e[+-]?\\d+)?)[ful]*",
            RegexOption().ignoreCase()
        )
        let pattern: Pattern = Prism.pattern(regex)
        var str: String = pattern.toString()
        @Assert(str.contains("regex=\"(?:\\b0x[\\da-f]+|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:e[+-]?\\d+)?)[ful]*\",alias=\"None\"}"),true)
        str = pattern.regex().string()
        @Assert(str,"(?:\\b0x[\\da-f]+|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:e[+-]?\\d+)?)[ful]*")
        let arrL: ArrayList<Pattern> = ArrayList<Pattern>([pattern, GrammarUtils.clone(pattern)])
        let token: Token = Prism.token("brainfuck", arrL)
        str = token.name()
        @Assert(str,"brainfuck")
        str = token.toString()
        @Assert(str.contains("Token{id=0x"),true)
        @Assert(str.contains("name=\"brainfuck\",patterns=[Pattern{id=0x"),true)
    }

    @TestCase
    public func test04(): Unit {
        let regex: Regex = Regex(
            "你好啊！",
            RegexOption().ignoreCase()
        )
        let regex2: Regex = Regex(
            "",
            RegexOption().ignoreCase()
        )
        let pattern: Pattern = Prism.pattern(regex)
        let pattern2: Pattern = Prism.pattern(regex2)
        var str: String = pattern.toString()
        @Assert(str.contains(",regex=\"你好啊！\",alias=\"None\"}"),true)
        str = pattern.regex().string()
        @Assert(str,"你好啊！")
        str = pattern2.regex().string()
        @Assert(str,"")
        let arrL: ArrayList<Pattern> = ArrayList<Pattern>([pattern, pattern2])
        let token: Token = Prism.token("BRAINFUCK", arrL)
        str = token.name()
        @Assert(str,"BRAINFUCK")
        str = token.toString()
        @Assert(str.contains("Token{id=0x"),true)
        @Assert(str.contains("name=\"BRAINFUCK\",patterns=[Pattern{id=0x"),true)
    }

    @TestCase
    public func test05(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let pattern: Pattern = Prism.pattern(regex)
        var str = pattern.regex().string()
        @Assert(str,"(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let arrL: ArrayList<Pattern> = ArrayList<Pattern>()
        let token: Token = Prism.token("语法不存在", arrL)
        str = token.name()
        @Assert(str,"语法不存在")
        str = token.toString()
        @Assert(str.contains("Token{id=0x"),true)
        @Assert(str.contains("name=\"语法不存在\",patterns=[]}"),true)
    }

    @TestCase
    public func test06(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let pattern: Pattern = Prism.pattern(regex)
        var str = pattern.regex().string()
        @Assert(str,"(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let arrL: ArrayList<Pattern> = ArrayList<Pattern>()
        let token: Token = Prism.token("", arrL)
        str = token.name()
        @Assert(str,"")
        str = token.toString()
        @Assert(str.contains("Token{id=0x"),true)
        @Assert(str.contains("name=\"\",patterns=[]}"),true)
    }
}
