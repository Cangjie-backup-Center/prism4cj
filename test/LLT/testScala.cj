// EXEC: cjc %import-path %L %l %f testUtils.cj
// EXEC: ./main
// DEPENDENCE: testUtils.cj

import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.collection.*
import prism4cj.prism.*
import prism4cj.GrammarLocatorGrammarUtils

main(): Int64 {
    var test = TestScala()
    test.test01()
    test.test02()
    test.test03()
    test.test04()
    test.test05()
    return 0
}

@Test
public class TestScala {

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("scala")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("scala")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("scala")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("scala")) {
                case Some(v) => 
                    let grammar: Grammar = GrammarUtils.clone(v)
                    TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test03(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("")
                var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("scala")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }    
            }
        } catch (e: FSException) {
            println("测试文件读取有误...")   
        }
    }

    @TestCase
    public func test04(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("scala")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }    
            }
        } catch (e: FSException) {
            println("测试文件读取有误...")   
        }
    }

    @TestCase
    public func test05(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("sca")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }    
            }
        } catch (e: FSException) {
            println("测试文件读取有误...")   
        }
    }
}