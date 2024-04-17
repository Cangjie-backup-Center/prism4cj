/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism

public abstract class Pattern <: Hashable & Equatable<Pattern> & ToString {
    public func regex(): Regex

    public func lookbehind(): Bool

    public func greedy(): Bool

    public func alias(): ?String

    public func inside(): ?Grammar
}

public class PatternImpl <: Pattern {
    var patternRegex: Regex
    var patternLookbehind: Bool
    var patternGreedy: Bool
    var patternAlias: ?String
    var patternInside: ?Grammar

    public init(regex: Regex, lookbehind: Bool, greedy: Bool, alias: ?String, inside: ?Grammar) {
        this.patternRegex = regex
        this.patternLookbehind = lookbehind
        this.patternGreedy = greedy
        this.patternAlias = alias
        this.patternInside = inside
    }

    public override func regex(): Regex {
        return patternRegex
    }

    public override func lookbehind(): Bool {
        return patternLookbehind
    }

    public override func greedy(): Bool {
        return patternGreedy
    }

    public override func alias(): ?String {
        return patternAlias
    }

    public override func inside(): ?Grammar {
        return patternInside
    }

    public operator func ==(other: Pattern): Bool {
        return refEq(this, other)
    }

    public operator func !=(other: Pattern): Bool {
        return !refEq(this, other)
    }

    @OverflowWrapping
    public override func hashCode(): Int64 {
        return 31 * patternRegex.string().hashCode()
    }

    public override func toString(): String {
        return PrismToString.toString(this)
    }
}
