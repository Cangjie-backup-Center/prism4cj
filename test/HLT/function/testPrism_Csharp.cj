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
public class TestCsharp {
    var assertTag = false
    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("csharp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("csharp")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("csharp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("csharp")) {
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
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("csharp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = PrismCsharp.create(prism)
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test04(): Unit {
        let pattern1: Pattern = Prism.pattern(Regex("\\w+(?=\\s*\\()"))
        let pattern2: Pattern = Prism.pattern(Regex("(\\.)\\w+(?=\\s*\\{)"), true)
        let pattern3: Pattern = Prism.pattern(Regex("hello"), true, false)
        var pattern_clone: Pattern = GrammarUtils.clone(pattern1)
        @Assert(pattern_clone.toString().contains("regex=\"\\w+(?=\\s*\\()\""),true)
        @Assert(pattern_clone == pattern1 ,false) //比对的是两对象的内存地址
        @Assert(pattern_clone.hashCode() , pattern1.hashCode())
        pattern_clone = GrammarUtils.clone(pattern2)
        @Assert(pattern_clone != pattern1 ,true)
        @Assert(pattern_clone.lookbehind() ,true)
        @Assert(pattern_clone.hashCode() != pattern1.hashCode(), true)
        pattern_clone = GrammarUtils.clone(pattern3)
        @Assert(pattern_clone.greedy() ,false)
        @Assert(pattern1 == pattern3 ,false)
        @Assert(pattern2.hashCode() == pattern3.hashCode() ,false)
    }

    @TestCase
    public func test05(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        let ins: GrammarLocatorGrammarUtils = GrammarLocatorGrammarUtils()
        let grammar: Grammar = match (ins.grammar(prism, "swift")) {
            case Some(grammar) => grammar
            case None => GrammarImpl("None")
        }
        let pattern4: Pattern = Prism.pattern(regex, true, true, "alias_CJ")
        let pattern5: Pattern = Prism.pattern(regex, true, true, "alias_CJ", grammar)
        let pattern6: Pattern = PatternImpl(regex, true, true, "PatternImpl", grammar)

        var pattern_clone: Pattern = GrammarUtils.clone(pattern4)
        @Assert(pattern_clone.toString().contains("lookbehind=true,greedy=true,alias=\"alias_CJ\""),true)  
        @Assert(pattern_clone == pattern4 ,false)
        @Assert(pattern_clone.hashCode() , pattern4.hashCode())
        var pattern_clone2 = GrammarUtils.clone(pattern5)
        @Assert(pattern_clone2.alias().getOrThrow(),"alias_CJ")
        let inside: Grammar = pattern_clone2.inside().getOrThrow()
        @Assert(inside.name() , "swift")
        try {
            /* 仓颉侧在实现 grammar_locator 语法加载器时默认将本库支持的所有语法对象都 create 建好，对标库实现逻辑是即用即创，
            所以在使用本库时，使用哪种语法就读哪种语法，语法出现不对前后不对等的情况下可能出现 None 值或别的异常 */
            inside.toString() 
        } catch (err: OutOfMemoryError) {
            @Assert(err.toString(),"OutOfMemoryError")
        }
        @Assert(pattern_clone2.hashCode() , pattern5.hashCode())
        @Assert(pattern_clone2 == pattern5 ,false)
        pattern_clone = GrammarUtils.clone(pattern6)
        @Assert(pattern_clone.alias().getOrThrow(),"PatternImpl")
        @Assert(pattern_clone.hashCode() , pattern6.hashCode())
        @Assert(pattern_clone != pattern6 ,true)

        let languages: HashSet<String> = ins.languages()
        var language_str: String = ""
        for (language in languages) {
            language_str += "${language}>"
        }
        @Assert(languages.size,27)
        @Assert(language_str,"brainfuck>c>clike>clojure>cpp>csharp>css>css-extras>dart>git>go>groovy>java>javascript>json>kotlin>latex>makefile>markdown>markup>python>scala>sql>swift>yaml>cangjie>rust>")
    }
}
