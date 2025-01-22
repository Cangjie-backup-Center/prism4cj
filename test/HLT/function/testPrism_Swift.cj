//3rd_party_lib:prism4cj/build/prism4cj
// dependence: testUtils.cj

import std.unittest.*
import std.unittest.AssertException
import std.unittest.testmacro.*
import std.fs.*
import std.collection.*
import prism4cj.prism.*
import prism4cj.languages.*
import prism4cj.GrammarLocatorGrammarUtils

@Test
public class TestSwift {
    var assertTag = false
    @TestCase
    public func test_Swift_01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("swift")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("swift")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test_Swift_02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("swift")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("swift")) {
                case Some(v) =>
                    let grammar: Grammar = GrammarUtils.extendGrammar(v, "test_swift", None)
                    assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test_Swift_03(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("swift")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        try {
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("SWifT")) {
                    case Some(v) =>
                        let grammar: Grammar = GrammarUtils.clone(v)
                        TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                    case None => throw NoneValueException("The name of grammar does not exist.")
                }
            }
        } catch (e: NoneValueException) {
            @Assert(e.message,"The name of grammar does not exist.")
        }
    }

    @TestCase
    public func test_Swift_04(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("swift")
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
    public func test_Swift_05(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("swift")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("&仓|颉\"$")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => throw NoneValueException("The name of grammar is non-standard or does not exist.")
                }
            }
        } catch (e: NoneValueException) {
            @Assert(e.message,"The name of grammar is non-standard or does not exist.")
        }
    }

    @TestCase
    public func test_Swift_06(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("")
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            var c: Case
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("swift")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }
            }
        } catch (e: FSException) {
            @Assert(e.message,"The file read Error.")
        }
    }

    @TestCase
    public func test_Swift_07(): Unit {
        try {
            let fileArr: Collection<FileInfo> = TestUtils.testFiles("sft")
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
    public func test_Swift_08(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("swift")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar = PrismSwift.create(prism)
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test_Swift_09(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("swift")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        try {
            for (file in fileArr) {
                c = TestUtils.readCase(file)
                match (prism.grammar("kotlin")) {
                    case Some(v) => TestUtils.assertCase(c, prism.tokenize(c.input, v))
                    case None => ()
                }
            }
        } catch (e: AssertException) {
            @Assert(e.toString(),"AssertException: Actual does not match expectations.")
        }
    }
}
