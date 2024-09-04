//3rd_party_lib:prism4cj/build/prism4cj
// dependence: testUtils.cj

import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.regex.*
import std.collection.*
import prism4cj.prism.*
import prism4cj.languages.*
import prism4cj.GrammarLocatorGrammarUtils

@Test
public class TestJava {
    var assertTag = false
    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("java")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("java")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("java")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("java")) {
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
        let fileArr: Collection<File> = TestUtils.testFiles("java")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = PrismJava.create(prism)
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test04(): Unit {
        try {
            let fileArr: Collection<File> = TestUtils.testFiles("java")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("")) {
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
            let fileArr: Collection<File> = TestUtils.testFiles("java")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("&仓|颉$")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => throw NoneValueException("The name of grammar is non-standard or does not exist.")
                }
            }
        } catch (e: NoneValueException) {
            @Assert(e.message,"The name of grammar is non-standard or does not exist.")
        }
    }

    @TestCase
    public func test06(): Unit {
        try {
            let fileArr: Collection<File> = TestUtils.testFiles("")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("java")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }
            }
        } catch (e: FSException) {
            @Assert(e.message,"Failed to open the file. Is a directory")
        }
    }

    @TestCase
    public func test07(): Unit {
        try {
            let fileArr: Collection<File> = TestUtils.testFiles("JAv")
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
            @Assert(e.message.contains("The path"),true)
            @Assert(e.message.contains("does not exist"),true)
        }
    }

    @TestCase
    public func test08(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("java")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        try {
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                let grammar = PrismBrainfuck.create()
                TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
            }
        } catch (e: AssertException) {
            @Assert(e.toString(),"AssertException: Actual does not match expectations.")
        }
    }
}
