/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package languages

public class PrismRust {
public static func create(): Grammar {
        return GrammarImpl(
            "rust",
            ArrayList<Token>(
                Prism.token("number",
                    Prism.pattern(
                    Regex(
                    "\\b(?:0[xX][\\da-fA-F]+(?:_[\\da-fA-F]+)*|0[bB][01]+(?:_[01]+)*|\\d+(?:_\\d+)*(?:\\.\\d+(?:_\\d+)*)?(?:[eE][+-]?\\d+(?:_\\d+)*)?[fFL]?)\\b"
                ))),
                Prism.token("keyword",
                    Prism.pattern(
                        Regex(
                        "\\b(?:as|box|break|const|continue|create|dyn|else|enum|extern|fn|for|if|impl|in|let|loop|macro|match|mod|move|mut|pub|ref|return|Self|self|static|struct|super|trait|type|unsafe|use|where|while|yield|async|await|default|union|try)\\b"
                    ))
                ),
                Prism.token("boolean",
                    Prism.pattern(
                        Regex(
                        "\\b(?:true|false)\\b"
                        )
                    )
                ),
                Prism.token("comment", Prism.pattern(Regex("(^|[^\\\\])\\/\\*[\\s\\S]*?(?:\\*\\/|$)"), true), Prism.pattern(Regex("(^|[^\\\\:])\\/\\/.*"), true, true)),
                Prism.token("operator",
                    Prism.pattern(
                    Regex(
                    "\\{|\\}|\\[|\\]|\\(|\\)|::|:|\\.\\.\\.|\\.\\.=|\\.\\.|\\.|==|!=|\\|=|[\\^]=?|\\|\\||\\||&&|&=|&|*=|*|\\/=|\\/|%=|%|!|=>|=|+=|+|-=|->|-|#|<<=|<=|<<|<|>>=|>=|>>|>|?[?]|?|\\~|@|\\$|\\;|\\,|\\'|_"
                ))),
                Prism.token("string", Prism.pattern(Regex("(\"\"\"|''')[\\s\\S]*?\\1"), false, false, "string")),
                Prism.token("shebang", Prism.pattern(Regex("#![\\s]*[^\\[\\s]+"))),
                Prism.token(
                    "class-name",
                    Prism.pattern(Regex("(class\\s+)\\w+", RegexOption().ignoreCase()), true)
                )
            )
        )
    }
}
