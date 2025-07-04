export declare class PrismNodesParseResColorArkts {
    getBackground(): number
    getDefaultFontColor(): number
    getListColor(): Array<PrismNodesParseResArkts>
}

export declare class PrismNodesParseResArkts {
    getType(): string
    getText(): string
    getAlias(): string | undefined
    getColor(): number | undefined
}

export declare interface CustomLib {
    PrismNodesParseResArkts: {new (types: string, text: string, alias: string | undefined, color: number | undefined): PrismNodesParseResArkts}
    PrismNodesParseResColorArkts: {new (list: Array<PrismNodesParseResArkts>, background: number, defaultFontColor: number): PrismNodesParseResColorArkts}
    codeStringToColorStringArkts(code: string, info: string | undefined, isDarkula: boolean): PrismNodesParseResColorArkts
    codeStringToColorStringCustomizeArkts(code: string, info: string | undefined, background: number, text: number, colorMap: Map<string, number>): PrismNodesParseResColorArkts
}