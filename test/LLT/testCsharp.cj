// EXEC: cjc %import-path %L %l %f testUtils.cj
// EXEC: ./main
// DEPENDENCE: testUtils.cj

import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.regex.*
import std.collection.*
import cangjie_tpc::prism4cj.prism.*
import cangjie_tpc::prism4cj.GrammarLocatorGrammarUtils

main(): Int64 {
    var test = TestCsharp()
    test.test01()
    test.test02()
    test.test03()
    test.test04()
    test.test05()
    test.test06()
    test.test07()
    test.test08()
    test.test09()
    return 0
}

@Test
public class TestCsharp {

    var error: Bool = false

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("csharp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("csharp")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
            
        }
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
                    TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test03(): Unit {
        error = true
        let e = @AssertThrows[FSException]({=>
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("csharp")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }    
            }
        }())
        @Assert(e.message.size > 0, true)
        @Assert(error, true)
    }

    @TestCase
    public func test04(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("csharp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => error = true
            }    
        }
        @Assert(error, true)
    }

    @TestCase
    public func test05(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("csharp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("cssp")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => error = true
            }    
        }
        @Assert(error, true)
    }

    public func test06(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        let pattern1: Pattern = Prism.pattern(Regex("\\w+(?=\\s*\\()"))
        let pattern2: Pattern = Prism.pattern(Regex("(\\.)\\w+(?=\\s*\\{)"), true)
        let pattern3: Pattern = Prism.pattern(Regex("hello"),true,false)
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
    public func test07(): Unit {
        let regex: Regex = Regex("(#\\s*include\\s*)(?:<.+?>|(\"|')(?:\\\\?.)+?\\2)")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        let ins:GrammarLocatorGrammarUtils = GrammarLocatorGrammarUtils()
        let grammar:Grammar = 
        match (ins.grammar(prism, "csharp")) {
            case Some(grammar) => grammar
            case None => GrammarImpl("None")
        }
        let pattern4: Pattern = Prism.pattern(regex,true,true,"alias_CJ")
        let pattern5: Pattern = Prism.pattern(regex, true, true, "alias_CJ", grammar)
        let pattern6: Pattern = PatternImpl(regex, true, true, "PatternImpl", grammar)
        var pattern_clone: Pattern = GrammarUtils.clone(pattern4)
        @Assert(pattern_clone == pattern4 ,false) 
        @Assert(pattern_clone.hashCode() , pattern4.hashCode())
        var pattern_clone2 = GrammarUtils.clone(pattern5)
        @Assert(pattern_clone2.alias().getOrThrow(),"alias_CJ")
        let inside:Grammar = pattern_clone2.inside().getOrThrow()
        @Assert(inside.name() , "csharp")
        println("inside > ${inside.toString()}")
        println("pattern_clone2 > ${pattern_clone2.toString()}")
        @Assert(pattern_clone2.hashCode() , pattern5.hashCode())
        @Assert(pattern_clone2 == pattern5 ,false)
        pattern_clone = GrammarUtils.clone(pattern6)
        @Assert(pattern_clone.alias().getOrThrow(),"PatternImpl")
        @Assert(pattern_clone.hashCode() , pattern6.hashCode())
        @Assert(pattern_clone != pattern6 ,true)
    }

    @TestCase
    public func test08(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("csharp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("dotnet")) {
                case Some(v) => 
                    let grammar: Grammar = GrammarUtils.clone(v)
                    TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test09(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("csharp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("c#")) {
                case Some(v) => 
                    let grammar: Grammar = GrammarUtils.clone(v)
                    TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                case None => ()
            }
            
        }
    }
}