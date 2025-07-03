import { CustomLib, PrismNodesParseResColorArkts } from "libark_interop_api_prism.so";
import { requireCJLib } from "libark_interop_loader.so";

let lib = requireCJLib("libprism4cj.so") as CustomLib

export function codeStringToColorString(code: string, info: string | undefined, isDarkula: boolean): Promise<PrismNodesParseResColorArkts> {
  return lib.codeStringToColorStringArkts(code, info, isDarkula)
}

export function codeStringToColorStringCustomize(code: string, info: string | undefined, background: number, text: number, colorMap: Map<PrismColor, number>): Promise<PrismNodesParseResColorArkts> {
  let map: Map<string, number> = new Map<string, number>()
  colorMap.forEach(
    (value: number, key: PrismColor) => {
      map.set(key.toString(), value)
    }
  )
  const promise: Promise<PrismNodesParseResColorArkts> = new Promise((resolve: Function, reject: Function) => {
    setTimeout(() => {
      resolve(lib.codeStringToColorStringCustomizeArkts(code, info, background, text, map));
    }, 0);
  })
  return promise
}

export enum PrismColor {
  COMMENT = "COMMENT", // 注释内容
  PROLOG = "PROLOG", // Prolog 语言中的特定语法结构（如谓词定义）
  DOCTYPE = "DOCTYPE", // 文档类型声明: 如 HTML 的 <!DOCTYPE html>
  CDATA = "CDATA", // XML/HTML 中的字符数据块，用于包裹无需解析的原始文本
  PUNCTUATION = "PUNCTUATION", // 标点符号
  PROPERTY = "PROPERTY", // CSS/SCSS 中的属性名
  TAG = "TAG", // HTML/XML 标签
  BOOLEAN = "BOOLEAN", // 布尔值（true/false）
  NUMBER = "NUMBER", // 数值内容
  CONSTANT = "CONSTANT", // 常量
  SYMBOL = "SYMBOL", // 符号或特殊符号
  DELETED = "DELETED", // 版本控制差异中标记为删除的代码行或片段
  SELECTOR = "SELECTOR", // CSS/SCSS 选择器
  ATTR_NAME = "ATTR-NAME", // HTML/XML 属性的名称
  STRING = "STRING", // 单引号或双引号包裹的内容
  CHAR = "CHAR", // 字符字面量，如 char c = 'A'
  BUILTIN = "BUILTIN", // 语言内置的函数或类型
  INSERTED = "INSERTED", // 版本控制差异中标记为新增的代码行或片段
  OPERATOR = "OPERATOR", // 运算符
  URL = "URL", // 代码中的 URL 字符串
  ENTITY = "ENTITY", // HTML/XML 实体
  ATRULE = "ATRULE", // CSS 预处理器
  ATTR_VALUE = "ATTR-VALUE", // HTML/XML 属性的值
  KEYWORD = "KEYWORD", // 语言的关键字
  FUNCTION = "FUNCTION", // 函数名或方法名
  CLASS_NAME = "CLASS-NAME", // 类名
  REGEX = "REGEX", // 正则表达式模式
  IMPORTANT = "IMPORTANT", // CSS 中的 !important 关键字
  VARIABLE = "VARIABLE", // 变量名
  DELIMITER = "DELIMITER", // 代码中的分隔符号
  ANNOTATION = "ANNOTATION", // 代码中的注解或装饰性标记
  ESCAPE_SEQ = "ESCAPE_SEQ", // 转义序列
  GENERIC_METHOD = "GENERIC-METHOD", // 泛型方法声明
  PSEUDO_ELEMENT = "PSEUDO-ELEMENT", // CSS 伪元素
  PSEUDO_CLASS = "PSEUDO-CLASS", // CSS 伪类
  CLASS = "CLASS", // HTML/CSS/TypeScript 等的类名
  ID = "ID", // CSS 中的 ID 选择器
  ATTRIBUTE = "ATTRIBUTE", // 属性名称(如 HTML 的 id="main" 或 XML 的 attr="value")
  HEXCODE = "HEXCODE", // 十六进制颜色值
  COMMAND = "COMMAND", // 命令行工具指令
  PARAMETER = "PARAMETER", // 函数或方法的参数名
  COORD = "COORD", // 坐标数值，SVG/XML 或图形处理代码
  COMMIT_SHA1 = "COMMIT_SHA1", // 版本控制中的提交哈希值
  SPOCK_BLOCK = "SPOCK-BLOCK", // Groovy 的 Spock 测试框架中的测试块
  NULL = "NULL", // 空值标识
  NAMESPACE = "NAMESPACE", // 命名空间
  SHEBANG = "SHEBANG", // 脚本文件开头的 #! 行
  DEFAULT = "DEFAULT" // 其它值
}
