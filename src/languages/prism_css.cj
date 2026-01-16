/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package cangjie_tpc::prism4cj.languages

public abstract class PrismCss {

    // before a language is requested (fro example css)
    // it won't be initialized (so we won't modify markup to highlight css) before it was requested...
    public static func create(): Grammar {
        let grammar: Grammar = GrammarImpl(
            "css",
            ArrayList<Token>([
                Prism.token("comment", Prism.pattern(Regex("\\/\\*[\\s\\S]*?\\*\\/"))),
                Prism.token(
                    "atrule",
                    Prism.pattern(
                        Regex("@[\\w-]+?.*?(?:;|(?=\\s*\\{))", RegexFlag.IgnoreCase),
                        false,
                        false,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>([Prism.token("rule", Prism.pattern(Regex("@[\\w-]+")))])
                        )
                    )
                ),
                Prism.token(
                    "url",
                    Prism.pattern(
                        Regex(
                            "url\\((?:([\"'])(?:\\\\(?:\\r\\n|[\\s\\S])|(?!\\1)[^\\\\\\r\\n])*\\1|.*?)\\)",/*cjlint-ignore !G.CHK.04 */
                            RegexFlag.IgnoreCase
                        )
                    )
                ),
                Prism.token("selector", Prism.pattern(Regex("[^{}\\s][^{};]*?(?=\\s*\\{)"))),
                Prism.token(
                    "string",
                    Prism.pattern(Regex("(\"|')(?:\\\\(?:\\r\\n|[\\s\\S])|(?!\\1)[^\\\\\\r\\n])*\\1"), false, true)
                ),
                Prism.token(
                    "property",
                    Prism.pattern(Regex("[-_a-z\\p{L}][-\\w\\p{L}]*(?=\\s*:)", [RegexFlag.IgnoreCase, RegexFlag.Unicode]))
                ),
                Prism.token("important", Prism.pattern(Regex("\\B!important\\b", RegexFlag.IgnoreCase))),
                Prism.token("function", Prism.pattern(Regex("[-a-z0-9]+(?=\\()", RegexFlag.IgnoreCase))),
                Prism.token("punctuation", Prism.pattern(Regex("[(){};:]")))
            ])
        )

        let atrule: Token = grammar.tokens()[1]
        let inside: ?Grammar = GrammarUtils.findFirstInsideGrammar(atrule)
        if (let Some(v) <- inside) {
            for (i in 0..grammar.tokens().size) {
                if ("atrule" != grammar.tokens()[i].name()) {
                    v.tokens().add(grammar.tokens()[i])
                }
            }
        }

        let markup: ?Grammar = GrammarImpl("markup")
        if (let Some(v) <- markup) {
            GrammarUtils.insertBeforeToken(
                v,
                "tag",
                ArrayList<Token>([
                    Prism.token(
                        "style",
                        ArrayList<Pattern>([
                            Prism.pattern(
                                Regex("(<style[\\s\\S]*?>)[\\s\\S]*?(?=<\\/style>)", RegexFlag.IgnoreCase),
                                true,
                                true,
                                "language-css",
                                grammar
                            )
                        ])
                    )
                ])
            )

            // important thing here is to clone found grammar
            // otherwise we will have stackoverflow (inside tag references style-attr, which
            // references inside tag, etc)
            var markupTagInside: ?Grammar
            var _temp: ?Grammar = None
            let token: ?Token = GrammarUtils.findToken(v, "tag")
            if (let Some(m) <- token) {
                _temp = GrammarUtils.findFirstInsideGrammar(m)
                if (let Some(k) <- _temp) {
                    _temp = GrammarUtils.clone(k)
                }
            }
            markupTagInside = _temp

            GrammarUtils.insertBeforeToken(
                v,
                "tag/attr-value",
                ArrayList<Token>([
                    Prism.token(
                        "style-attr",
                        Prism.pattern(
                            Regex("\\s*style=(\"|')(?:\\\\[\\s\\S]|(?!\\1)[^\\\\])*\\1", RegexFlag.IgnoreCase),
                            false,
                            false,
                            "language-css",
                            GrammarImpl(
                                "inside",
                                ArrayList<Token>([
                                    Prism.token(
                                        "attr-name",
                                        Prism.pattern(Regex("^\\s*style", RegexFlag.IgnoreCase), false, false,
                                            None, markupTagInside)
                                    ),
                                    Prism.token("punctuation", Prism.pattern(Regex("^\\s*=\\s*['\"]|['\"]\\s*$"))),
                                    Prism.token(
                                        "attr-value",
                                        Prism.pattern(
                                            Regex(".+", RegexFlag.IgnoreCase),
                                            false,
                                            false,
                                            None,
                                            grammar
                                        )
                                    )
                                ])
                            )
                        )
                    )
                ])
            )
        }
        return grammar
    }
    private init() {}
}
