# prism4cj 库

```ets
/**
 * 通过代码内容和代码类型和深浅色模式设置不同标记颜色
 *
 * @param code 代码内容
 * @param info 代码类型
 * @param isDarkula 是否深色模式
 * @return Promise<PrismRes> 返回代码颜色标记对象
 */
export async function codeStringToColorString(code: string, info: string | undefined, isDarkula: boolean): Promise<PrismRes>

/**
 * 自定义设置不同标记颜色
 *
 * @param code 代码内容
 * @param info 代码类型
 * @param background 背景颜色
 * @param text 默认文本颜色
 * @param colorMap 颜色map
 * @return PrismRes 返回代码颜色标记对象
 */
export function codeStringToColorStringCustomize(code: string, info: string | undefined, background: number, text: number, colorMap: Map<PrismColor, number>): PrismRes

/**
 * 代码颜色标记对象
 */
@Sendable
export class PrismRes {
  /**
   * 获取代码块整体背景色
   *
   * @return 返回代码块整体背景色
   */
  getBackground(): number

  /**
   * 获取代码块默认文本颜色
   *
   * @return 返回代码块默认文本颜色
   */
  getDefaultFontColor(): number

  /**
   * 获取块文本内容
   *
   * @return 返回块文本内容
   */
  getListColor(): collections.Array<PrismBlock>
}

/**
 * 每一行文本标记内容
 */
@Sendable
export class PrismBlock {
  /**
   * 获取块文本内容
   *
   * @return 返回块文本内容
   */
  getText(): string

  /**
   * 获取块的子节点列表信息
   *
   * @return 返回块的子节点列表信息
   */
  getList(): collections.Array<PrismNode>
}

/**
 * 一行的文本的文本标记
 */
@Sendable
export class PrismNode {
  /**
   * 获取结果对象类型
   *
   * @return 返回结果对象的类型
   */
  getType(): string

  /**
   * 获取结果对象文本
   *
   * @return 返回结果对象的文本信息
   */
  getText(): string

  /**
   * 获取结果对象别名
   *
   * @return 返回结果对象的别名
   */
  getAlias(): string | undefined

  /**
   * 获取结果对象文本对应的颜色
   *
   * @return 返回结果对象文本对应的颜色
   */
  getColor(): number | undefined
}

/**
 * 代码类型枚举
 */
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
```