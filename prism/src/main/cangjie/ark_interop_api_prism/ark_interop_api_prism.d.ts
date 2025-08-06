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
    codeStringToColorStringArkts(code: string, info: string | undefined, isDarkula: boolean): Promise<PrismNodesParseResColorArkts>
    codeStringToColorStringCustomizeArkts(code: string, info: string | undefined, background: number, text: number, colorMap: Map<string, number>): PrismNodesParseResColorArkts

  /**
   * parse result into js object
   * @param code
   * @param info
   * @param isDarkula
   * @param resColorFactory: (background: number,defaultFontColor: number)=>PrismNodesParseResColor
   * @param resFactory: (types: string,text: string,alias: string | undefined,color: number | undefined)=>PrismNodesParseRes
   * @returns Promise<PrismNodesParseResColor>
   */
  parseIntoJs(
    code: string,
    info: string | undefined,
    isDarkula: boolean,
    resColorFactory: (background: number, defaultFontColor: number) => object,
    resFactory: (types: string, text: string, alias: string | undefined, color: number | undefined) => object
  ): Promise<object>
}