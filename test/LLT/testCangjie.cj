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
    var test = TestCangjie()
    test.test01()
    return 0
}

@Test
public class TestCangjie {

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("cangjie")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            let fileValueArr: Array<Byte> = file.readToEnd()
            let raw: String = String.fromUtf8(fileValueArr)
            match (prism.grammar("cangjie")) {
                case Some(v) => println(prism.tokenize(raw, v).toString())
                case None => ()
            }
            
        }
    }
}