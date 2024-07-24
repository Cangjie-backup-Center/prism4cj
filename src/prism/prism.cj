/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package prism4cj.prism

internal import std.collection.ArrayList
internal import std.collection.HashMap
internal import std.collection.HashSet
internal import std.regex.Matcher
internal import std.regex.Regex
internal import std.regex.RegexException
internal import std.regex.MatchData

public class Prism {
    var grammarLocator: GrammarLocator

    public init(grammarLocator: GrammarLocator) {
        this.grammarLocator = grammarLocator
    }

    public func grammar(name: String): ?Grammar {
        return grammarLocator.grammar(this, name)
    }

    public static func token(name: String, patterns: ArrayList<Pattern>): Token {
        return TokenImpl(name, patterns)
    }

    public static func token(name: String, patterns: Array<Pattern>): Token {
        return TokenImpl(name, ArrayList(patterns))
    }

    public static func pattern(regex: Regex): Pattern {
        return PatternImpl(regex, false, false, None, None)
    }

    public static func pattern(regex: Regex, lookbehind: Bool): Pattern {
        return PatternImpl(regex, lookbehind, false, None, None)
    }

    public static func pattern(regex: Regex, lookbehind: Bool, greedy: Bool): Pattern {
        return PatternImpl(regex, lookbehind, greedy, None, None)
    }

    public static func pattern(regex: Regex, lookbehind: Bool, greedy: Bool, alias: ?String): Pattern {
        return PatternImpl(regex, lookbehind, greedy, alias, None)
    }

    public static func pattern(regex: Regex, lookbehind: Bool, greedy: Bool, alias: ?String, inside: ?Grammar): Pattern {
        return PatternImpl(regex, lookbehind, greedy, alias, inside)
    }

    public func tokenize(text: String, grammar: Grammar): ArrayList<Node> {
        var entries: ArrayList<Node> = ArrayList<Node>(3)
        entries.append(TextImpl(text))
        matchGrammar(text, entries, grammar, 0, 0, false, None)
        return entries
    }

    private func matchGrammar(
        text: String,
        entries: ArrayList<Node>,
        grammar: Grammar,
        index: Int64,
        startPosition: Int64,
        oneShot: Bool,
        target: ?Token
    ): Unit {
        let textLength: Int64 = text.size
        for (token in grammar.tokens()) {
            if (let Some(v) <- target) {
                if (token == v) {
                    return
                }
            }
            for (pattern in token.patterns()) {
                let lookbehind: Bool = pattern.lookbehind()
                let greedy: Bool = pattern.greedy()
                var lookbehindLength: Int64 = 0
                let regex: Regex = pattern.regex()
                // Don't cache textLength as it changes during the loop
                var i: Int64 = index
                var position: Int64 = startPosition
                while (i < entries.size) {
                    if (entries.size > textLength) {
                        throw Exception(
                            "prism internal error. Number of entry nodes " + "is greater that the text length.\n" +
                            "Nodes: " + entries.toString() + "\n" + "Text: " + text)
                    }
                    let node: ?Node = entries.get(i)
                    if (node.isSome() && isSyntaxNode(node.getOrThrow())) {
                        position += node.getOrThrow().textLength()
                        i++
                        continue
                    }
                    var str: String = ""
                    if (node.isSome()) {
                        str = (node.getOrThrow() as Text).getOrThrow().literal()
                    }
                    var matcher: Matcher
                    var deleteCount: Int64
                    var greedyMatch: Bool
                    var greedyAdd: Int64 = 0
                    var matchData: ?MatchData = None
                    if (greedy && i != entries.size - 1) {
                        matcher = regex.matcher(text)
                        // limit search to the position (?)
                        matcher.setRegion(position, textLength)
                        matchData = matcher.find()
                        if (matchData.isNone()) {
                            break
                        }
                        var matchRealData: MatchData = matchData.getOrThrow()
                        var begin: Int64 = matchRealData.matchPosition().start
                        if (lookbehind) {
                            try {
                                begin += matchRealData.matchStr(1).size
                            } catch (e: Exception) {
                                break
                            }
                        }
                        var to: Int64 = 0
                        try {
                            to = matchRealData.matchPosition().start + matchRealData.matchStr(0).size
                        } catch (e: Exception) {
                            break
                        }
                        var k = i
                        var p = position
                        let len: Int64 = entries.size
                        while (k < len && (p < to || (!isSyntaxNode(entries.get(k).getOrThrow()) &&
                                !isGreedyNode(entries.get(k - 1).getOrThrow())))) {
                            match (entries.get(k)) {
                                case Some(v) => p += v.textLength()
                                case None => ()
                            }
                            // Move the index i to the element in strarr that is closest to from
                            if (begin >= p) {
                                i += 1
                                position = p
                            }
                            k++
                        }
                        if (entries.get(i).isSome() && isSyntaxNode(entries[i])) {
                            position += entries.get(i).getOrThrow().textLength()
                            i++
                            continue
                        }
                        greedyMatch = true
                        deleteCount = k - i
                        greedyAdd = -position
                        str = text[position..p]
                    } else {
                        greedyMatch = false
                        matcher = regex.matcher(str)
                        deleteCount = 1
                    }
                    if (!greedyMatch) {
                        matchData = matcher.find()
                        if (matchData.isNone()) {
                            if (oneShot) {
                                break
                            }
                            position += entries.get(i).getOrThrow().textLength()
                            i++
                            continue
                        }
                    }
                    let matchRealData2 = matchData.getOrThrow()
                    if (lookbehind) {
                        var group: String = ""
                        try {
                            group = matchRealData2.matchStr(1)
                        } catch (e: Exception) {
                            break
                        }
                        lookbehindLength = group.size
                    }
                    let begin02: Int64 = matchRealData2.matchPosition().start + greedyAdd + lookbehindLength
                    var mat: String
                    if (lookbehindLength > 0) {
                        try {
                            mat = matchRealData2.matchStr()[lookbehindLength..]
                        } catch (e: Exception) {
                            break
                        }
                    } else {
                        try {
                            mat = matchRealData2.matchStr()
                        } catch (e: Exception) {
                            break
                        }
                    }
                    var to02: Int64 = begin02 + mat.size
                    for (_ in 0..deleteCount) {
                        entries.remove(i)
                    }
                    var i2: Int64 = i
                    if (begin02 != 0) {
                        var before: String = ""
                        try {
                            before = str[..begin02]
                        } catch (e: Exception) {
                            break
                        }
                        i += 1
                        position += before.size
                        entries.insert(i2, TextImpl(before))
                        i2++
                    }
                    var tokenEntries: ArrayList<Node>
                    let inside: ?Grammar = pattern.inside()
                    var hasInside: Bool = if (inside.isSome()) {
                        true
                    } else {
                        false
                    }
                    if (hasInside) {
                        tokenEntries = tokenize(mat, inside.getOrThrow())
                    } else {
                        tokenEntries = ArrayList<Node>(TextImpl(mat))
                    }
                    let syntaxImp: Syntax = SyntaxImpl(token.name(), tokenEntries, pattern.alias(), mat, greedy,
                        hasInside)
                    entries.insert(i2, syntaxImp)
                    i2++
                    // important thing here (famous off-by one error) to check against full length (not `length - 1`)
                    if (to02 < str.size) {
                        var after: String = ""
                        try {
                            after = str[to02..]
                        } catch (e: Exception) {
                            break
                        }
                        entries.insert(i2, TextImpl(after))
                    }
                    if (deleteCount != 1) {
                        matchGrammar(text, entries, grammar, i, position, true, token)
                    }
                    if (oneShot) {
                        break
                    }
                    match (entries.get(i)) {
                        case Some(v) => position += v.textLength()
                        case None => ()
                    }
                    i++
                }
            }
        }
    }

    private static func isSyntaxNode(node: Node): Bool {
        return node.isSyntax()
    }

    private static func isGreedyNode(node: Node): Bool {
        return node.isSyntax() && (node as Syntax).getOrThrow().greedy()
    }
}
