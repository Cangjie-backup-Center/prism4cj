/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism4cj.languages

public class PrismYaml {
    public static func create(): Grammar {
        return GrammarImpl(
            "yaml",
            ArrayList<Token>([
                Prism.token("scalar",
                    Prism.pattern(
                    Regex(
                    "([\\-:]\\s*(?:![^\\s]+)?[ \\t]*[|>])[ \\t]*(?:((?:\\r?\\n|\\r)[ \\t]+)${wildcard}+(?:\\2${wildcard}+)*)"
                ), true, false, "string")),
                Prism.token("comment", Prism.pattern(Regex("#${wildcard}*"))),
                Prism.token("key",
                    Prism.pattern(
                    Regex(
                    "(\\s*(?:^|[:\\-,\\[{\\r\\n?])[ \\t]*(?:![^\\s]+)?[ \\t]*)[^\\r\\n{\\[\\]},#\\s]+?(?=\\s*:\\s)"),
                    true, false, "atrule")),
                Prism.token("directive",
                    Prism.pattern(Regex("(^[ \\t]*)%${wildcard}+", RegexFlag.MultiLine), true, false, "important")),
                Prism.token("datetime",
                    Prism.pattern(
                    Regex(
                    "([:\\-,\\[{]\\s*(?:![^\\s]+)?[ \\t]*)(?:\\d{4}-\\d\\d?-\\d\\d?(?:[tT]|[ \\t]+)\\d\\d?:\\d{2}:\\d{2}(?:\\.\\d*)?[ \\t]*(?:Z|[-+]\\d\\d?(?::\\d{2})?)?|\\d{4}-\\d{2}-\\d{2}|\\d\\d?:\\d{2}(?::\\d{2}(?:\\.\\d*)?)?)(?=[ \\t]*(?=\\s*$|,|]|\\}))",
                    RegexFlag.MultiLine), true, false, "number")),
                Prism.token("boolean",
                    Prism.pattern(
                    Regex("([:\\-,\\[{]\\s*(?:![^\\s]+)?[ \\t]*)(?:true|false)[ \\t]*(?=\\s*$|,|]|\\})",
                    [RegexFlag.MultiLine, RegexFlag.IgnoreCase]), true, false, "important")),
                Prism.token("null",
                    Prism.pattern(
                    Regex("([:\\-,\\[{]\\s*(?:![^\\s]+)?[ \\t]*)(?:null|~)[ \\t]*(?=\\s*$|,|]|\\})",
                    [RegexFlag.MultiLine, RegexFlag.IgnoreCase]), true, false, "important")),
                Prism.token("string",
                    Prism.pattern(
                    Regex(
                    "([:\\-,\\[{]\\s*(?:![^\\s]+)?[ \\t]*)(\"|')(?:(?!\\2)[^\\\\\\r\\n]|\\\\.)*\\2(?=[ \\t]*(?=\\s*$|,|]|\\}))",
                    RegexFlag.MultiLine), true, true)),
                Prism.token("number",
                    Prism.pattern(
                    Regex(
                    "([:\\-,\\[{]\\s*(?:![^\\s]+)?[ \\t]*)[+-]?(?:0x[\\da-f]+|0o[0-7]+|(?:\\d+\\.?\\d*|\\.?\\d+)(?:e[+-]?\\d+)?|\\.inf|\\.nan)[ \\t]*(?=\\s*$|,|]|\\})",
                    [RegexFlag.MultiLine, RegexFlag.IgnoreCase]), true)),
                Prism.token("tag", Prism.pattern(Regex("![^\\s]+"))),
                Prism.token("important", Prism.pattern(Regex("[&*][\\w]+"))),
                Prism.token("punctuation", Prism.pattern(Regex("---|[:\\[\\]{}\\-,|>?]|\\.\\.\\.")))
            ])
        )
    }
}