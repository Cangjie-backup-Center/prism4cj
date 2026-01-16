/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package cangjie_tpc::prism4cj.prism

public abstract class Token <: Hashable & Equatable<Token> & ToString {
    public func name(): String

    public func patterns(): ArrayList<Pattern>
}

public class TokenImpl <: Token {
    var tokenName: String
    var tokenPatterns: ArrayList<Pattern>

    public init(name: String, patterns: ArrayList<Pattern>) {
        this.tokenName = name
        this.tokenPatterns = patterns
    }

    public override func name(): String {
        return tokenName
    }

    public override func patterns(): ArrayList<Pattern> {
        return tokenPatterns
    }

    public operator func ==(other: Token): Bool {
        return refEq(this, other)
    }

    public operator func !=(other: Token): Bool {
        return !refEq(this, other)
    }

    @OverflowWrapping
    public override func hashCode(): Int64 {
        var has: Int64 = 31 * tokenName.hashCode()
        for (i in 0..tokenPatterns.size) {
            has += tokenPatterns[i].hashCode()
        }
        return has
    }

    public override func toString(): String {
        return PrismToString.toString(this)
    }
}
