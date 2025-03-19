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
    var test = TestRust()
    test.test01()
    test.test02()
    return 0
}

@Test
public class TestRust {

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("rust")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            let fileValueArr: Array<Byte> = File.readFrom(file.path)
            let raw: String = String.fromUtf8(fileValueArr)
            match (prism.grammar("rust")) {
                case Some(v) => 
                    let arr = prism.tokenize(raw, v)
                    @Assert(arr.size > 0, true)
                case None => ()
            }
        }
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("rust")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            let fileValueArr: Array<Byte> = File.readFrom(file.path)
            let raw: String = String.fromUtf8(fileValueArr)
            match (prism.grammar("Rust")) {
                case Some(v) => 
                    let arr = prism.tokenize(raw, v)
                    @Assert(arr.size > 0, true)
                case None => ()
            }
        }
    }
}