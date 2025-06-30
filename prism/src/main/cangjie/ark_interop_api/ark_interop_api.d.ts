export declare class PrismNodesParseResArkts {
    getType(): string
    getText(): string
    getAlias(): string | undefined
    getColor(): number | undefined
}

export declare class PrismNodesParseResColorArkts {
    getBackground(): number
    getDefaultFontColor(): number
    getListColor(): Array<PrismNodesParseResArkts>
}

export declare interface CustomLib {
    codeStringToColorStringArkts(code: string, info: string | undefined, isDarkula: boolean): Promise<PrismNodesParseResColorArkts>
    PrismNodesParseResColorArkts: {new (list: Array<PrismNodesParseResArkts>, background: number, defaultFontColor: number): PrismNodesParseResColorArkts}
    PrismNodesParseResArkts: {new (types: string, text: string, alias: string | undefined, color: number | undefined): PrismNodesParseResArkts}
    codeStringToColorStringCustomizeArkts(code: string, info: string | undefined, background: number, text: number, colorMap: Map<string, number>): PrismNodesParseResColorArkts
}