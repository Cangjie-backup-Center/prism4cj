// EXEC: cjc %import-path %L %l %f testUtils.cj
// EXEC: ./main
// DEPENDENCE: testUtils.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import fs.*
from std import collection.*
from prism4cj import prism.*
from prism4cj import prism4cj.GrammarLocatorGrammarUtils

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
        let fileArr: Collection<File> = TestUtils.testFiles("rust")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            let fileValueArr: Array<Byte> = file.readToEnd()
            let raw: String = String.fromUtf8(fileValueArr)
            match (prism.grammar("rust")) {
                case Some(v) => println(prism.tokenize(raw, v).toString())
                // case Some(v) => prism.tokenize(raw, v)
                case None => ()
            }
            
        }
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("rust")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            let fileValueArr: Array<Byte> = file.readToEnd()
            let raw: String = String.fromUtf8(fileValueArr)
            match (prism.grammar("Rust")) {
                case Some(v) => println(prism.tokenize(raw, v).toString())
                case None => ()
            }
            
        }
    }
}