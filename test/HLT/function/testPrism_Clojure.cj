//3rd_party_lib:prism4cj/build/prism4cj
// dependence: testUtils.cj

import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.regex.*
import std.collection.*
import cangjie_tpc::prism4cj.prism.*
import cangjie_tpc::prism4cj.languages.*
import cangjie_tpc::prism4cj.GrammarLocatorGrammarUtils

@Test
public class TestClojure {
    var assertTag = false
    @TestCase
    public func test01(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("clojure")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("clojure")) {
                case Some(v) => assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, v))
                case None => ()
            }
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test02(): Unit {
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("clojure")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            match (prism.grammar("clojure")) {
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
        let fileArr: Collection<FileInfo> = TestUtils.testFiles("clojure")
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var c: Case
        for (file in fileArr) {
            c = TestUtils.readCase(file)
            let grammar: Grammar = PrismClojure.create()
            assertTag = TestUtils.assertCase(c, prism.tokenize(c.input, grammar))
        }
        @Assert(assertTag,true)
    }

    @TestCase
    public func test04(): Unit {
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        let text: String = "[[\"comment\",\";; this is comment\"],[\"comment\",\"; this is another comment\"]]"
        let ins: MyAbsVisitor = MyAbsVisitor()
        match (prism.grammar("clojure")) {
            case Some(v) =>
                let nodes = prism.tokenize(text, v) // :ArrayList<Text>
                let syntax: SyntaxImpl = (nodes[2] as SyntaxImpl).getOrThrow()
                @Assert(nodes.size,6)
                @Assert(syntax.isSyntax(),true)
                @Assert(syntax.toString().contains("alias='None', matchedString='\"comment\"', greedy=false, tokenized=false"),true)
                @Assert(syntax.textLength(),9)
                @Assert(syntax.syntaxType(),"string")
                @Assert(syntax.greedy(),false)
                @Assert(syntax.tokenized(),false)
                ins.visit(nodes)
                @Assert(ins.syntax,", punctuation, punctuation, string, punctuation, comment")

                let textimpl: TextImpl = TextImpl("syntax.syntaxType()")
                let arrL: ArrayList<Node> = ArrayList<Node>([textimpl])
                let syntaximpl: SyntaxImpl = SyntaxImpl(syntax.syntaxType(), arrL, " ", "[\\s\\S]*", false, true)
                @Assert(syntaximpl.tokenized(),true)
                @Assert(syntaximpl.alias()," ")
                @Assert(syntaximpl.matchedString(),"[\\s\\S]*")
                let texts = syntaximpl.children()
                @Assert(texts.size,1)
                let text: TextImpl = (texts[0] as TextImpl).getOrThrow()
                @Assert(texts.toString(),"[TextImpl{literal='syntax.syntaxType()'}]")
                @Assert(text.isSyntax(),false)
                @Assert(text.textLength(),19)
                @Assert(text.literal(),"syntax.syntaxType()")
                @Assert(text.toString(),"TextImpl{literal='syntax.syntaxType()'}")
            case None => ()
        }
    }
}

public class MyAbsVisitor <: AbsVisitor {
    var syntaxType: String = ""
    public override func visit(nodes: ArrayList<Node>): Unit {
        for (i in 0..nodes.size) {
            if (nodes[i].isSyntax()) {
                syntaxType += ", ${(nodes[i] as SyntaxImpl).getOrThrow().syntaxType()}"
            }
        }
    }

    public prop syntax: String {
        get() {
            syntaxType
        }
    }

    public override func visitText(_: Text): Unit {
    }

    public override func visitSyntax(_: Syntax): Unit {
    }
}
