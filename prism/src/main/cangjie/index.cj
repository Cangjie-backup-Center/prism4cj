package prism4cj

import ohos.base.Color
import ohos.ark_interop.*
import ohos.ark_interop_macro.*

func getStackTrace(thrown: ?Exception): String {
    var res: String = ""
    match (thrown) {
        case None => return res
        case Some(v) =>
            res = "\n${v.toString()}\n"
            var arr = v.getStackTrace()
            for (line in arr) {
                res += "      at ${line.declaringClass}.${line.methodName}(${line.fileName}:${line.lineNumber})\n"
            }
            return res
    }
}

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
                .call(
                    prismNodesParseResColor.background.toJSValue(context),
                    prismNodesParseResColor.defaultFontColor.toJSValue(context)
                )
                .asObject()
            for (i in 0..prismNodesParseResColor.getListColor().size) {
                let cjcolor = prismNodesParseResColor.getListColor()[i]
                if (cjcolor.text == "\n") {
                    resColor.callMethod("addBlock")
                } else {
                    let jscolor: JSValue = PrismNodesParseRes_factory.call(
                        cjcolor.types.toJSValue(context),
                        cjcolor.text.toJSValue(context),
                        (cjcolor.alias?.toJSValue(context)) ?? context.undefined().toJSValue(),
                        (cjcolor.color?.toJSValue(context)) ?? context.undefined().toJSValue()
                    )
                    resColor.callMethod('addNode', jscolor)
                }
            }
            let ret = resColor.toJSValue()
            promise.resolve(ret)
        }
    }
    return promise.toJSValue()
}

let EXPORT_MODULE1 = JSModule.registerModule {
    runtime, exports => exports["arktsCodeStringToColorString"] = runtime.function(arktsCodeStringToColorString).toJSValue()
}

@Interop[ArkTS]
public func arktsCodeStringToColorStringCustomize(code: String, info: Option<String>, background: UInt32, text: UInt32, colorMap: JSHashMapEx<String, UInt32>): PrismResCJ {
    let prismNodesParseResColor: PrismNodesParseResColor = codeStringToColorStringCustomize(code, info, background, text, colorMap.toHashMap())
    var prismBlockCJs: ArrayList<PrismBlockCJ> = ArrayList<PrismBlockCJ>()
    var prismNodeCJs: ArrayList<PrismNodeCJ> = ArrayList<PrismNodeCJ>()
    var str: String = ""
    for (i in 0..prismNodesParseResColor.getListColor().size) {
        if (prismNodesParseResColor.getListColor()[i].text == "\n") {
            var prismBlockCJ: PrismBlockCJ = PrismBlockCJ(str, JSArrayEx<PrismNodeCJ>(prismNodeCJs.toArray()))
            prismBlockCJs.add(prismBlockCJ)
            str = ""
            prismNodeCJs.clear()
        } else {
            prismNodeCJs.add(
                PrismNodeCJ(
                    prismNodesParseResColor.getListColor()[i].types,
                    prismNodesParseResColor.getListColor()[i].text,
                    prismNodesParseResColor.getListColor()[i].alias,
                    prismNodesParseResColor.getListColor()[i].color
                )
            )
            str += prismNodesParseResColor.getListColor()[i].text
        }
    }
    if (str != "") {
        var prismBlockCJ: PrismBlockCJ = PrismBlockCJ(str, JSArrayEx<PrismNodeCJ>(prismNodeCJs.toArray()))
        prismBlockCJs.add(prismBlockCJ)
        str = ""
        prismNodeCJs.clear()
    }
    let jsList: JSArrayEx<PrismBlockCJ> = JSArrayEx<PrismBlockCJ>(prismBlockCJs.toArray())
    return PrismResCJ(jsList, prismNodesParseResColor.getBackground(), prismNodesParseResColor.getDefaultFontColor())
}

@Interop[ArkTS]
public class PrismResCJ {
    var list: JSArrayEx<PrismBlockCJ>
    var background: UInt32
    var defaultFontColor: UInt32

    public init(list: JSArrayEx<PrismBlockCJ>, background: UInt32, defaultFontColor: UInt32) {
        this.list = list
        this.background = background
        this.defaultFontColor = defaultFontColor
    }

    public func getBackground(): UInt32 {
        return this.background
    }

    public func getDefaultFontColor(): UInt32 {
        return this.defaultFontColor
    }

    public func getListColor(): JSArrayEx<PrismBlockCJ> {
        return this.list
    }
}

@Interop[ArkTS]
public class PrismBlockCJ {
    var text: String
    var list: JSArrayEx<PrismNodeCJ>

    public init(text: String, list: JSArrayEx<PrismNodeCJ>) {
        this.text = text
        this.list = list
    }

    public func getText(): String {
        return this.text
    }

    public func getList(): JSArrayEx<PrismNodeCJ> {
        return this.list
    }
}

@Interop[ArkTS]
public class PrismNodeCJ {
    var types: String
    var text: String
    var alias: Option<String>
    var color: Option<UInt32>

    public init(types: String, text: String, alias: Option<String>, color: Option<UInt32>) {
        this.types = types
        this.text = text
        this.alias = alias
        this.color = color
    }

    public func getType(): String {
        return this.types
    }

    public func getText(): String {
        return this.text
    }

    public func getAlias(): Option<String> {
        return this.alias
    }

    public func getColor(): Option<UInt32> {
        return this.color
    }
}
