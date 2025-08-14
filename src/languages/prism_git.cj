/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism4cj.languages

public class PrismGit {
    public static func create(): Grammar {
        return GrammarImpl(
            "git",
            ArrayList<Token>([
                Prism.token("comment", Prism.pattern(Regex("^#${wildcard}*", RegexFlag.MultiLine))),
                Prism.token("deleted", Prism.pattern(Regex("^[-–]${wildcard}*", RegexFlag.MultiLine))),
                Prism.token("inserted", Prism.pattern(Regex("^\\+${wildcard}*", RegexFlag.MultiLine))),
                Prism.token(
                    "string",
                    Prism.pattern(Regex("(\"|')(?:\\\\.|(?!\\1)[^\\\\\\r\\n])*\\1", RegexFlag.MultiLine))
                ),
                Prism.token(
                    "command",
                    Prism.pattern(
                        Regex("^${wildcard}*\\$ git ${wildcard}*", RegexFlag.MultiLine),
                        false,
                        false,
                        None,
                        GrammarImpl(
                            "inside",
                            ArrayList<Token>([
                                Prism.token("parameter", Prism.pattern(Regex("\\s--?\\w+", RegexFlag.MultiLine)))
                            ])
                        )
                    )
                ),
                Prism.token("coord", Prism.pattern(Regex("^@@${wildcard}*?@@+", RegexFlag.MultiLine))),
                Prism.token("commit_sha1", Prism.pattern(Regex("^commit \\w{40}(?=\\s*$)", RegexFlag.MultiLine)))
            ])
        )
    }
}
