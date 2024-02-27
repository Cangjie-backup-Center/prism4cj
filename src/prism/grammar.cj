/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism

public abstract class Grammar <: Hashable & Equatable<Grammar> & ToString {
    public func name(): String

    // should mention that returned array is mutable
    public func tokens(): ArrayList<Token>
}

public class GrammarImpl <: Grammar {
    var GrammarName: String
    var GrammarTokens: ArrayList<Token> = ArrayList<Token>()

    public init(name: String) {
        this.GrammarName = name
    }

    public init(name: String, tokens: ArrayList<Token>) {
        this.GrammarName = name
        this.GrammarTokens = tokens
    }

    public override func name(): String {
        return GrammarName
    }

    public override func tokens(): ArrayList<Token> {
        return GrammarTokens
    }

    public operator func ==(other: Grammar): Bool {
        return refEq(this, other)
    }

    public operator func !=(other: Grammar): Bool {
        return !refEq(this, other)
    }

    public override func hashCode(): Int64 {
        var has: Int64 = 31 * GrammarName.hashCode()
        for (i in 0..GrammarTokens.size) {
            has += GrammarTokens[i].hashCode()
        }
        return has
    }

    public override func toString(): String {
        return PrismToString.toString(this)
    }
}
