export declare class PrismNodesParseResArkts {
    getType(): string
    getText(): string
    getAlias(): string | undefined
    getColor(): number | undefined
    constructor (types: string, text: string, alias: string | undefined, color: number | undefined)
}

export declare class PrismNodesParseResColorArkts {
    getBackground(): number
    getDefaultFontColor(): number
    getListColor(): Array<PrismNodesParseResArkts>
    constructor (list: Array<PrismNodesParseResArkts>, background: number, defaultFontColor: number)
}


export declare function codeStringToColorStringArkts(code: string, info: string | undefined, isDarkula: boolean): PrismNodesParseResColorArkts

export declare function codeStringToColorStringCustomizeArkts(code: string, info: string | undefined, background: number, text: number, colorMap: Map<string, number>): PrismNodesParseResColorArkts

export declare function codeStringToColorStringArkts(code: string, info: string | undefined, isDarkula: boolean): Promise<PrismNodesParseResColorArkts>

export declare function arktsCodeStringToColorStringCustomize(code: string, info: string | undefined, background: number, text: number, colorMap: Map<string, number>): PrismNodesParseResColorArkts
