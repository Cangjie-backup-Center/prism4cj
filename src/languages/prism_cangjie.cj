/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism4cj.languages

public class PrismCangjie {
    public static func create(prism: Prism): Grammar {
        let cangjie: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "clike"),
            "cangjie",
            ArrayList<Token>(
                Prism.token("keyword",
                    Prism.pattern(
                    Regex(
                    "(^|[^.])\\b(?:let|var|abstract|break|case|catch|class|const|continue|do|else|enum|extends|finally|for|if|implements|import|interface|package|private|protected|public|static|super|synchronized|this|throw|try|while|return|when|func|type|init|is|as|in|match|from|where|spawn|macro|quote|foreign|prop|mut|unsafe|struct|operator|overide|redef|open|sealed)\\b"
                ), true)),
                Prism.token("number",
                    Prism.pattern(
                    Regex(
                    "\\b(?:0[xX][\\da-fA-F]+(?:_[\\da-fA-F]+)*|0[bB][01]+(?:_[01]+)*|\\d+(?:_\\d+)*(?:\\.\\d+(?:_\\d+)*)?(?:[eE][+-]?\\d+(?:_\\d+)*)?[fFL]?)\\b"
                ))),
                Prism.token("class-name",
                    Prism.pattern(Regex("\\b(?:Bool|Char|Int8|Int16|Int32|Int64|UInt8|UInt16|UInt32|UInt64|Float16|Float32|Float64|String|IntNative|UIntNative|Nothing|Unit|Varray|InOut|true|false)\\b")),
                    Prism.pattern(Regex("(?<=class\\s)\\w+")),
                    Prism.pattern(Regex("(?<=enum\\s)\\w+")),
                    Prism.pattern(Regex("(?<=struct\\s)\\w+"))
                ),
                Prism.token(
                    "string",
                    Prism.pattern(Regex("(?<!#)#+\"([^\"]*(\\\\.[^\"]*)*)\"#+(?!#)|(?<!#)#+\"{3}([^\"]*(\\\\.[^\"]*)*)\"{3}#+(?!#)|\\\"([^\\\"\\\\]*(\\\\.[^\\\"\\\\]*)*)\\\"|\\\"{3}([^\\\"\\\\]*(\\\\.[^\\\"\\\\]*)*)\\\"{3}")),
                ),
                Prism.token("operator",
                    Prism.pattern(
                    Regex(
                    "==?=?|!(?:!|==?)?|\\|\\||\\+[+=>]?|-[-=>]?|<<=|<=|<<|<|>>=|>=|>>|>|&[&=>]?|**=|*=|[\\/]=?|\\|\\|=|\\|=|[\\^]=?|[%]=?|\\(|\\)|\\}|\\[|\\]|\\,|\\.\\.\\.|\\.\\.=|\\.\\.|\\.|\\~>|\\~|:|*[*]?|\\$|\\;|@|?[?]|?|}|{"
                ))),
                Prism.token("comment", Prism.pattern(Regex("(^|[^\\\\])\\/\\*[\\s\\S]*?(?:\\*\\/|$)"), true),
                    Prism.pattern(Regex("(^|[^\\\\:])\\/\\/.*"), true, true)),
                Prism.token("escape_seq", Prism.pattern(Regex("(^|[^.])\\b(?:escapeSeq)\\b"))),
                Prism.token(
                    "builtin",
                    Prism.pattern(Regex("(\$\\{[^}]*\\})"), false, true)
                ),
            )
        )
        return cangjie
    }
}
