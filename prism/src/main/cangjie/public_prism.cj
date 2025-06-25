/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package prism4cj

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

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
        PrismThemeDarkula.create()
    } else {
        PrismThemeDefault.create()
    }
    try {
        var prism: Prism = Prism(GrammarLocatorGrammarUtils())
        var psh: PrismSyntaxHighlight = PrismSyntaxHighlight.create(prism, prismTheme)
        prismNodesParseResList = psh.highlight(info, code)
    } catch (e: Exception) {
        let prismNodesParseRes: PrismNodesParseRes = PrismNodesParseRes("", code, Option<String>.None,
            Option<Color>.None)
        prismNodesParseResList.append(prismNodesParseRes)
    }
    return PrismNodesParseResColor(prismNodesParseResList, prismTheme.background().toUInt32(),
        prismTheme.textColor().toUInt32())
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
