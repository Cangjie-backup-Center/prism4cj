/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package cangjie_tpc::prism4cj.languages

public class PrismRust {
    public static func create(prism: Prism): Grammar {
        let rust: Grammar = GrammarUtils.extendGrammar(
            GrammarUtils.require(prism, "cpp"),
            "rust",
            ArrayList<Token>([
                Prism.token("number",
                    Prism.pattern(
                    Regex(
                    "\\b(?:0[xX][\\da-fA-F]+(?:_[\\da-fA-F]+)*|0[bB][01]+(?:_[01]+)*|\\d+(?:_\\d+)*(?:\\.\\d+(?:_\\d+)*)?(?:[eE][+-]?\\d+(?:_\\d+)*)?[fFL]?)\\b"/*cjlint-ignore !G.CHK.04 */
                ))),
                Prism.token("keyword",
                    Prism.pattern(
                        Regex(
                        "\\b(?:as|box|break|const|continue|create|dyn|else|enum|extern|fn|for|if|impl|in|let|loop|macro|match|mod|move|mut|pub|ref|return|Self|self|static|struct|super|trait|type|unsafe|use|where|while|yield|async|await|default|union|try|u8|i8|u16|i16|u32|i32|u64|i64|u128|i128|usize|isize|f32|f64)\\b"/*cjlint-ignore !G.CHK.04 */
                    ))
                ),
                Prism.token("boolean",
                    Prism.pattern(
                        Regex(
                        "\\b(?:true|false)\\b"/*cjlint-ignore !G.CHK.04 */
                        )
                    )
                ),
                Prism.token("class-name",
                    Prism.pattern(Regex("(?<=impl\\s)\\w+")),/*cjlint-ignore !G.CHK.04 */
                    Prism.pattern(Regex("println!")),/*cjlint-ignore !G.CHK.04 */
                    Prism.pattern(Regex("assert_eq!")),/*cjlint-ignore !G.CHK.04 */
                ),
                Prism.token("operator",
                    Prism.pattern(
                    Regex(
                    "\\{|\\}|\\[|\\]|\\(|\\)|::|:|\\.\\.\\.|\\.\\.=|\\.\\.|\\.|==|!=|\\|=|[\\^]=?|\\|\\||\\||&&|&=|&|\\*=|\\*|\\/=|\\/|%=|!|%|=>|=|\\+=|\\+|-=|->|-|#|<<=|<=|<<|<|>>=|>=|>>|>|\\?[?]|\\?|~|@|\\$|;|,|_'"/*cjlint-ignore !G.CHK.04 */
                ))),
                Prism.token("shebang", Prism.pattern(Regex("#![\\s]*[^\\[\\s]+")))/*cjlint-ignore !G.CHK.04 */
            ])
        )
        return rust
    }
}