/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package cangjie_tpc::prism4cj.prism

abstract class PrismToString {
    static func toString(grammar: Grammar): String {
        let builder: StringBuilder = StringBuilder()
        toString(builder, CacheImpl(), grammar)
        return builder.toString()
    }

    static func toString(token: Token): String {
        let builder: StringBuilder = StringBuilder()
        toString(builder, CacheImpl(), token)
        return builder.toString()
    }

    static func toString(pattern: Pattern): String {
        let builder: StringBuilder = StringBuilder()
        toString(builder, CacheImpl(), pattern)
        return builder.toString()
    }

    private static func toString(builder: StringBuilder, cache: Cache, grammar: Grammar): Unit {
        builder.append("Grammar{id=0x")
        builder.append(grammar.hashCode())
        builder.append(",name=\"")
        builder.append(grammar.name())
        builder.append('\"')
        if (cache.visitedGrammar(grammar)) {
            builder.append(",[...]")
        } else {
            cache.markVisitedGrammar(grammar)
            builder.append(",tokens=[")
            var first: Bool = true
            for (i in 0..grammar.tokens().size) {
                if (first) {
                    first = false
                } else {
                    builder.append(',')
                }
                toString(builder, cache, grammar.tokens()[i])
            }
            builder.append(']')
        }
        builder.append('}')
    }

    private static func toString(builder: StringBuilder, cache: Cache, token: Token) {
        builder.append("Token{id=0x")
        builder.append(token.hashCode())
        builder.append(",name=\"")
        builder.append(token.name())
        builder.append('\"')

        if (cache.visitedToken(token)) {
            builder.append(",[...]")
        } else {
            cache.markVisitedToken(token)
            builder.append(",patterns=[")
            var first: Bool = true
            for (i in 0..token.patterns().size) {
                if (first) {
                    first = false
                } else {
                    builder.append(',')
                }
                toString(builder, cache, token.patterns()[i])
            }
            builder.append(']')
        }
        builder.append('}')
    }

    private static func toString(builder: StringBuilder, cache: Cache, pattern: Pattern) {
        builder.append("Pattern{id=0x")
        builder.append(pattern.hashCode())
        if (cache.visitedPattern(pattern)) {
            builder.append(",[...]")
        } else {
            cache.markVisitedPattern(pattern)
            builder.append(",regex=\"")
            builder.append(pattern.regex().string())
            builder.append('\"')
            if (pattern.lookbehind()) {
                builder.append(",lookbehind=true")
            }
            if (pattern.greedy()) {
                builder.append(",greedy=true")
            }
            match (pattern.alias()) {
                case Some(v) => 
                    builder.append(",alias=\"")
                    builder.append(v)
                    builder.append('\"')
                case None =>
                    builder.append(",alias=\"")
                    builder.append("None")
                    builder.append('\"')
            }
            let inside: ?Grammar = pattern.inside()
            if (let Some(v) <- inside) {
                builder.append(",inside=")
                toString(builder, cache, v)
            }
        }
        builder.append('}')
    }
}

interface Cache {
    func visitedGrammar(grammar: Grammar): Bool

    func markVisitedGrammar(grammar: Grammar): Unit

    func visitedToken(token: Token): Bool

    func markVisitedToken(token: Token): Unit

    func visitedPattern(pattern: Pattern): Bool

    func markVisitedPattern(pattern: Pattern): Unit
}

class CacheImpl <: Cache {
    var cache: CacheProp = CacheProp()

    public override func visitedGrammar(grammar: Grammar): Bool {
        if (cache.grammar.isSome() && cache.grammar == grammar) {
            return true
        }
        return false
    }

    public override func markVisitedGrammar(grammar: Grammar): Unit {
        cache.grammar = grammar
    }

    public override func visitedToken(token: Token): Bool {
        if (cache.token.isSome() && cache.token == token) {
            return true
        }
        return false
    }

    public override func markVisitedToken(token: Token): Unit {
        cache.token = token
    }

    public override func visitedPattern(pattern: Pattern): Bool {
        if (cache.pattern.isSome() && cache.pattern == pattern) {
            return true
        }
        return false
    }

    public override func markVisitedPattern(pattern: Pattern): Unit {
        cache.pattern = pattern
    }
}

class CacheProp {
    var _grammar: ?Grammar = None
    public mut prop grammar: ?Grammar {
        get() {
            _grammar
        }
        set(v) {
            this._grammar = v
        }
    }

    var _token: ?Token = None
    public mut prop token: ?Token {
        get() {
            _token
        }
        set(v) {
            this._token = v
        }
    }

    var _pattern: ?Pattern = None
    public mut prop pattern: ?Pattern {
        get() {
            _pattern
        }
        set(v) {
            this._pattern = v
        }
    }
}
