import { CustomLib, PrismResCJ } from "libark_interop_api_prism.so";
import { requireCJLib } from "libark_interop_loader.so";
import { collections } from "@kit.ArkTS";

let lib = requireCJLib("libprism4cj.so") as CustomLib

const resFactory = (background: number, defaultFontColor: number) => new PrismRes(new collections.Array(), background, defaultFontColor)

const nodeFactory = (types: string, text: string, alias: string | undefined, color: number | undefined) => new PrismNode(types, text, alias, color)

export async function codeStringToColorString(code: string, info: string | undefined, isDarkula: boolean): Promise<PrismRes> {
  let res = await lib.arktsCodeStringToColorString(code, info, isDarkula, resFactory, nodeFactory) as PrismRes
  return res
}

export function codeStringToColorStringCustomize(code: string, info: string | undefined, background: number, text: number, colorMap: Map<PrismColor, number>): PrismRes {
  let res: PrismResCJ = lib.arktsCodeStringToColorStringCustomize(code, info, background, text, colorMap)
  let prismBlocks: collections.Array<PrismBlock> = new collections.Array<PrismBlock>()
  for (let i = 0; i < res.getListColor().length; i++) {
    let prismNodes: collections.Array<PrismNode> = new collections.Array<PrismNode>()
    for (let j = 0; j < res.getListColor()[i].getList().length; j++) {
      prismNodes.push(new PrismNode(
        res.getListColor()[i].getList()[j].getType(),
        res.getListColor()[i].getList()[j].getText(),
        res.getListColor()[i].getList()[j].getAlias(),
        res.getListColor()[i].getList()[j].getColor()
      ))
    }
    let prismBlock = new PrismBlock()
    prismBlock.text = res.getListColor()[i].getText()
    prismBlock.list = prismNodes
    prismBlocks.push(prismBlock)
  }
  let prismRes: PrismRes = new PrismRes(prismBlocks, res.getBackground(), res.getDefaultFontColor())
  return prismRes
}

@Sendable
export class PrismRes {
  list: collections.Array<PrismBlock> = new collections.Array<PrismBlock>()
  background: number = 0
  defaultFontColor: number = 0

  constructor(list: collections.Array<PrismBlock>, background: number, defaultFontColor: number) {
    this.list = list
    this.background = background
    this.defaultFontColor = defaultFontColor
  }

  /**
   * 获取代码块整体背景色
   *
   * @return 返回代码块整体背景色
   */
  getBackground(): number {
    return this.background
  }

  /**
   * 获取代码块默认文本颜色
   *
   * @return 返回代码块默认文本颜色
   */
  getDefaultFontColor(): number {
    return this.defaultFontColor
  }

  /**
   * 获取块文本内容
   *
   * @return 返回块文本内容
   */
  getListColor(): collections.Array<PrismBlock> {
    return this.list
  }

  addNode(res: PrismNode): void {
    if (this.list.length <= 0) {
      this.list.push(new PrismBlock())
    }
    let prismBlock: PrismBlock = this.list[this.list.length -1]
    prismBlock.list.push(res)
    prismBlock.text += res.text
  }

  addBlock(): void {
    this.list.push(new PrismBlock())
  }
}

@Sendable
export class PrismBlock {
  text: string = ''
  list: collections.Array<PrismNode> = new collections.Array<PrismNode>()

  /**
   * 获取块文本内容
   *
   * @return 返回块文本内容
   */
  getText(): string {
    return this.text
  }

  /**
   * 获取块的子节点列表信息
   *
   * @return 返回块的子节点列表信息
   */
  getList(): collections.Array<PrismNode> {
    return this.list
  }
}

@Sendable
export class PrismNode {
  types: string = ""
  text: string = ""
  alias: string | undefined = undefined
  color: number | undefined = undefined

  constructor(types: string, text: string, alias: string | undefined, color: number | undefined) {
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