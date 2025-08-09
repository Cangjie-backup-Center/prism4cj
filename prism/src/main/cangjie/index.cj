package prism4cj

import ohos.base.Color
import ohos.ark_interop.*
import ohos.ark_interop_macro.*

public func arktsCodeStringToColorString(context: JSContext, callInfo: JSCallInfo): JSValue {
    let code = callInfo[0].toString(context)
    let info: ?String = if (callInfo[1].isNull()) {
        None
    } else {
        String.fromJSValue(context, callInfo[1])
    }
    let isDarkula = Bool.fromJSValue(context, callInfo[2])
    let PrismNodesParseResColor_factory = callInfo[3].asFunction()
    let PrismNodesParseRes_factory = callInfo[4].asFunction()
    let promise = context.promiseCapability()
    spawn {
        let prismNodesParseResColor: PrismNodesParseResColor = codeStringToColorString(code, info, isDarkula)
        context.postJSTask {
            =>
            let resColor: JSObject = PrismNodesParseResColor_factory
                .call(prismNodesParseResColor.background.toJSValue(context),prismNodesParseResColor.defaultFontColor.toJSValue(context))
                .asObject()
            for (i in 0..prismNodesParseResColor.getListColor().size) {
                let cjcolor = prismNodesParseResColor.getListColor()[i]
                let jscolor: JSValue = PrismNodesParseRes_factory.call(
                    cjcolor.types.toJSValue(context),
                    cjcolor.text.toJSValue(context),
                    (cjcolor.alias?.toJSValue(context)) ?? context.undefined().toJSValue(),
                    (cjcolor.color?.toJSValue(context)) ?? context.undefined().toJSValue()
                )
                resColor.callMethod('addRes', jscolor)
            }
            let ret = resColor.toJSValue()
            promise.resolve(ret)
        }
    }
    return promise.toJSValue()
}

@Interop[ArkTS]
public func arktsCodeStringToColorStringCustomize(code: String, info: Option<String>, background: UInt32, text: UInt32, colorMap: JSHashMapEx<String, UInt32>): PrismNodesParseResColorArkts {
    let prismNodesParseResColor: PrismNodesParseResColor = codeStringToColorStringCustomize(code, info, background, text, colorMap.toHashMap())
    let listArkts: ArrayList<PrismNodesParseResArkts> = ArrayList<PrismNodesParseResArkts>()
    for (i in 0..prismNodesParseResColor.getListColor().size) {
        listArkts.add(PrismNodesParseResArkts(prismNodesParseResColor.getListColor()[i]))
    }
    let jsList: JSArrayEx<PrismNodesParseResArkts> = JSArrayEx<PrismNodesParseResArkts>(listArkts.toArray())
    return PrismNodesParseResColorArkts(jsList, prismNodesParseResColor.getBackground(), prismNodesParseResColor.getDefaultFontColor())
}

let EXPORT_MODULE1 = JSModule.registerModule {
    runtime, exports => exports["arktsCodeStringToColorString"] = runtime.function(arktsCodeStringToColorString).toJSValue()
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
            a.add(list[i].prismNodesParseRes)
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
            a.add(PrismNodesParseResArkts(prismNodesParseResColor.getListColor()[i]))
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
        let c: ?UInt32 = if (let Some(v) <- color) {
            v
        } else {
            Option<UInt32>.None
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
            v
        } else {
            Option<UInt32>.None
        }
    }
}
