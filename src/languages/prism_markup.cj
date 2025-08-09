/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism4cj.languages

public abstract class PrismMarkup {
    public static func create(): Grammar {
        let entity: Token = Prism.token("entity", Prism.pattern(Regex("&#?[\\da-z]{1,8};", RegexFlag.IgnoreCase)));
        return GrammarImpl(
            "markup",
            ArrayList<Token>([
                Prism.token("comment", Prism.pattern(Regex("<!--[\\s\\S]*?-->"))),
                Prism.token("prolog", Prism.pattern(Regex("<\\?[\\s\\S]+?\\?>"))),
                Prism.token("doctype", Prism.pattern(Regex("<!DOCTYPE[\\s\\S]+?>", RegexFlag.IgnoreCase))),
                Prism.token("cdata", Prism.pattern(Regex("<!\\[CDATA\\[[\\s\\S]*?]]>", RegexFlag.IgnoreCase))),
                Prism.token(
                    "tag",
                    Prism.pattern(
                        Regex(
                            "<\\/?(?!\\d)[^\\s>\\/=$<%]+(?:\\s+[^\\s>\\/=]+(?:=(?:(\"|')(?:\\\\[\\s\\S]|(?!\\1)[^\\\\])*\\1|[^\\s'\">=]+))?)*\\s*\\/?>",
                            RegexFlag.IgnoreCase
                        ),
                        false,
                        true,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>([
                                Prism.token(
                                    "tag",
                                    Prism.pattern(
                                        Regex("^<\\/?[^\\s>\\/]+", RegexFlag.IgnoreCase),
                                        false,
                                        false,
                                        None,
                                        GrammarImpl(
                                            "inside",
                                            ArrayList<Token>([
                                                Prism.token("punctuation", Prism.pattern(Regex("^<\\/?"))),
                                                Prism.token("namespace", Prism.pattern(Regex("^[^\\s>\\/:]+:")))
                                        ])
                                        )
                                    )
                                ),
                                Prism.token(
                                    "attr-value",
                                    Prism.pattern(
                                        Regex(
                                            "=(?:(\"|')(?:\\\\[\\s\\S]|(?!\\1)[^\\\\])*\\1|[^\\s'\">=]+)",
                                            RegexFlag.IgnoreCase
                                        ),
                                        false,
                                        false,
                                        None,
                                        GrammarImpl(
                                            "inside",
                                            ArrayList<Token>([
                                                Prism.token(
                                                    "punctuation",
                                                    Prism.pattern(Regex("^=")),
                                                    Prism.pattern(Regex("(^|[^\\\\])[\"']"), true)
                                                ),
                                                entity
                                            ])
                                        )
                                    )
                                ),
                                Prism.token("punctuation", Prism.pattern(Regex("\\/?>"))),
                                Prism.token(
                                    "attr-name",
                                    Prism.pattern(
                                        Regex("[^\\s>\\/]+"),
                                        false,
                                        false,
                                        None,
                                        GrammarImpl(
                                            "inside",
                                            ArrayList<Token>([
                                                Prism.token("namespace", Prism.pattern(Regex("^[^\\s>\\/:]+:")))])
                                        )
                                    )
                                )
                            ])
                        )
                    )
                ),
                entity
            ])
        )
    }

    private init() {
    }
}
