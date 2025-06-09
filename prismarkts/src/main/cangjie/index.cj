package prism4cj

import ohos.ark_interop.*
import ohos.ark_interop_macro.*
import ohos.ark_interop_helper.*
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

@Interop[ArkTS]
public func codeStringToColorStringArkts(code: String, info: Option<String>, isDarkula: Bool): PrismNodesParseResColorArkts {
    let prismNodesParseResColor: PrismNodesParseResColor = codeStringToColorString(code, info, isDarkula)
    let listArkts: ArrayList<PrismNodesParseResArkts> = ArrayList<PrismNodesParseResArkts>()
    for (i in 0..prismNodesParseResColor.getListColor().size) {
        listArkts.append(PrismNodesParseResArkts(prismNodesParseResColor.getListColor()[i]))
    }
    let jsList: JSArrayEx<PrismNodesParseResArkts> = JSArrayEx<PrismNodesParseResArkts>(listArkts.toArray())
    return PrismNodesParseResColorArkts(jsList,prismNodesParseResColor.getBackground(),prismNodesParseResColor.getDefaultFontColor())
}

@Interop[ArkTS]
public class PrismNodesParseResColorArkts {
    @Interop[ArkTS, Invisible]
    var prismNodesParseResColor: PrismNodesParseResColor

    @Interop[ArkTS, Invisible]
    init(prismNodesParseResColor: PrismNodesParseResColor) {
        this.prismNodesParseResColor = prismNodesParseResColor
    }

    public init(list: JSArrayEx<PrismNodesParseResArkts>, background: UInt32, defaultFontColor: UInt32) {
        let a = ArrayList<PrismNodesParseRes>()
        for (i in 0..list.size) {
            a.append(list[i].prismNodesParseRes)
        }
        this.prismNodesParseResColor = PrismNodesParseResColor(a, background, defaultFontColor)
    }

    public func getBackground(): UInt32 {
        return prismNodesParseResColor.getBackground()
    }

    public func getDefaultFontColor(): UInt32 {
        return prismNodesParseResColor.getDefaultFontColor()
    }

    public func getListColor(): JSArrayEx<PrismNodesParseResArkts> {
        let a = ArrayList<PrismNodesParseResArkts>()
        for (i in 0..prismNodesParseResColor.getListColor().size) {
            a.append(PrismNodesParseResArkts(prismNodesParseResColor.getListColor()[i]))
        }
        return JSArrayEx<PrismNodesParseResArkts>(a.toArray())
    }
}

@Interop[ArkTS]
public class PrismNodesParseResArkts {
    @Interop[ArkTS, Invisible]
    var prismNodesParseRes: PrismNodesParseRes

    @Interop[ArkTS, Invisible]
    init(prismNodesParseRes: PrismNodesParseRes) {
        this.prismNodesParseRes = prismNodesParseRes
    }

    /**
     * PrismNodesParseRes 构造函数
     *
     * @param types 类型
     * @param text  文本
     * @param text  别名
     * @param text  文本对应的颜色
     */
    public init(types: String, text: String, alias: Option<String>, color: Option<UInt32>) {
        let c = if (let Some(v) <- color) {
            Color(v)
        } else {
            Option<Color>.None
        }
        this.prismNodesParseRes = PrismNodesParseRes(types, text, alias, c)
    }

    /**
     * 获取结果对象类型
     *
     * @return 返回结果对象的类型
     */
    public func getType(): String {
        return this.prismNodesParseRes.getType()
    }

    /**
     * 获取结果对象文本
     *
     * @return 返回结果对象的文本信息
     */
    public func getText(): String {
        return this.prismNodesParseRes.getText()
    }

    /**
     * 获取结果对象别名
     *
     * @return 返回结果对象的别名
     */
    public func getAlias(): Option<String> {
        return this.prismNodesParseRes.getAlias()
    }

    /**
     * 获取结果对象文本对应的颜色
     *
     * @return 返回结果对象文本对应的颜色
     */
    public func getColor(): Option<UInt32> {
        return if (let Some(v) <- this.prismNodesParseRes.getColor()) {
            v.toUInt32()
        } else {
            Option<UInt32>.None
        }
    }
}
