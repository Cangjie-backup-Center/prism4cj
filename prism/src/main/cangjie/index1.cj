package prism4cj

import ohos.ark_interop.*

public func parseIntoJs(context: JSContext, callInfo: JSCallInfo): JSValue {
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
                    (cjcolor.color?.toUInt32().toJSValue(context)) ?? context.undefined().toJSValue()
                )
                resColor.callMethod('addRes', jscolor)
            }
            let ret = resColor.toJSValue()
            promise.resolve(ret)
        }
    }
    return promise.toJSValue()
}

let EXPORT_MODULE1 = JSModule.registerModule {
    runtime, exports => exports["parseIntoJs"] = runtime.function(parseIntoJs).toJSValue()
}