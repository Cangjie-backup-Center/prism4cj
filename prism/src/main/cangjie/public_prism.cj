/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package prism4cj

let prismThemeDarkula: PrismTheme = PrismThemeDarkula.create()
let prismThemeDefault: PrismTheme = PrismThemeDefault.create()
let prismDef: Prism = Prism(GrammarLocatorGrammarUtils())

/**
 * 将代码转换成带有颜色的列表
 *
 * @param code 传入代码内容
 * @param info 传入代码类型
 * @param isDarkula 是否深夜模式
 * @return 高亮颜色列表
 */
func codeStringToColorString(code: String, info: ?String, isDarkula: Bool): PrismNodesParseResColor {
    var prismNodesParseResList: ArrayList<PrismNodesParseRes> = ArrayList<PrismNodesParseRes>()
    let prismTheme: PrismTheme = if (isDarkula) {
        prismThemeDarkula
    } else {
        prismThemeDefault
    }
    try {
        var psh: PrismSyntaxHighlight = PrismSyntaxHighlight.create(prismDef, prismTheme)
        prismNodesParseResList = psh.highlight(info, code)
    } catch (e: Exception) {
        let prismNodesParseRes: PrismNodesParseRes = PrismNodesParseRes("", code, Option<String>.None, Option<UInt32>.None)
        prismNodesParseResList.add(prismNodesParseRes)
    }
    return PrismNodesParseResColor(prismNodesParseResList, prismTheme.background(), prismTheme.textColor())
}

/**
 * 将代码转换成带有颜色的列表
 *
 * @param code 传入代码内容
 * @param info 传入代码类型
 * @param background 背景颜色
 * @param text 默认文本颜色
 * @param colorMap 颜色map
 * @return 高亮颜色列表
 */
func codeStringToColorStringCustomize(code: String, info: ?String, background: UInt32, text: UInt32, colorMap: HashMap<String, UInt32>): PrismNodesParseResColor {
    var prismNodesParseResList: ArrayList<PrismNodesParseRes> = ArrayList<PrismNodesParseRes>()
    let prismTheme: PrismTheme = MyPrismTheme.create(background, colorMap, text)
    try {
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var psh: PrismSyntaxHighlight = PrismSyntaxHighlight.create(prism, prismTheme)
        prismNodesParseResList = psh.highlight(info, code)
    } catch (e: Exception) {
        let prismNodesParseRes: PrismNodesParseRes = PrismNodesParseRes("", code, Option<String>.None, Option<UInt32>.None)
        prismNodesParseResList.add(prismNodesParseRes)
    }
    return PrismNodesParseResColor(prismNodesParseResList, prismTheme.background(), prismTheme.textColor())
}

class PrismNodesParseResColor {
    var list: ArrayList<PrismNodesParseRes>
    var background: UInt32
    var defaultFontColor: UInt32

    init(list: ArrayList<PrismNodesParseRes>, background: UInt32, defaultFontColor: UInt32) {
        this.list = list
        this.background = background
        this.defaultFontColor = defaultFontColor
    }

    public func getBackground(): UInt32 {
        return background
    }

    public func getDefaultFontColor(): UInt32 {
        return defaultFontColor
    }

    public func getListColor(): ArrayList<PrismNodesParseRes> {
        return list
    }
}
