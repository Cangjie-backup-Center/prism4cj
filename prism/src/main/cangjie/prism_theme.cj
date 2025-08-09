/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package prism4cj

/**
 * prism 主题接口
 */
public interface PrismTheme {
    /**
     * 获取背景色
     *
     * @return UInt32 返回背景色
     */
    func background(): UInt32

    /**
     * 设置背景色
     *
     * @param bg 背景色值
     */
    func setBackground(bg: UInt32): Unit

    /**
     * 获取文本颜色
     *
     * @return UInt32 返回文本颜色
     */
    func textColor(): UInt32

    /**
     * 设置文本颜色
     *
     * @param text 文本颜色
     */
    func setTextColor(text: UInt32): Unit

    /**
     * 获取字段颜色存储集合
     *
     * @return HashMap<PrismColor, Color> 返回颜色存储集合
     */
    func getColorMap(): HashMap<String, UInt32>

    /**
     * 自定义设置字段颜色存储集合
     *
     * @param HashMap<PrismColor, Color> 颜色存储集合
     */
    func setColorMap(colorMap: HashMap<String, UInt32>): Unit
}

/**
 * prism 主题抽象基类
 */
public abstract open class PrismThemeBase <: PrismTheme {
    static func applyAlpha(alpha: UInt32, color: UInt32): UInt32 {
        // 清除原有的 alpha 通道值，保留原有的 RGB 通道值
        let colorWithoutAlpha: UInt32 = color & 0x00FFFFFF
        // 将指定的 alpha 值左移 24 位
        let alphaShifted: UInt32 = alpha << 24
        // 将新的 alpha 通道值与原有的 RGB 通道值进行合并
        let finalColor: UInt32 = colorWithoutAlpha | alphaShifted
        // 返回新的颜色值
        return finalColor
    }

    static func applyAlpha(alpha: Float64, color: UInt32): UInt32 {
        // 将浮点数类型的 alpha 值转换为整数类型，并调用之前的 applyAlpha 方法
        let alphaInt: UInt32 = UInt32(255.0 * alpha + 0.5)
        return applyAlpha(alphaInt, color)
    }

    static func isOfType(expected: String, types: String, alias: ?String): Bool {
        return expected == types || expected == match (alias) {
            case Some(v) => v
            case None => ""
        }
    }
}

/**
 *  prism 默认主题类
 */
public class PrismThemeDefault <: PrismThemeBase {

    // 背景颜色
    var bg: UInt32
    var colorMap: HashMap<String, UInt32>
    // 文本颜色
    var text: UInt32

    init(background: UInt32, colorMap: HashMap<String, UInt32>, text: UInt32) {
        this.bg = background
        this.colorMap = colorMap
        this.text = text
    }

    /**
     * 创建 PrismThemeDefault 对象的静态方法
     *
     * @return 返回一个默认背景色的主题
     */
    public static func create(): PrismThemeDefault {
        return PrismThemeDefault(0xFFf5f2f0, ColorHashMap().initDefaultColor(), 0xdd000000)
    }

    /**
     * 创建 PrismThemeDarkula 对象的静态方法
     *
     * @param 传入背景色
     * @return 返回自定义背景色的主题
     */
    static func create(background: UInt32, text: UInt32): PrismThemeDefault {
        return PrismThemeDefault(background, ColorHashMap().initDefaultColor(), text)
    }

    /**
     * 获取背景色
     *
     * @return 返回背景色
     */
    public func background(): UInt32 {
        return this.bg
    }

    /**
     * 设置背景色
     *
     * @param bg 背景色值
     */
    public func setBackground(bg: UInt32): Unit {
        this.bg = bg
    }

    /**
     * 获取默认文本颜色
     *
     * @return 返回文本颜色
     */
    public func textColor(): UInt32 {
        return this.text
    }

    /**
     * 设置文本颜色
     *
     * @param text 文本颜色
     */
    public func setTextColor(text: UInt32): Unit {
        this.text = text
    }

    /**
     * 获取颜色存储集合
     *
     * @return HashMap<PrismColor, Color> 返回颜色存储集合
     */
    public open override func getColorMap(): HashMap<String, UInt32> {
        return this.colorMap
    }

    /**
     * 自定义设置颜色存储集合
     *
     * @param HashMap<PrismColor, Color> 颜色存储集合
     */
    public open override func setColorMap(colorMap: HashMap<String, UInt32>): Unit {
        this.colorMap = colorMap
    }
}

/**
 *  prism 暗黑主题类
 */
public class PrismThemeDarkula <: PrismThemeBase {
    // 背景颜色
    var bg: UInt32
    var colorMap: HashMap<String, UInt32>
    // 文本颜色
    var text: UInt32

    /**
     * PrismThemeDarkula 构造函数
     *
     * @param background 背景
     * @param colorMap  颜色存储集合
     * @param text 文本颜色
     */
    init(background: UInt32, colorMap: HashMap<String, UInt32>, text: UInt32) {
        this.bg = background
        this.colorMap = colorMap
        this.text = text
    }

    /**
     * 创建 PrismThemeDarkula 对象的静态方法
     *
     * @return 返回一个默认背景色的暗黑主题
     */
    public static func create(): PrismThemeDarkula {
        return PrismThemeDarkula(0xFF2d2d2d, ColorHashMap().initDarkulaColor(), 0xFFa9b7c6)
    }

    /**
     * 创建 PrismThemeDarkula 对象的静态方法
     *
     * @param 传入背景色
     * @return 返回自定义背景色的暗黑主题
     */
    static func create(background: UInt32, text: UInt32): PrismThemeDarkula {
        return PrismThemeDarkula(background, ColorHashMap().initDarkulaColor(), text)
    }

    /**
     * 获取背景色
     *
     * @return 返回背景色
     */
    public func background(): UInt32 {
        return this.bg
    }

    /**
     * 设置背景色
     *
     * @param bg 背景色值
     */
    public func setBackground(bg: UInt32): Unit {
        this.bg = bg
    }

    /**
     * 获取默认文本颜色
     *
     * @return 返回文本颜色
     */
    public func textColor(): UInt32 {
        return this.text
    }

    /**
     * 设置文本颜色
     *
     * @param text 文本颜色
     */
    public func setTextColor(text: UInt32): Unit {
        this.text = text
    }

    /**
     * 获取颜色存储集合
     *
     * @return HashMap<PrismColor, UInt32> 返回颜色存储集合
     */
    public open override func getColorMap(): HashMap<String, UInt32> {
        return this.colorMap
    }

    /**
     * 自定义设置颜色存储集合
     *
     * @param HashMap<PrismColor, UInt32> 颜色存储集合
     */
    public open override func setColorMap(colorMap: HashMap<String, UInt32>): Unit {
        this.colorMap = colorMap
    }
}

/**
 * 代码颜色值存储集合
 */
public class ColorHashMap {
    var colorMap: HashMap<String, UInt32>

    func initDefaultColor(): HashMap<String, UInt32> {
        this.colorMap = HashMap<String, UInt32>()
        this.colorMap.add("comment", 0xFF708090)
        this.colorMap.add("prolog", 0xFF708090)
        this.colorMap.add("doctype", 0xFF708090)
        this.colorMap.add("cdata", 0xFF708090)
        this.colorMap.add("punctuation", 0xFF999999)
        this.colorMap.add("property", 0xFF990055)
        this.colorMap.add("tag", 0xFF990055)
        this.colorMap.add("boolean", 0xFF990055)
        this.colorMap.add("number", 0xFF990055)
        this.colorMap.add("constant", 0xFF990055)
        this.colorMap.add("symbol", 0xFF990055)
        this.colorMap.add("deleted", 0xFF990055)
        this.colorMap.add("selector", 0xFF669900)
        this.colorMap.add("attr-name", 0xFF669900)
        this.colorMap.add("string", 0xFF669900)
        this.colorMap.add("char", 0xFF669900)
        this.colorMap.add("builtin", 0xFF669900)
        this.colorMap.add("inserted", 0xFF669900)
        this.colorMap.add("operator", 0xFF9a6e3a)
        this.colorMap.add("url", 0xFF9a6e3a)
        this.colorMap.add("entity", 0xFF9a6e3a)
        this.colorMap.add("atrule", 0xFF0077aa)
        this.colorMap.add("attr-value", 0xFF0077aa)
        this.colorMap.add("keyword", 0xFF0077aa)
        this.colorMap.add("function", 0xFFDD4A68)
        this.colorMap.add("class-name", 0xFFDD4A68)
        this.colorMap.add("regex", 0xFFee9900)
        this.colorMap.add("important", 0xFFee9900)
        this.colorMap.add("variable", 0xFFee9900)
        this.colorMap.add("delimiter", 0xFF669900)
        this.colorMap.add("annotation", 0xFF669900)
        this.colorMap.add("escape_seq", 0xFF669900)
        this.colorMap.add("generic-method", 0xFF669900)
        this.colorMap.add("pseudo-element", 0xFF669900)
        this.colorMap.add("pseudo-class", 0xFF669900)
        this.colorMap.add("class", 0xFF669900)
        this.colorMap.add("id", 0xFF9a6e3a)
        this.colorMap.add("attribute", 0xFF9a6e3a)
        this.colorMap.add("hexcode", 0xFF9a6e3a)
        this.colorMap.add("command", 0xFF0077aa)
        this.colorMap.add("parameter", 0xFF0077aa)
        this.colorMap.add("coord", 0xFF0077aa)
        this.colorMap.add("commit_sha1", 0xFFDD4A68)
        this.colorMap.add("spock-block", 0xFFDD4A68)
        this.colorMap.add("null", 0xFFee9900)
        this.colorMap.add("namespace", 0xFFee9900)
        this.colorMap.add("shebang", 0xFFee9900)
        return this.colorMap
    }

    func initDarkulaColor(): HashMap<String, UInt32> {
        this.colorMap = HashMap<String, UInt32>()
        this.colorMap.add("comment", 0xFF808080)
        this.colorMap.add("prolog", 0xFF808080)
        this.colorMap.add("cdata", 0xFF808080)
        this.colorMap.add("delimiter", 0xFFcc7832)
        this.colorMap.add("boolean", 0xFFcc7832)
        this.colorMap.add("keyword", 0xFFcc7832)
        this.colorMap.add("selector", 0xFFcc7832)
        this.colorMap.add("important", 0xFFcc7832)
        this.colorMap.add("atrule", 0xFFcc7832)
        this.colorMap.add("operator", 0xFFa9b7c6)
        this.colorMap.add("punctuation", 0xFFa9b7c6)
        this.colorMap.add("attr-name", 0xFFa9b7c6)
        this.colorMap.add("tag", 0xFFe8bf6a)
        this.colorMap.add("doctype", 0xFFe8bf6a)
        this.colorMap.add("builtin", 0xFFe8bf6a)
        this.colorMap.add("entity", 0xFF6897bb)
        this.colorMap.add("number", 0xFF6897bb)
        this.colorMap.add("symbol", 0xFF6897bb)
        this.colorMap.add("property", 0xFF9876aa)
        this.colorMap.add("constant", 0xFF9876aa)
        this.colorMap.add("variable", 0xFF9876aa)
        this.colorMap.add("string", 0xFF6a8759)
        this.colorMap.add("char", 0xFF6a8759)
        this.colorMap.add("annotation", 0xFFbbb438)
        this.colorMap.add("attr-value", 0xFFa5c261)
        this.colorMap.add("url", 0xFF287bde)
        this.colorMap.add("function", 0xFFffc66d)
        this.colorMap.add("class-name", 0xFFffc66d)
        this.colorMap.add("regex", 0xFF364135)
        this.colorMap.add("inserted", 0xFF294436)
        this.colorMap.add("deleted", 0xFF484a4a)
        this.colorMap.add("escape_seq", 0xFFe8bf6a)
        this.colorMap.add("generic-method", 0xFF6897bb)
        this.colorMap.add("pseudo-element", 0xFF6897bb)
        this.colorMap.add("pseudo-class", 0xFF6897bb)
        this.colorMap.add("class", 0xFF9876aa)
        this.colorMap.add("id", 0xFF9876aa)
        this.colorMap.add("attribute", 0xFF9876aa)
        this.colorMap.add("hexcode", 0xFF6a8759)
        this.colorMap.add("command", 0xFF6a8759)
        this.colorMap.add("parameter", 0xFFbbb438)
        this.colorMap.add("coord", 0xFFa5c261)
        this.colorMap.add("commit_sha1", 0xFF287bde)
        this.colorMap.add("spock-block", 0xFFffc66d)
        this.colorMap.add("null", 0xFF364135)
        this.colorMap.add("namespace", 0xFF294436)
        this.colorMap.add("shebang", 0xFF484a4a)
        return this.colorMap
    }

    init() {
        this.colorMap = HashMap<String, UInt32>()
    }

    /**
     * ColorHashmap 构造函数
     *
     * @param map 默认或是自定义的 colorMap
     */
    public init(map: HashMap<String, UInt32>) {
        this.colorMap = map
    }

    /**
     * 获取 colormap 属性
     */
    public func getColorMap(): HashMap<String, UInt32> {
        return this.colorMap
    }
}

/**
 * 围栏代码块高亮枚举类
 */
public enum PrismColor <: Hashable & Equatable<PrismColor> {
    COMMENT |
    PROLOG |
    DOCTYPE |
    CDATA |
    PUNCTUATION |
    PROPERTY |
    TAG |
    BOOLEAN |
    NUMBER |
    CONSTANT |
    SYMBOL |
    DELETED |
    SELECTOR |
    ATTR_NAME |
    STRING |
    CHAR |
    BUILTIN |
    INSERTED |
    OPERATOR |
    URL |
    ENTITY |
    ATRULE |
    ATTR_VALUE |
    KEYWORD |
    FUNCTION |
    CLASS_NAME |
    REGEX |
    IMPORTANT |
    VARIABLE |
    DELIMITER |
    ANNOTATION |
    ESCAPE_SEQ |
    GENERIC_METHOD |
    PSEUDO_ELEMENT |
    PSEUDO_CLASS |
    CLASS |
    ID |
    ATTRIBUTE |
    HEXCODE |
    COMMAND |
    PARAMETER |
    COORD |
    COMMIT_SHA1 |
    SPOCK_BLOCK |
    NULL |
    NAMESPACE |
    SHEBANG |
    DEFAULT

    public operator func ==(that: PrismColor): Bool {
        match ((this, that)) {
            case (COMMENT, COMMENT) => true
            case (PROLOG, PROLOG) => true
            case (DOCTYPE, DOCTYPE) => true
            case (CDATA, CDATA) => true
            case (PUNCTUATION, PUNCTUATION) => true
            case (PROPERTY, PROPERTY) => true
            case (TAG, TAG) => true
            case (BOOLEAN, BOOLEAN) => true
            case (NUMBER, NUMBER) => true
            case (CONSTANT, CONSTANT) => true
            case (SYMBOL, SYMBOL) => true
            case (DELETED, DELETED) => true
            case (SELECTOR, SELECTOR) => true
            case (ATTR_NAME, ATTR_NAME) => true
            case (STRING, STRING) => true
            case (CHAR, CHAR) => true
            case (BUILTIN, BUILTIN) => true
            case (INSERTED, INSERTED) => true
            case (OPERATOR, OPERATOR) => true
            case (URL, URL) => true
            case (ENTITY, ENTITY) => true
            case (ATRULE, ATRULE) => true
            case (ATTR_VALUE, ATTR_VALUE) => true
            case (KEYWORD, KEYWORD) => true
            case (FUNCTION, FUNCTION) => true
            case (CLASS_NAME, CLASS_NAME) => true
            case (REGEX, REGEX) => true
            case (IMPORTANT, IMPORTANT) => true
            case (VARIABLE, VARIABLE) => true
            case (DELIMITER, DELIMITER) => true
            case (ANNOTATION, ANNOTATION) => true
            case (ESCAPE_SEQ, ESCAPE_SEQ) => true
            case (GENERIC_METHOD, GENERIC_METHOD) => true
            case (PSEUDO_ELEMENT, PSEUDO_ELEMENT) => true
            case (PSEUDO_CLASS, PSEUDO_CLASS) => true
            case (CLASS, CLASS) => true
            case (ID, ID) => true
            case (ATTRIBUTE, ATTRIBUTE) => true
            case (HEXCODE, HEXCODE) => true
            case (COMMAND, COMMAND) => true
            case (PARAMETER, PARAMETER) => true
            case (COORD, COORD) => true
            case (COMMIT_SHA1, COMMIT_SHA1) => true
            case (SPOCK_BLOCK, SPOCK_BLOCK) => true
            case (NULL, NULL) => true
            case (NAMESPACE, NAMESPACE) => true
            case (SHEBANG, SHEBANG) => true
            case (DEFAULT, DEFAULT) => true
            case _ => false
        }
    }

    public operator func !=(that: PrismColor): Bool {
        return !(this == that)
    }

    public static func fromInt(index:Int64):PrismColor{
        return match (index) {
        	case 0 => PrismColor.COMMENT
        	case 1 => PrismColor.PROLOG
        	case 2 => PrismColor.DOCTYPE
        	case 3 => PrismColor.CDATA
        	case 4 => PrismColor.PUNCTUATION
        	case 5 => PrismColor.PROPERTY
        	case 6 => PrismColor.TAG
        	case 7 => PrismColor.BOOLEAN
        	case 8 => PrismColor.NUMBER
        	case 9 => PrismColor.CONSTANT
        	case 10 => PrismColor.SYMBOL
        	case 11 => PrismColor.DELETED
        	case 12 => PrismColor.SELECTOR
        	case 13 => PrismColor.ATTR_NAME
        	case 14 => PrismColor.STRING
        	case 15 => PrismColor.CHAR
        	case 16 => PrismColor.BUILTIN
        	case 17 => PrismColor.INSERTED
        	case 18 => PrismColor.OPERATOR
        	case 19 => PrismColor.URL
        	case 20 => PrismColor.ENTITY
        	case 21 => PrismColor.ATRULE
        	case 22 => PrismColor.ATTR_VALUE
        	case 23 => PrismColor.KEYWORD
        	case 24 => PrismColor.FUNCTION
        	case 25 => PrismColor.CLASS_NAME
        	case 26 => PrismColor.REGEX
        	case 27 => PrismColor.IMPORTANT
        	case 28 => PrismColor.VARIABLE
        	case 29 => PrismColor.DELIMITER
        	case 30 => PrismColor.ANNOTATION
        	case 31 => PrismColor.ESCAPE_SEQ
        	case 32 => PrismColor.GENERIC_METHOD
        	case 33 => PrismColor.PSEUDO_ELEMENT
        	case 34 => PrismColor.PSEUDO_CLASS
        	case 35 => PrismColor.CLASS
        	case 36 => PrismColor.ID
        	case 37 => PrismColor.ATTRIBUTE
        	case 38 => PrismColor.HEXCODE
        	case 39 => PrismColor.COMMAND
        	case 40 => PrismColor.PARAMETER
        	case 41 => PrismColor.COORD
        	case 42 => PrismColor.COMMIT_SHA1
        	case 43 => PrismColor.SPOCK_BLOCK
        	case 44 => PrismColor.NULL
        	case 45 => PrismColor.NAMESPACE
        	case 46 => PrismColor.SHEBANG
            case _ => PrismColor.DEFAULT
        }
    }

    public func toInt():Int64{
        return match(this) {
            case COMMENT => 0
            case PROLOG => 1
            case DOCTYPE => 2
            case CDATA => 3
            case PUNCTUATION => 4
            case PROPERTY => 5
            case TAG => 6
            case BOOLEAN => 7
            case NUMBER => 8
            case CONSTANT => 9
            case SYMBOL => 10
            case DELETED => 11
            case SELECTOR => 12
            case ATTR_NAME => 13
            case STRING => 14
            case CHAR => 15
            case BUILTIN => 16
            case INSERTED => 17
            case OPERATOR => 18
            case URL => 19
            case ENTITY => 20
            case ATRULE => 21
            case ATTR_VALUE => 22
            case KEYWORD => 23
            case FUNCTION => 24
            case CLASS_NAME => 25
            case REGEX => 26
            case IMPORTANT => 27
            case VARIABLE => 28
            case DELIMITER => 29
            case ANNOTATION => 30
            case ESCAPE_SEQ => 31
            case GENERIC_METHOD => 32
            case PSEUDO_ELEMENT => 33
            case PSEUDO_CLASS => 34
            case CLASS => 35
            case ID => 36
            case ATTRIBUTE => 37
            case HEXCODE => 38
            case COMMAND => 39
            case PARAMETER => 40
            case COORD => 41
            case COMMIT_SHA1 => 42
            case SPOCK_BLOCK => 43
            case NULL => 44
            case NAMESPACE => 45
            case SHEBANG => 46
            case DEFAULT => 47
        }
    }

    public static func fromString(str: String): PrismColor {
        return match (str) {
        	case "comment" => PrismColor.COMMENT
        	case "prolog" => PrismColor.PROLOG
        	case "doctype" => PrismColor.DOCTYPE
        	case "cdata" => PrismColor.CDATA
        	case "punctuation" => PrismColor.PUNCTUATION
        	case "property" => PrismColor.PROPERTY
        	case "tag" => PrismColor.TAG
        	case "boolean" => PrismColor.BOOLEAN
        	case "number" => PrismColor.NUMBER
        	case "constant" => PrismColor.CONSTANT
        	case "symbol" => PrismColor.SYMBOL
        	case "deleted" => PrismColor.DELETED
        	case "selector" => PrismColor.SELECTOR
        	case "attr-name" => PrismColor.ATTR_NAME
        	case "string" => PrismColor.STRING
        	case "char" => PrismColor.CHAR
        	case "builtin" => PrismColor.BUILTIN
        	case "inserted" => PrismColor.INSERTED
        	case "operator" => PrismColor.OPERATOR
        	case "url" => PrismColor.URL
        	case "entity" => PrismColor.ENTITY
        	case "atrule" => PrismColor.ATRULE
        	case "attr-value" => PrismColor.ATTR_VALUE
        	case "keyword" => PrismColor.KEYWORD
        	case "function" => PrismColor.FUNCTION
        	case "class-name" => PrismColor.CLASS_NAME
        	case "regex" => PrismColor.REGEX
        	case "important" => PrismColor.IMPORTANT
        	case "variable" => PrismColor.VARIABLE
        	case "delimiter" => PrismColor.DELIMITER
        	case "annotation" => PrismColor.ANNOTATION
        	case "escape_seq" => PrismColor.ESCAPE_SEQ
        	case "generic-method" => PrismColor.GENERIC_METHOD
        	case "pseudo-element" => PrismColor.PSEUDO_ELEMENT
        	case "pseudo-class" => PrismColor.PSEUDO_CLASS
        	case "class" => PrismColor.CLASS
        	case "id" => PrismColor.ID
        	case "attribute" => PrismColor.ATTRIBUTE
        	case "hexcode" => PrismColor.HEXCODE
        	case "command" => PrismColor.COMMAND
        	case "parameter" => PrismColor.PARAMETER
        	case "coord" => PrismColor.COORD
        	case "commit_sha1" => PrismColor.COMMIT_SHA1
        	case "spock-block" => PrismColor.SPOCK_BLOCK
        	case "null" => PrismColor.NULL
        	case "namespace" => PrismColor.NAMESPACE
        	case "shebang" => PrismColor.SHEBANG
            case _ => PrismColor.DEFAULT
        }
    }

    public func toString(): String {
        return match(this) {
            case COMMENT => "comment"
            case PROLOG => "prolog"
            case DOCTYPE => "doctype"
            case CDATA => "cdata"
            case PUNCTUATION => "punctuation"
            case PROPERTY => "property"
            case TAG => "tag"
            case BOOLEAN => "boolean"
            case NUMBER => "number"
            case CONSTANT => "constant"
            case SYMBOL => "symbol"
            case DELETED => "deleted"
            case SELECTOR => "selector"
            case ATTR_NAME => "attr-name"
            case STRING => "string"
            case CHAR => "char"
            case BUILTIN => "builtin"
            case INSERTED => "inserted"
            case OPERATOR => "operator"
            case URL => "url"
            case ENTITY => "entity"
            case ATRULE => "atrule"
            case ATTR_VALUE => "attr-value"
            case KEYWORD => "keyword"
            case FUNCTION => "function"
            case CLASS_NAME => "class-name"
            case REGEX => "regex"
            case IMPORTANT => "important"
            case VARIABLE => "variable"
            case DELIMITER => "delimiter"
            case ANNOTATION => "annotation"
            case ESCAPE_SEQ => "escape_seq"
            case GENERIC_METHOD => "generic-method"
            case PSEUDO_ELEMENT => "pseudo-element"
            case PSEUDO_CLASS => "pseudo-class"
            case CLASS => "class"
            case ID => "id"
            case ATTRIBUTE => "attribute"
            case HEXCODE => "hexcode"
            case COMMAND => "command"
            case PARAMETER => "parameter"
            case COORD => "coord"
            case COMMIT_SHA1 => "commit_sha1"
            case SPOCK_BLOCK => "spock-block"
            case NULL => "null"
            case NAMESPACE => "namespace"
            case SHEBANG => "shebang"
            case DEFAULT => "default"
        }
    }

    @OverflowWrapping
    public func hashCode(): Int64 {
        return toString().hashCode()
    }
}
