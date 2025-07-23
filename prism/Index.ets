import {
  codeStringToColorStringCJ,
  codeStringToColorStringCustomizeCJ,
  PrismColor,
  PrismNodesParseResColor } from './src/main/ets/components/MainPage';

export { PrismNodesParseResColor, PrismColor, PrismNodesParseRes } from './src/main/ets/components/MainPage'

export async function codeStringToColorString(code: string, info: string | undefined, isDarkula: boolean): Promise<PrismNodesParseResColor> {
  return codeStringToColorStringCJ(code, info, isDarkula)
}

export async function codeStringToColorStringCustomize(code: string, info: string | undefined, background: number, text: number, colorMap: Map<PrismColor, number>): Promise<PrismNodesParseResColor> {
  return codeStringToColorStringCustomizeCJ(code, info, background,text,colorMap)
}

