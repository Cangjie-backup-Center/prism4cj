export declare class PrismNodeCJ {
  getType(): string

  getText(): string

  getAlias(): string | undefined

  getColor(): number | undefined

  constructor (types: string, text: string, alias: string | undefined, color: number | undefined)
}

export declare class PrismBlockCJ {
  getText(): string

  getList(): Array<PrismNodeCJ>

  constructor (text: string, list: Array<PrismNodeCJ>)
}

export declare class PrismResCJ {
  getBackground(): number

  getDefaultFontColor(): number

  getListColor(): Array<PrismBlockCJ>

  constructor (list: Array<PrismBlockCJ>, background: number, defaultFontColor: number)
}

export declare function arktsCodeStringToColorStringCustomize(code: string, info: string | undefined, background: number, text: number, colorMap: Map<string, number>): PrismResCJ

/**
 * parse result into js object
 * @param code
 * @param info
 * @param isDarkula
 * @param resFactory: (background: number,defaultFontColor: number)=>PrismRes
 * @param nodeFactory: (types: string,text: string,alias: string | undefined,color: number | undefined)=>PrismBlock
 * @returns Promise<PrismRes>
 */
export declare function arktsCodeStringToColorString(code: string, info: string | undefined, isDarkula: boolean, resColorFactory: (background: number, defaultFontColor: number) => object, resFactory: (types: string, text: string, alias: string | undefined, color: number | undefined) => object): Promise<object>