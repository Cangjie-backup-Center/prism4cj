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
    var test = TestCss()
    test.test01()
    test.test02()
    return 0
}

@Test
public class TestCss {

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("css!+css-extras")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("css_extras")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("css!+css-extras")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("css-extras")) {
                case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
    }
}