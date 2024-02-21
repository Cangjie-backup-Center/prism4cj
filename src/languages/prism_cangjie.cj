/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package languages

public class PrismCangjie {
    public static func create(prism: Prism): Grammar {
        let cangjie: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "cangjie",
            TokenFilterKotlinImpl(),
            ArrayList<Token>(
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                            "(^|[^.])\\b(?:abstract|as|break|catch|class|const|constructor|continue|data|do|dynamic|else|enum|external|finally|for|fun|get|if|import|in|init|interface|is|null|object|open|operator|override|package|protected|public|return|set|super|this|throw|to|try|var|when|where|while)\\b"
                        ),
                        true
                    )
                ),
                Prism.token(
                    "function",
                    Prism.pattern(Regex("\\w+(?=\\s*\\()")),
                    Prism.pattern(Regex("(\\.)\\w+(?=\\s*\\{)"), true)
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                        "\\b(?:0[xX][\\da-fA-F]+(?:_[\\da-fA-F]+)*|0[bB][01]+(?:_[01]+)*|\\d+(?:_\\d+)*(?:\\.\\d+(?:_\\d+)*)?(?:[eE][+-]?\\d+(?:_\\d+)*)?[fFL]?)\\b"
                    ))
                ),
                Prism.token(
                    "operator",
                    Prism.pattern(
                        Regex(
                        "\\+[+=]?|-[-=>]?|==?=?|!(?:!|==?)?|[\\/*%<>]=?|[?:]:?|\\.\\.|&&|\\|\\||\\b(?:and|inv|or|shl|shr|ushr|xor)\\b"
                    ))
                )
            )
        )
        return cangjie
    }
}

class TokenFilterCangjieImpl <: TokenFilter {
    public override func test(token: Token): Bool {
        return "class-name" != token.name()
    }
}
