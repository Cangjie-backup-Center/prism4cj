/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism4cj.prism

/**
 * Basic structure that represents parsing state
 *
 * @see Text
 * @see Syntax
 */
public interface Node <: ToString {

    /**
     * @return raw text length. For {@link Text} node it\'s {@link Text#literal()} length
     * and for {@link Syntax} it is {@link Syntax#matchedString()} length
     */
    func textLength(): Int64

    /**
     * As we have only two types maybe doing a lot of `instanceof` checks is not that required
     *
     * @return a boolean indicating if this node is an instance of {@link Syntax}
     */
    func isSyntax(): Bool
}

public interface Syntax <: Node & ToString {
    func syntaxType(): String

    func children(): ArrayList<Node>

    func alias(): ?String

    func matchedString(): String

    func greedy(): Bool

    /**
     * The main aim for this flag is to be able to properly construct simplified
     * array of tokens during tests. If it\'s set to true, then children will be
     * inside another array. Otherwise they will be _flattened_ into the same array
     * as token type information
     *
     * @return a flag indicating if children of this node were tokenized
     */
    func tokenized(): Bool
}

public class SyntaxImpl <: Syntax {
    var sType: String
    var syntaxChildren: ArrayList<Node>
    var syntaxAlias: ?String
    var syntaxMatchedString: String
    var syntaxGreedy: Bool
    var syntaxTokenized: Bool

    public init(
        syntaxType: String,
        children: ArrayList<Node>,
        alias: ?String,
        matchedString: String,
        greedy: Bool,
        tokenized: Bool
    ) {
        this.sType = syntaxType
        this.syntaxChildren = children
        this.syntaxAlias = alias
        this.syntaxMatchedString = matchedString
        this.syntaxGreedy = greedy
        this.syntaxTokenized = tokenized
    }

    public override func textLength(): Int64 {
        return syntaxMatchedString.size
    }

    public override func isSyntax(): Bool {
        return true
    }

    public func syntaxType(): String {
        return sType
    }

    public override func children(): ArrayList<Node> {
        return syntaxChildren
    }

    public override func alias(): ?String {
        return syntaxAlias
    }

    public override func matchedString(): String {
        return syntaxMatchedString
    }

    public override func greedy(): Bool {
        return syntaxGreedy
    }

    public override func tokenized(): Bool {
        return syntaxTokenized
    }

    public override func toString(): String {
        if (let Some(v) <- syntaxAlias) {
            return "SyntaxImpl{" + 
                "type='" + sType + "\'" +
                ", children=" + syntaxChildren.toString() + 
                ", alias='" + v + "\'" +
                ", matchedString='" + syntaxMatchedString + "\'" +
                ", greedy=" + syntaxGreedy.toString() + 
                ", tokenized=" + syntaxTokenized.toString() + 
                "}"
        }
        return "SyntaxImpl{" + 
            "type='" + sType + "\'" +
            ", children=" + syntaxChildren.toString() + 
            ", alias='" + "None" + "\'" +
            ", matchedString='" + syntaxMatchedString + "\'" +
            ", greedy=" + syntaxGreedy.toString() + 
            ", tokenized=" + syntaxTokenized.toString() + 
            "}"
    }
}

public interface Text <: Node {
    func literal(): String
}

public class TextImpl <: Text {
    var textLiteral: String

    public init(literal: String) {
        this.textLiteral = literal
    }

    public override func textLength(): Int64 {
        return textLiteral.size
    }

    public override func isSyntax(): Bool {
        return false
    }

    public override func literal(): String {
        return textLiteral
    }

    public override func toString(): String {
        return "TextImpl{" + "literal='" + textLiteral + "\'" + "}"
    }
}
