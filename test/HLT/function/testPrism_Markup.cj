//3rd_party_lib:prism4cj/build/prism4cj
// dependence: testUtils.cj

from std import unittest.*
from std import unittest.testmacro.*
from std import fs.*
from std import regex.*
from std import collection.*
from prism4cj import prism.*
from prism4cj import languages.*
from prism4cj import prism4cj.GrammarLocatorGrammarUtils

@Test
public class TestMarkup {
    var assertTag = false
    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("markup")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("markup")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("markup")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("markup")) {
                case Some(v) =>
                    let grammar: Grammar = GrammarUtils.clone(v)
                    assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test03(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("markup")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = PrismMarkup.create()
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test04(): Unit {
        try {
            let fileArr: Collection<File> = TestUtils.testFiles("markup")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar(" ")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => throw NoneValueException("The name of grammar should not be empty.")
                }
            }
        } catch (e: NoneValueException) {
            @Assert(e.message,"The name of grammar should not be empty.")
        }
    }

    @TestCase
    public func test05(): Unit {
        try {
            let fileArr: Collection<File> = TestUtils.testFiles("markup")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            let grammarName: String = """
            mark\rup
"""
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar(grammarName)) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => throw NoneValueException("The name of grammar is non-standard or does not exist.")
                }
            }
        } catch (e: NoneValueException) {
            @Assert(e.message,"The name of grammar is non-standard or does not exist.")
        }
    }
}
