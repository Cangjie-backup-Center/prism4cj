/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism

abstract class Cloner {
    protected func clone(grammar: Grammar): Grammar

    protected func clone(grammar: Token): Token

    protected func clone(grammar: Pattern): Pattern

    static func create(): Cloner {
        return ClonerImpl()
    }
}

class ClonerImpl <: Cloner {
    protected func clone(grammar: Grammar): Grammar {
        return clone(ContextImpl(), grammar)
    }

    protected func clone(token: Token): Token {
        return clone(ContextImpl(), token)
    }

    protected func clone(pattern: Pattern): Pattern {
        return clone(ContextImpl(), pattern)
    }

    func clone(context: Context, grammar: Grammar): Grammar {
        var contextGrammar: ?Grammar = context.grammar(grammar)
        if (let Some(v) <- contextGrammar) {
            return v
        }
        let tokens: ArrayList<Token> = grammar.tokens()
        var out: ArrayList<Token> = ArrayList<Token>(tokens.size)
        contextGrammar = GrammarImpl(grammar.name(), out)
        context.save(MyHashKey<Grammar>(grammar), contextGrammar)
        for (i in 0..tokens.size) {
            out.append(clone(context, tokens[i]))
        }
        return contextGrammar.getOrThrow()
    }

    func clone(context: Context, token: Token): Token {
        var contextToken: ?Token = context.token(token)
        if (let Some(v) <- contextToken) {
            return v
        }
        var patterns: ArrayList<Pattern> = token.patterns()
        var out: ArrayList<Pattern> = ArrayList<Pattern>(patterns.size)
        contextToken = TokenImpl(token.name(), out)
        context.save(MyHashKey<Token>(token), contextToken)
        for (i in 0..patterns.size) {
            out.append(clone(context, patterns[i]))
        }
        return contextToken.getOrThrow()
    }

    func clone(context: Context, pattern: Pattern): Pattern {
        var contextPattern: ?Pattern = context.pattern(pattern)
        if (let Some(v) <- contextPattern) {
            return v
        }
        var inside: ?Grammar = pattern.inside()
        if (let Some(v) <- inside) {
            contextPattern = PatternImpl(pattern.regex(), pattern.lookbehind(), pattern.greedy(), pattern.alias(),
                clone(context, v))
        } else {
            contextPattern = PatternImpl(pattern.regex(), pattern.lookbehind(), pattern.greedy(), pattern.alias(), None)
        }
        context.save(MyHashKey<Pattern>(pattern), contextPattern)
        return contextPattern.getOrThrow()
    }
}

interface Context {
    func grammar(origin: Grammar): ?Grammar

    func token(origin: Token): ?Token

    func pattern(origin: Pattern): ?Pattern

    func save(origin: MyHashKey<Grammar>, clone: ?Grammar): Unit

    func save(origin: MyHashKey<Token>, clone: ?Token): Unit

    func save(origin: MyHashKey<Pattern>, clone: ?Pattern): Unit
}

class ContextImpl <: Context {
    private let cache: HashMap<Int64, Any> = HashMap<Int64, Any>(3)

    public func grammar(origin: Grammar): ?Grammar {
        return match (cache.get(origin.hashCode())) {
            case Some(v) => (v as Grammar).getOrThrow()
            case None => None
        }
    }

    public func token(origin: Token): ?Token {
        return match (cache.get(origin.hashCode())) {
            case Some(v) => (v as Token).getOrThrow()
            case None => None
        }
    }

    public func pattern(origin: Pattern): ?Pattern {
        return match (cache.get(origin.hashCode())) {
            case Some(v) => (v as Pattern).getOrThrow()
            case None => None
        }
    }

    public func save(origin: MyHashKey<Grammar>, clone: ?Grammar): Unit {
        cache.put(origin.hashCode(), clone)
    }

    public func save(origin: MyHashKey<Token>, clone: ?Token): Unit {
        cache.put(origin.hashCode(), clone)
    }

    public func save(origin: MyHashKey<Pattern>, clone: ?Pattern): Unit {
        cache.put(origin.hashCode(), clone)
    }
}

class MyHashKey<T> <: Hashable & Equatable<MyHashKey<T>> where T <: Hashable & Equatable<T> {
    let realKey: T
    init(realKey: T) {
        this.realKey = realKey
    }
    public func hashCode(): Int {
        realKey.hashCode()
    }
    public operator func ==(a: MyHashKey<T>): Bool {
        return realKey == a.realKey
    }
    public operator func !=(a: MyHashKey<T>): Bool {
        return realKey != a.realKey
    }
}
