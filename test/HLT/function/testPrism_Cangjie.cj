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
public class TestCangjie {
    var assertTag = false
    @TestCase
    public func test01(): Unit {

        let fileArr: Collection<FileInfo> = TestUtils.testFiles("cangjie")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("cangjie")) {
                case Some(v) => ()
                assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        assertTag = false
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("cangjie")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("cangjie")) {
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
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("cangjie")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }
            }
        } catch (e: FSException) {
            @Assert(e.message,"The file read Error.")
        }
    }

    @TestCase
    public func test04(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("cangjie")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => throw NoneValueException("The name of grammar should not be empty.")
                }
            }
        } catch (e: NoneValueException) {
            @Assert(e.message,"The name of grammar should not be empty.")
        }
    }

    @TestCase
    public func test05(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("cangjie")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = GrammarUtils.clone(PrismCangjie.create(prism))
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test06(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let regex2: Regex = Regex("hello")
        let pattern: Pattern = Prism.pattern(regex, true, true, "alias_CJ")
        let pattern2: Pattern = Prism.pattern(regex, false, false, None)
        let pattern3: Pattern = Prism.pattern(regex2, true, false, "")
        let pattern4: Pattern = Prism.pattern(regex, false, true, "$<仓颉>")
        var str: String = pattern4.toString()
        @Assert(str.contains("regex=\"(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)\",greedy=true,alias=\"$<仓颉>\""),true)
        @Assert(pattern.greedy(),true)
        @Assert(pattern.greedy(),true)
        @Assert(pattern.alias().getOrThrow(),"alias_CJ")
        @Assert(pattern2.alias(),None)
        @Assert(pattern3.alias(),"")
        @Assert(pattern3.greedy(),false)
        let arrL: Array<Pattern> = [pattern, pattern2, pattern3, pattern4]
        let token: Token = Prism.token("|cangjie\"", arrL)
        str = token.name()
        @Assert(str,"|cangjie\"")
        let arrL2: ArrayList<Pattern> = token.patterns()
        @Assert(arrL2.size,4)
        let pattern_r: Pattern = arrL2[2]
        str = pattern_r.toString()
        @Assert(str.contains("Pattern{id=0x"),true)
        @Assert(str.contains("regex=\"hello\",lookbehind=true,alias=\"\""),true)
    }

    @TestCase
    public func test07(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let regex2: Regex = Regex("hello")
        let pattern3: Pattern = Prism.pattern(regex2, true, false, "")
        let pattern4: Pattern = Prism.pattern(regex, false, true, "$<仓颉>")
        var str: String = pattern4.toString()
        @Assert(str.contains("regex=\"(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)\",greedy=true,alias=\"$<仓颉>\""),true)
        @Assert(pattern3.alias(),"")
        @Assert(pattern3.greedy(),false)
        let token: Token = Prism.token("|cangjie\"")
        str = token.name()
        @Assert(str,"|cangjie\"")
        str = token.toString()
        @Assert(str.contains("Token{id=0x"),true)
        @Assert(str.contains("name=\"|cangjie\"\",patterns=[]"),true)
        let arrL2: ArrayList<Pattern> = token.patterns()
        @Assert(arrL2.size,0)
    }

    @TestCase
    public func test08(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        let regex2: Regex = Regex("hello")
        let pattern3: Pattern = Prism.pattern(regex2, true, false, "")
        let pattern4: Pattern = Prism.pattern(regex, false, true, "$<仓颉>")
        var str: String = pattern4.toString()
        @Assert(str.contains("regex=\"(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)\",greedy=true,alias=\"$<仓颉>\""),true)
        @Assert(pattern3.alias(),"")
        @Assert(pattern3.greedy(),false)
        let arrL: Array<Pattern> = Array<Pattern>()
        let token: Token = Prism.token("|cangjie\"", arrL)
        str = token.name()
        @Assert(str,"|cangjie\"")
        str = token.toString()
        @Assert(str.contains("Token{id=0x"),true)
        @Assert(str.contains("name=\"|cangjie\"\",patterns=[]"),true)
        let arrL2: ArrayList<Pattern> = token.patterns()
        @Assert(arrL2.size,0)
    }
}
