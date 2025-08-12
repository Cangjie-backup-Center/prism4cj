import { CustomLib, PrismNodesParseResColorArkts } from "libark_interop_api_prism.so";
import { requireCJLib } from "libark_interop_loader.so";
import { collections } from "@kit.ArkTS";

let lib = requireCJLib("libprism4cj.so") as CustomLib

@Sendable
export class PrismNodesParseResColor {
  list: collections.Array<PrismNodesParseRes> = new collections.Array<PrismNodesParseRes>()
  background: number = 0
  defaultFontColor: number = 0

  constructor(list: collections.Array<PrismNodesParseRes>, background: number,defaultFontColor: number ) {
    this.list = list
    this.background = background
    this.defaultFontColor = defaultFontColor
  }

  getBackground(): number {
    return this.background
  }

  getDefaultFontColor(): number {
    return this.defaultFontColor
  }

  getListColor(): collections.Array<PrismNodesParseRes> {
    return this.list
  }

  addRes(res:PrismNodesParseRes):void{
    this.list.push(res)
  }

  addAll(...ress: Array<string | number>): void {
    let i = 0
    while (i < ress.length) {
      let res = new PrismNodesParseRes(ress[i] as string, ress[++i] as string, ress[++i] as string, ress[++i] as number)
      this.list.push(res)
      i++
    }
  }
}

@Sendable
export class PrismNodesParseRes {
  types: string = ""
  text: string = ""
  alias: string | undefined = undefined
  color: number | undefined = undefined

  constructor(types: string,text: string,alias: string | undefined,color: number | undefined) {
    this.types = types
    this.text = text
    this.alias = alias
    this.color = color
  }

  /**
   * 获取结果对象类型
   *
   * @return 返回结果对象的类型
   */
  getType(): string {
    return this.types
  }

  /**
   * 获取结果对象文本
   *
   * @return 返回结果对象的文本信息
   */
  getText(): string {
    return this.text
  }

  /**
   * 获取结果对象别名
   *
   * @return 返回结果对象的别名
   */
  getAlias(): string | undefined {
    return this.alias
  }

  /**
   * 获取结果对象文本对应的颜色
   *
   * @return 返回结果对象文本对应的颜色
   */
  getColor(): number | undefined {
    return this.color
  }
}


export enum PrismColor {
  COMMENT = "comment", // 注释内容
  PROLOG = "prolog", // Prolog 语言中的特定语法结构（如谓词定义）
  DOCTYPE = "doctype", // 文档类型声明: 如 HTML 的 <!DOCTYPE html>
  CDATA = "cdata", // XML/HTML 中的字符数据块，用于包裹无需解析的原始文本
  PUNCTUATION = "punctuation", // 标点符号
  PROPERTY = "property", // CSS/SCSS 中的属性名
  TAG = "tag", // HTML/XML 标签
  BOOLEAN = "boolean", // 布尔值（true/false）
  NUMBER = "number", // 数值内容
  CONSTANT = "constant", // 常量
  SYMBOL = "symbol", // 符号或特殊符号
  DELETED = "deleted", // 版本控制差异中标记为删除的代码行或片段
  SELECTOR = "selector", // CSS/SCSS 选择器
  ATTR_NAME = "attr-name", // HTML/XML 属性的名称
  STRING = "string", // 单引号或双引号包裹的内容
  CHAR = "char", // 字符字面量，如 char c = 'A'
  BUILTIN = "builtin", // 语言内置的函数或类型
  INSERTED = "inserted", // 版本控制差异中标记为新增的代码行或片段
  OPERATOR = "operator", // 运算符
  URL = "url", // 代码中的 URL 字符串
  ENTITY = "entity", // HTML/XML 实体
  ATRULE = "atrule", // CSS 预处理器
  ATTR_VALUE = "attr-value", // HTML/XML 属性的值
  KEYWORD = "keyword", // 语言的关键字
  FUNCTION = "function", // 函数名或方法名
  CLASS_NAME = "class-name", // 类名
  REGEX = "regex", // 正则表达式模式
  IMPORTANT = "important", // CSS 中的 !important 关键字
  VARIABLE = "variable", // 变量名
  DELIMITER = "delimiter", // 代码中的分隔符号
  ANNOTATION = "annotation", // 代码中的注解或装饰性标记
  ESCAPE_SEQ = "escape_seq", // 转义序列
  GENERIC_METHOD = "generic-method", // 泛型方法声明
  PSEUDO_ELEMENT = "pseudo-element", // CSS 伪元素
  PSEUDO_CLASS = "pseudo-class", // CSS 伪类
  CLASS = "class", // HTML/CSS/TypeScript 等的类名
  ID = "id", // CSS 中的 ID 选择器
  ATTRIBUTE = "attribute", // 属性名称(如 HTML 的 id="main" 或 XML 的 attr="value")
  HEXCODE = "hexcode", // 十六进制颜色值
  COMMAND = "command", // 命令行工具指令
  PARAMETER = "PARAMETER", // 函数或方法的参数名
  COORD = "coord", // 坐标数值，SVG/XML 或图形处理代码
  COMMIT_SHA1 = "commit_sha1", // 版本控制中的提交哈希值
  SPOCK_BLOCK = "spock-block", // Groovy 的 Spock 测试框架中的测试块
  NULL = "null", // 空值标识
  NAMESPACE = "namespace", // 命名空间
  SHEBANG = "shebang", // 脚本文件开头的 #! 行
  DEFAULT = "default" // 其它值
}


const resColorFactory = (background: number,defaultFontColor: number)=>new PrismNodesParseResColor(new collections.Array(),background,defaultFontColor)
const resFactory = (types: string,text: string,alias: string | undefined,color: number | undefined)=>new PrismNodesParseRes(types,text,alias,color)

export async function codeStringToColorString(code: string, info: string | undefined, isDarkula: boolean): Promise<PrismNodesParseResColor>  {
  let res = await lib.arktsCodeStringToColorString(code, info, isDarkula, resColorFactory, resFactory) as PrismNodesParseResColor
  return res
}

export function codeStringToColorStringCustomize(code: string, info: string | undefined, background: number, text: number, colorMap: Map<PrismColor, number>): PrismNodesParseResColor {
  let prismNodesParseResColorArkts:PrismNodesParseResColorArkts =lib.arktsCodeStringToColorStringCustomize(code, info, background, text, colorMap)
  let list = prismNodesParseResColorArkts.getListColor()
  let cList = new collections.Array<PrismNodesParseRes>()
  for (let index = 0; index < list.length; index++) {
    let prismNodesParseRes = new PrismNodesParseRes(list[index].getType(),list[index].getText(),list[index].getAlias(),list[index].getColor())
    cList.push(prismNodesParseRes)
  }
  let prismNodesParseResColor:PrismNodesParseResColor = new PrismNodesParseResColor(cList,prismNodesParseResColorArkts.getBackground(),prismNodesParseResColorArkts.getDefaultFontColor())
  return prismNodesParseResColor
}