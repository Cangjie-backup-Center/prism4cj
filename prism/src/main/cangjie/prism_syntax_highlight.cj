/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package prism4cj

import prism4cj.prism.*
import prism4cj.prism.Text as PrismText
import prism4cj.prism.Node as PrismNode
import prism4cj.prism.Grammar as PrismGrammar

/**
 * prism 句法高亮类
 */
public class PrismSyntaxHighlight {
    let prism: Prism
    let theme: PrismTheme

    /**
     * 根据 prism 对象和主题生成句法高亮类
     *
     * @param prism 预定义的 prism 类对象
     * @param theme 预定义主题
     * @return PrismSyntaxHighlight 返回句法高亮类对象
     */
    public static func create(prism: Prism, theme: PrismTheme): PrismSyntaxHighlight {
        return PrismSyntaxHighlight(prism, theme)
    }

    init(prism: Prism, theme: PrismTheme) {
        this.prism = prism
        this.theme = theme
    }

    /**
     * 代码高亮方法
     *
     * @param info 代码语言
     * @param code 代码
     * @return ArrayList<PrismNodesParseRes> 返回通过 prism 库解析后的结果集
     */
    public func highlight(info: ?String, code: String): ArrayList<PrismNodesParseRes> {
        if (code.isEmpty() || info.isNone()) {
            return highlightNoLanguageInfo(code)
        }
        return highlightWithLanguageInfo(this.prism, this.theme, info.getOrThrow(), code)
    }

    func highlightNoLanguageInfo(code: String): ArrayList<PrismNodesParseRes> {
        return ArrayList<PrismNodesParseRes>([PrismNodesParseRes("", code, Option<String>.None, Option<UInt32>.None)])
    }

    func highlightWithLanguageInfo(prism: Prism, theme: PrismTheme, info: String, code: String): ArrayList<PrismNodesParseRes> {
        return PrismNodeParse.textToArrayList(prism, theme.getColorMap(), info, code)
    }

    func getPrism(): Prism {
        return prism
    }

    func getTheme(): PrismTheme {
        return theme
    }
}

/**
 * prism 解析 Node 对象返回的结果集
 */
public class PrismNodesParseRes <: ToString {
    var types: String = ""
    var text: String = ""
    var alias: ?String = None
    var color: ?UInt32 = None

    /**
     * PrismNodesParseRes 构造函数
     */
    init() {}

    /**
     * PrismNodesParseRes 构造函数
     *
     * @param types 类型
     * @param text  文本
     * @param text  别名
     * @param text  文本对应的颜色
     */
    public init(types: String, text: String, alias: ?String, color: ?UInt32) {
        this.types = types
        this.text = text
        this.alias = alias
        this.color = color
    }

    /**
     * 获取结果对象类型
     *
     * @return 返回结果对象的类型
     */
    func getType(): String {
        return types
    }

    /**
     * 获取结果对象文本
     *
     * @return 返回结果对象的文本信息
     */
    func getText(): String {
        return text
    }

    /**
     * 获取结果对象别名
     *
     * @return 返回结果对象的别名
     */
    func getAlias(): ?String {
        return alias
    }

    /**
     * 获取结果对象文本对应的颜色
     *
     * @return 返回结果对象文本对应的颜色
     */
    func getColor(): ?UInt32 {
        return color
    }

    /**
     * 转换字符串方法
     */
    public func toString(): String {
        if (alias.isSome() && color.isSome()) {
            return "PrismNodesParseRes{" + "types=" + types.toString() + ", text=\'" + text + "\'" + ", alias=\'" +
                alias.getOrThrow() + "}"
        } else if (alias.isSome()) {
            return "PrismNodesParseRes{" + "types=" + types.toString() + ", text=\'" + text + "\'" + ", alias=\'" +
                alias.getOrThrow() + "}"
        } else if (color.isSome()) {
            return "PrismNodesParseRes{" + "types=" + types.toString() + ", text=\'" + text + "\'" + ", alias=\'" +
                "None" + "}"
        } else {
            return "PrismNodesParseRes{" + "types=" + types.toString() + ", text=\'" + text + "\'" + ", alias=\'" +
                "None" + "}"
        }
    }
}

class PrismNodeParse {
    static let glg: GrammarLocatorGrammarUtils = GrammarLocatorGrammarUtils()

    static func textToArrayList(prism: Prism, colorMap: HashMap<String, UInt32>, info: ?String, literal: String): ArrayList<PrismNodesParseRes> {
        if (let None <- info) {
            return ArrayList<PrismNodesParseRes>([PrismNodesParseRes("", literal, Option<String>.None, Option<UInt32>.None)])
        }
        let realInfo: String = info.getOrThrow().toAsciiLower()
        var grammar: ?PrismGrammar = None
        grammar = glg.grammar(prism, realInfo)
        var list: ArrayList<PrismNode> = try {
            prism.tokenize(literal, grammar.getOrThrow())
        } catch (e: NoneValueException) {
            return ArrayList<PrismNodesParseRes>([PrismNodesParseRes("", literal, Option<String>.None, Option<UInt32>.None)])
        }
        let listPrismNodesParseRes: ArrayList<PrismNodesParseRes> = ArrayList<PrismNodesParseRes>()
        for (i in 0..list.size) {
            PrismNodeParse.iterCurrent(list[i], Option.None, listPrismNodesParseRes)
        }
        for (prismNodesParseRes in listPrismNodesParseRes) {
            prismNodesParseRes.color = PrismNodeParse.renderColor(colorMap, prismNodesParseRes)
        }
        return listPrismNodesParseRes
    }

    static func iterCurrent(node: PrismNode, parent: ?Syntax, objList: ArrayList<PrismNodesParseRes>): Unit {
        if (node.isSyntax()) {
            let opt: Syntax = (node as Syntax).getOrThrow()
            for (child in opt.children()) {
                iterCurrent(child, opt, objList)
            }
        } else {
            let obj = PrismNodesParseRes()
            obj.types = parent?.syntaxType() ?? ""
            obj.alias = parent?.alias() ?? None
            obj.text = (node as PrismText).getOrThrow().literal()
            objList.add(obj)
        }
    }

    static func renderColor(map: HashMap<String, UInt32>, obj: PrismNodesParseRes): ?UInt32 {
        let types: String = obj.getType()
        let alias: ?String = obj.getAlias()
        var color: ?UInt32 = map.get(types.toAsciiLower())
        if (color.isNone() && alias.isSome()) {
            color = map.get(alias.getOrThrow().toAsciiLower())
        }
        if (color.isSome()) {
            return color
        } else {
            return None
        }
    }
}
