/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

package prism

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

    public override func hashCode(): Int64 {
        return 31 * tokenName.hashCode() + 31 * tokenPatterns.toString().hashCode()
    }

    public override func toString(): String {
        return ""
    }
}
