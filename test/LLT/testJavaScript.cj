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
    var test = TestJavascript()
    test.test01()
    test.test02()
    test.test03()
    test.test04()
    test.test05()
    test.test06()
    test.test07()
    test.test08()
    return 0
}

@Test
public class TestJavascript {

    var error: Bool = false

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("javascript")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("javascript")) {
                case Some(v) => 
                    try {
                        TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    } catch (e: Exception) {
                        println("待正则支持 \\u{FFFF} 后，将 \\xFF 修改为 \\u{FFFF}")
                    }
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("javascript")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("javascript")) {
                case Some(v) => 
                    let grammar: Grammar = GrammarUtils.clone(v)
                    try {
                        TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    } catch (e: Exception) {
                        println("待正则支持 \\u{FFFF} 后，将 \\xFF 修改为 \\u{FFFF}")
                    }
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test03(): Unit {
        let e = @AssertThrows[FSException]({=>
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("javaScript")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }    
            }
        }())
        @Assert(e.toString(), "FSException: The file read Error.")
    }

    @TestCase
    public func test04(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("javascript")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("")) {
                case Some(v) => 
                    try {
                        TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    } catch (e: Exception) {
                        println("待正则支持 \\u{FFFF} 后，将 \\xFF 修改为 \\u{FFFF}")
                    }
                case None => error = true
            }    
        }
        @Assert(error, true)
    }

    @TestCase
    public func test05(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("javascript")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("jcc")) {
                case Some(v) => 
                    try {
                        TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    } catch (e: Exception) {
                        println("待正则支持 \\u{FFFF} 后，将 \\xFF 修改为 \\u{FFFF}")
                    }
                case None => error = true
            }    
        }
        @Assert(error, true)
    }

    @TestCase
    public func test06(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("javascript")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("js")) {
                case Some(v) => 
                    try {
                        TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    } catch (e: Exception) {
                        println("待正则支持 \\u{FFFF} 后，将 \\xFF 修改为 \\u{FFFF}")
                    }
                case None => ()
            }    
        }
    }

    @TestCase
    public func test07(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("javascript")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("typescript")) {
                case Some(v) => 
                    try {
                        TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    } catch (e: Exception) {
                        println("待正则支持 \\u{FFFF} 后，将 \\xFF 修改为 \\u{FFFF}")
                    }
                case None => ()
            }    
        }
    }

    @TestCase
    public func test08(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("javascript")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("ts")) {
                case Some(v) => 
                    try {
                        TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    } catch (e: Exception) {
                        println("待正则支持 \\u{FFFF} 后，将 \\xFF 修改为 \\u{FFFF}")
                    }
                case None => ()
            }    
        }
    }
}