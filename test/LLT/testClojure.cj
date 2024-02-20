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
    var test = TestClojure()
    test.test01()
    return 0
}

@Test
public class TestClojure {

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("clojure")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("clojure")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
            
        }
    }

}