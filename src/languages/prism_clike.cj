/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package languages

from std import collection.ArrayList
from std import regex.Regex
from std import regex.RegexOption
from prism4cj import prism.Grammar
from prism4cj import prism.GrammarImpl
from prism4cj import prism.Prism
from prism4cj import prism.Token
from prism4cj import prism.Pattern
from prism4cj import prism.GrammarUtils
from prism4cj import prism.TokenFilter

public abstract class PrismClike {
    public static func create(): Grammar {
        return GrammarImpl(
            "clike",
            ArrayList<Token>(
                Prism.token(
                    "comment",
                    Prism.pattern(Regex("(^|[^\\\\])\\/\\*[\\s\\S]*?(?:\\*\\/|$)"), true),
                    Prism.pattern(Regex("(^|[^\\\\:])\\/\\/.*"), true, true)
                ),
                Prism.token(
                    "string",
                    Prism.pattern(Regex("([\"'])(?:\\\\(?:\\r\\n|[\\s\\S])|(?!\\1)[^\\\\\\r\\n])*\\1"), false, true)
                ),
                Prism.token(
                    "class-name",
                    Prism.pattern(
                        Regex(
                            "((?:\\b(?:class|interface|extends|implements|trait|instanceof|new)\\s+)|(?:catch\\s+\\())[\\w.\\\\]+"
                        ),
                        true,
                        false,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>(Prism.token("punctuation", Prism.pattern(Regex("[.\\\\]"))))
                        )
                    )
                ),
                Prism.token(
                    "keyword",
                    Prism.pattern(
                        Regex(
                        "\\b(?:if|else|while|do|for|return|in|instanceof|function|new|try|throw|catch|finally|null|break|continue)\\b"
                    ))
                ),
                Prism.token("boolean", Prism.pattern(Regex("\\b(?:true|false)\\b"))),
                Prism.token("function", Prism.pattern(Regex("[a-z0-9_]+(?=\\()", RegexOption().ignoreCase()))),
                Prism.token(
                    "number",
                    Prism.pattern(
                        Regex(
                            "\\b0x[\\da-f]+\\b|(?:\\b\\d+\\.?\\d*|\\B\\.\\d+)(?:e[+-]?\\d+)?",
                            RegexOption().ignoreCase()
                        )
                    )
                ),
                Prism.token(
                    "operator",
                    Prism.pattern(Regex("--?|\\+\\+?|!=?=?|<=?|>=?|==?=?|&&?|\\|\\|?|\\?|\\*|\\/|~|\\^|%"))
                ),
                Prism.token("punctuation", Prism.pattern(Regex("[{}\\[\\];(),.:]")))
            )
        )
    }

    private init() {
    }
}
