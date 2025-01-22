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
    var test = TestCangjie()
    test.test01()
    test.test02()
    return 0
}

@Test
public class TestCangjie {

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("cangjie")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            let fileValueArr: Array<Byte> = File.readFrom(file.path)
            let raw: String = String.fromUtf8(fileValueArr)
            match (prism.grammar("cangjie")) {
                case Some(v) => println(prism.tokenize(raw, v).toString())
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("cangjie")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            let fileValueArr: Array<Byte> = File.readFrom(file.path)
            let raw: String = String.fromUtf8(fileValueArr)
            match (prism.grammar("cj")) {
                case Some(v) => println(prism.tokenize(raw, v).toString())
                case None => ()
            }
            
        }
    }
}