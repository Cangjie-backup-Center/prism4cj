/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package cangjie_tpc::prism4cj.languages

public class PrismScala {
    public static func create(prism: Prism): Grammar {
        let scala: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "java"),
            "scala",
            TokenFilterScalaImpl(),
            ArrayList<Token>([
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "<-|=>|\\b(?:abstract|case|catch|class|def|do|else|extends|final|finally|for|forSome|if|implicit|import|lazy|match|new|null|object|override|package|private|protected|return|sealed|self|super|this|throw|trait|try|type|val|var|while|with|yield)\\b"/*cjlint-ignore !G.CHK.04 */
                    ))
                ),
                Prism.token(
                    "string",
                    Prism.pattern(Regex("\"\"\"[\\s\\S]*?\"\"\""), false, true),/*cjlint-ignore !G.CHK.04 */
                    Prism.pattern(Regex("(\"|')(?:\\\\.|(?!\\1)[^\\\\\\r\\n])*\\1"), false, true)/*cjlint-ignore !G.CHK.04 */
                ),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                            "\\b0x[\\da-f]*\\.?[\\da-f]+|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:e\\d+)?[dfl]?",/*cjlint-ignore !G.CHK.04 */
                            RegexFlag.IgnoreCase
                        )
                    )
                )
            ])
        )

        scala.tokens().add(Prism.token("symbol", Prism.pattern(Regex("'[^\\d\\s\\\\]\\w*"))))/*cjlint-ignore !G.CHK.04 */

        GrammarUtils.insertBeforeToken(
            scala,
            "number",
            ArrayList<Token>([
                Prism.token(
                    "builtin",
                    Prism.pattern(
                        Regex(
                        "\\b(?:String|Int|Long|Short|Byte|Boolean|Double|Float|Char|Any|AnyRef|AnyVal|Unit|Nothing)\\b")/*cjlint-ignore !G.CHK.04 */
                    )
                )
            ])
        )

        return scala
    }
}

class TokenFilterScalaImpl <: TokenFilter {
    public override func test(token: Token): Bool {
        let name: String = token.name()
        return "class-name" != name && "function" != name
    }
}
