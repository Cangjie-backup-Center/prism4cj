/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism

/**
 * Basic class to locate grammars
 *
 * @see prism#prism(GrammarLocator)
 */
public interface GrammarLocator {
    func grammar(prism: Prism, language: String): ?Grammar

    /**
     * @return collection of languages included into this locator
     * @since 1.1.0
     */
    func languages(): HashSet<String>
}
