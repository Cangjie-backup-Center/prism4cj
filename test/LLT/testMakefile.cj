// EXEC: cjc %import-path %L %l %f testUtils.cj
// EXEC: ./main
// DEPENDENCE: testUtils.cj

import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.collection.*
import cangjie_tpc::prism4cj.prism.*
import cangjie_tpc::prism4cj.GrammarLocatorGrammarUtils

main(): Int64 {
    var test = TestMakefile()
    test.test01()
    test.test02()
    test.test03()
    test.test04()
    test.test05()
    return 0
}

@Test
public class TestMakefile {

    var error: Bool = false

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("makefile")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("makefile")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("makefile")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("makefile")) {
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
                match (prism.grammar("makefile")) {
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
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("makefile")
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
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("makefile")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("make")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => error = true
            }    
        }
        @Assert(error, true)
    }
}