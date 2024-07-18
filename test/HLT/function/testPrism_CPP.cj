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
public class TestCPP {
    var tag: Int64 = -1
    var assertTag = false

    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("cpp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("cpp")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("cpp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("cpp")) {
                case Some(v) =>
                    let grammar: Grammar = GrammarUtils.clone(v)
                    assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    var prism: Prism = Prism(GrammarLocatorGrammarUtils())
    let cpp_personal: Grammar = GrammarUtils.extendGrammar(
        GrammarUtils.require(prism, "clike"),
        "cpp_personal",
        TokenFilter_cpp_personalImpl(),
        ArrayList<Token>(
            Prism.token(
                "function",
                Prism.pattern(Regex("\\w+(?=\\s*\\()")),
                Prism.pattern(Regex("(\\.)\\w+(?=\\s*\\{)"), true)
            ),
            Prism.token(
                "token_test",
                Prism.pattern(
                    Regex(
                    "\\+[+=]?|-[-=>]?|==?=?|!(?:!|==?)?|[\\/*%<>]=?|[?:]:?|\\.\\.|&&|\\|\\||\\b(?:and|inv|or|shl|shr|ushr|xor)\\b"
                ))
            )
        )
    )

    @TestCase
    public func test03(): Unit {
        GrammarUtils.insertBeforeToken(cpp_personal, "text",
            ArrayList<Token>(Prism.token("test", Prism.pattern(Regex("(\"\"\"|''')[\\s\\S]*?\\1"), false, false, "text")
        )))

        try {
            match (GrammarUtils.findToken(cpp_personal, "FUNCTION")) {
                case Some(token) => ()
                case None => throw NoneValueException("The path 'FUNCTION' has no matched token.")
            }
        } catch (e: NoneValueException) {
            @Assert(e.toString(),"NoneValueException: The path 'FUNCTION' has no matched token.")
            tag = 0
        }
        @Assert(tag,0)

        try {
            match (GrammarUtils.findToken(cpp_personal, "function")) {
                case Some(token) =>
                    @Assert(token.name(),"function")
                    @Assert(token.toString().contains("Token{id=0x"),true)
                    @Assert(token.toString().contains("regex=\"(\\.)\\w+(?=\\s*\\{)\",lookbehind=true"),true)
                case None => throw NoneValueException("The path 'function' has no matched token.")
            }
        } catch (e: NoneValueException) {
            tag = 1
        }
        @Assert(tag,0)
    }

    @TestCase
    public func test04(): Unit {
        GrammarUtils.insertBeforeToken(
            cpp_personal,
            "string",
            ArrayList<Token>(
                Prism.token(
                    "atrule",
                    Prism.pattern(
                        Regex("@[\\w-]+?.*?(?:;|(?=\\s*\\{))", RegexOption().ignoreCase()),
                        false,
                        false,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(Prism.token("rule", Prism.pattern(Regex("@[\\w-]+"))))
                        )
                    )
                )
            )
        )

        var token = match (GrammarUtils.findToken(cpp_personal, "function")) {
            case Some(v) => v
            case None => TokenImpl("None", ArrayList<Pattern>())
        }
        @Assert(token.toString().contains("name=\"function\",patterns=[Pattern{id=0x"),true)
        @Assert(token.toString().contains("regex=\"(\\.)\\w+(?=\\s*\\{)\",lookbehind=true"),true)
        try {
            match (GrammarUtils.findFirstInsideGrammar(token)) {
                case Some(grammar) => ()
                case None => throw NoneValueException("The token 'token' has no matched inside grammar.")
            }
        } catch (e: NoneValueException) {
            @Assert(e.toString(),"NoneValueException: The token 'token' has no matched inside grammar.")
            tag = 0
        }
        @Assert(tag,0)

        let token2 = match (GrammarUtils.findToken(cpp_personal, "atrule")) {
            case Some(t2) => t2
            case None => TokenImpl("None", ArrayList<Pattern>())
        }
        @Assert(token2.toString().contains("name=\"atrule\",patterns=[Pattern{id=0x"),true)
        @Assert(token2.toString().contains("regex=\"@[\\w-]+?.*?(?:;|(?=\\s*\\{))\",alias=\"None\",inside=Grammar{id=0x"),true)
        try {
            match (GrammarUtils.findFirstInsideGrammar(token2)) {
                case Some(grammar) =>
                    @Assert(grammar.name(),"inside")
                    @Assert(grammar.toString().contains("name=\"rule\",patterns=[Pattern{id=0x"),true)
                case None => throw NoneValueException("The token 'token2' has no matched inside grammar.")
            }
        } catch (e: NoneValueException) {
            tag = 2
        }

        @Assert(tag,0)
    }

    @TestCase
    public func test05(): Unit {
        GrammarUtils.insertBeforeToken(
            cpp_personal,
            "string",
            ArrayList<Token>(
                Prism.token(
                    "atrule",
                    Prism.pattern(
                        Regex("@[\\w-]+?.*?(?:;|(?=\\s*\\{))", RegexOption().ignoreCase()),
                        false,
                        false,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(Prism.token("rule", Prism.pattern(Regex("@[\\w-]+"))))
                        )
                    )
                )
            )
        )

        var token = match (GrammarUtils.findToken(cpp_personal, "token_test")) {
            case Some(v) => v
            case None => TokenImpl("None", ArrayList<Pattern>())
        }
        @Assert(token.toString().contains("name=\"None\",patterns=[]"),true)

        let token2 = match (GrammarUtils.findToken(cpp_personal, "atrule/rule")) {
            case Some(t2) => t2
            case None => TokenImpl("None", ArrayList<Pattern>())
        }
        @Assert(token2.toString().contains("name=\"rule\",patterns=[Pattern{id=0x"),true)
        @Assert(token2.toString().contains("regex=\"@[\\w-]+\""),true)
        try {
            match (GrammarUtils.findFirstInsideGrammar(token2)) {
                case Some(grammar) => ()
                case None => throw NoneValueException("The token 'token2' has no matched inside grammar.")
            }
        } catch (e: NoneValueException) {
            @Assert(e.toString(),"NoneValueException: The token 'token2' has no matched inside grammar.")
            tag = 0
        }

        @Assert(tag,0)
    }

    @TestCase
    public func test06(): Unit {
        let fileArr: Collection<File> = TestUtils.testFiles("cpp")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = PrismCpp.create(prism)
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }
}

class TokenFilter_cpp_personalImpl <: TokenFilter {
    public override func test(token: Token): Bool {
        return "class-name" != token.name()
    }
}
