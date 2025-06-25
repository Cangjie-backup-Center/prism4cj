/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package prism4cj

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * prism 主题接口
 */
public interface PrismTheme {
    /**
     * 获取背景色
     *
     * @return UInt32 返回背景色
     */
    func background(): Color

    /**
     * 设置背景色
     *
     * @param bg 背景色值
     */
    func setBackground(bg: Color): Unit

    /**
     * 获取文本颜色
     *
     * @return UInt32 返回文本颜色
     */
    func textColor(): Color

    /**
     * 设置文本颜色
     *
     * @param text 文本颜色
     */
    func setTextColor(text: Color): Unit

    /**
     * 获取字段颜色存储集合
     *
     * @return HashMap<PrismColor, Color> 返回颜色存储集合
     */
    func getColorMap(): HashMap<PrismColor, Color>

    /**
     * 自定义设置字段颜色存储集合
     *
     * @param HashMap<PrismColor, Color> 颜色存储集合
     */
    func setColorMap(colorMap: HashMap<PrismColor, Color>): Unit
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
    var bg: Color
    var colorMap: HashMap<PrismColor, Color>
    // 文本颜色
    var text: Color

    init(background: Color, colorMap: HashMap<PrismColor, Color>, text: Color) {
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
        return PrismThemeDefault(Color(0xFFf5f2f0), ColorHashMap().initDefaultColor(), Color(0xdd000000))
    }

    /**
     * 创建 PrismThemeDarkula 对象的静态方法
     *
     * @param 传入背景色
     * @return 返回自定义背景色的主题
     */
    static func create(background: Color, text: Color): PrismThemeDefault {
        return PrismThemeDefault(background, ColorHashMap().initDefaultColor(), text)
    }

    /**
     * 获取背景色
     *
     * @return 返回背景色
     */
    public func background(): Color {
        return this.bg
    }

    /**
     * 设置背景色
     *
     * @param bg 背景色值
     */
    public func setBackground(bg: Color): Unit {
        this.bg = bg
    }

    /**
     * 获取默认文本颜色
     *
     * @return 返回文本颜色
     */
    public func textColor(): Color {
        return this.text
    }

    /**
     * 设置文本颜色
     *
     * @param text 文本颜色
     */
    public func setTextColor(text: Color): Unit {
        this.text = text
    }

    /**
     * 获取颜色存储集合
     *
     * @return HashMap<PrismColor, Color> 返回颜色存储集合
     */
    public open override func getColorMap(): HashMap<PrismColor, Color> {
        return this.colorMap
    }

    /**
     * 自定义设置颜色存储集合
     *
     * @param HashMap<PrismColor, Color> 颜色存储集合
     */
    public open override func setColorMap(colorMap: HashMap<PrismColor, Color>): Unit {
        this.colorMap = colorMap
    }
}

/**
 *  prism 暗黑主题类
 */
public class PrismThemeDarkula <: PrismThemeBase {
    // 背景颜色
    var bg: Color
    var colorMap: HashMap<PrismColor, Color>
    // 文本颜色
    var text: Color

    /**
     * PrismThemeDarkula 构造函数
     *
     * @param background 背景
     * @param colorMap  颜色存储集合
     * @param text 文本颜色
     */
    init(background: Color, colorMap: HashMap<PrismColor, Color>, text: Color) {
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
        return PrismThemeDarkula(Color(0xFF2d2d2d), ColorHashMap().initDarkulaColor(), Color(0xFFa9b7c6))
    }

    /**
     * 创建 PrismThemeDarkula 对象的静态方法
     *
     * @param 传入背景色
     * @return 返回自定义背景色的暗黑主题
     */
    static func create(background: Color, text: Color): PrismThemeDarkula {
        return PrismThemeDarkula(background, ColorHashMap().initDarkulaColor(), text)
    }

    /**
     * 获取背景色
     *
     * @return 返回背景色
     */
    public func background(): Color {
        return this.bg
    }

    /**
     * 设置背景色
     *
     * @param bg 背景色值
     */
    public func setBackground(bg: Color): Unit {
        this.bg = bg
    }

    /**
     * 获取默认文本颜色
     *
     * @return 返回文本颜色
     */
    public func textColor(): Color {
        return this.text
    }

    /**
     * 设置文本颜色
     *
     * @param text 文本颜色
     */
    public func setTextColor(text: Color): Unit {
        this.text = text
    }

    /**
     * 获取颜色存储集合
     *
     * @return HashMap<PrismColor, Color> 返回颜色存储集合
     */
    public open override func getColorMap(): HashMap<PrismColor, Color> {
        return this.colorMap
    }

    /**
     * 自定义设置颜色存储集合
     *
     * @param HashMap<PrismColor, Color> 颜色存储集合
     */
    public open override func setColorMap(colorMap: HashMap<PrismColor, Color>): Unit {
        this.colorMap = colorMap
    }
}

/**
 * 代码颜色值存储集合
 */
public class ColorHashMap {
    var colorMap: HashMap<PrismColor, Color>

    func initDefaultColor(): HashMap<PrismColor, Color> {
        this.colorMap = HashMap<PrismColor, Color>()
        this.colorMap.put(PrismColor.COMMENT, Color(0xFF708090))
        this.colorMap.put(PrismColor.PROLOG, Color(0xFF708090))
        this.colorMap.put(PrismColor.DOCTYPE, Color(0xFF708090))
        this.colorMap.put(PrismColor.CDATA, Color(0xFF708090))
        this.colorMap.put(PrismColor.PUNCTUATION, Color(0xFF999999))
        this.colorMap.put(PrismColor.PROPERTY, Color(0xFF990055))
        this.colorMap.put(PrismColor.TAG, Color(0xFF990055))
        this.colorMap.put(PrismColor.BOOLEAN, Color(0xFF990055))
        this.colorMap.put(PrismColor.NUMBER, Color(0xFF990055))
        this.colorMap.put(PrismColor.CONSTANT, Color(0xFF990055))
        this.colorMap.put(PrismColor.SYMBOL, Color(0xFF990055))
        this.colorMap.put(PrismColor.DELETED, Color(0xFF990055))
        this.colorMap.put(PrismColor.SELECTOR, Color(0xFF669900))
        this.colorMap.put(PrismColor.ATTR_NAME, Color(0xFF669900))
        this.colorMap.put(PrismColor.STRING, Color(0xFF669900))
        this.colorMap.put(PrismColor.CHAR, Color(0xFF669900))
        this.colorMap.put(PrismColor.BUILTIN, Color(0xFF669900))
        this.colorMap.put(PrismColor.INSERTED, Color(0xFF669900))
        this.colorMap.put(PrismColor.OPERATOR, Color(0xFF9a6e3a))
        this.colorMap.put(PrismColor.URL, Color(0xFF9a6e3a))
        this.colorMap.put(PrismColor.ENTITY, Color(0xFF9a6e3a))
        this.colorMap.put(PrismColor.ATRULE, Color(0xFF0077aa))
        this.colorMap.put(PrismColor.ATTR_VALUE, Color(0xFF0077aa))
        this.colorMap.put(PrismColor.KEYWORD, Color(0xFF0077aa))
        this.colorMap.put(PrismColor.FUNCTION, Color(0xFFDD4A68))
        this.colorMap.put(PrismColor.CLASS_NAME, Color(0xFFDD4A68))
        this.colorMap.put(PrismColor.REGEX, Color(0xFFee9900))
        this.colorMap.put(PrismColor.IMPORTANT, Color(0xFFee9900))
        this.colorMap.put(PrismColor.VARIABLE, Color(0xFFee9900))
        this.colorMap.put(PrismColor.DELIMITER, Color(0xFF669900))
        this.colorMap.put(PrismColor.ANNOTATION, Color(0xFF669900))
        this.colorMap.put(PrismColor.ESCAPE_SEQ, Color(0xFF669900))
        this.colorMap.put(PrismColor.GENERIC_METHOD, Color(0xFF669900))
        this.colorMap.put(PrismColor.PSEUDO_ELEMENT, Color(0xFF669900))
        this.colorMap.put(PrismColor.PSEUDO_CLASS, Color(0xFF669900))
        this.colorMap.put(PrismColor.CLASS, Color(0xFF669900))
        this.colorMap.put(PrismColor.ID, Color(0xFF9a6e3a))
        this.colorMap.put(PrismColor.ATTRIBUTE, Color(0xFF9a6e3a))
        this.colorMap.put(PrismColor.HEXCODE, Color(0xFF9a6e3a))
        this.colorMap.put(PrismColor.COMMAND, Color(0xFF0077aa))
        this.colorMap.put(PrismColor.PARAMETER, Color(0xFF0077aa))
        this.colorMap.put(PrismColor.COORD, Color(0xFF0077aa))
        this.colorMap.put(PrismColor.COMMIT_SHA1, Color(0xFFDD4A68))
        this.colorMap.put(PrismColor.SPOCK_BLOCK, Color(0xFFDD4A68))
        this.colorMap.put(PrismColor.NULL, Color(0xFFee9900))
        this.colorMap.put(PrismColor.NAMESPACE, Color(0xFFee9900))
        this.colorMap.put(PrismColor.SHEBANG, Color(0xFFee9900))
        return this.colorMap
    }

    func initDarkulaColor(): HashMap<PrismColor, Color> {
        this.colorMap = HashMap<PrismColor, Color>()
        this.colorMap.put(PrismColor.COMMENT, Color(0xFF808080))
        this.colorMap.put(PrismColor.PROLOG, Color(0xFF808080))
        this.colorMap.put(PrismColor.CDATA, Color(0xFF808080))
        this.colorMap.put(PrismColor.DELIMITER, Color(0xFFcc7832))
        this.colorMap.put(PrismColor.BOOLEAN, Color(0xFFcc7832))
        this.colorMap.put(PrismColor.KEYWORD, Color(0xFFcc7832))
        this.colorMap.put(PrismColor.SELECTOR, Color(0xFFcc7832))
        this.colorMap.put(PrismColor.IMPORTANT, Color(0xFFcc7832))
        this.colorMap.put(PrismColor.ATRULE, Color(0xFFcc7832))
        this.colorMap.put(PrismColor.OPERATOR, Color(0xFFa9b7c6))
        this.colorMap.put(PrismColor.PUNCTUATION, Color(0xFFa9b7c6))
        this.colorMap.put(PrismColor.ATTR_NAME, Color(0xFFa9b7c6))
        this.colorMap.put(PrismColor.TAG, Color(0xFFe8bf6a))
        this.colorMap.put(PrismColor.DOCTYPE, Color(0xFFe8bf6a))
        this.colorMap.put(PrismColor.BUILTIN, Color(0xFFe8bf6a))
        this.colorMap.put(PrismColor.ENTITY, Color(0xFF6897bb))
        this.colorMap.put(PrismColor.NUMBER, Color(0xFF6897bb))
        this.colorMap.put(PrismColor.SYMBOL, Color(0xFF6897bb))
        this.colorMap.put(PrismColor.PROPERTY, Color(0xFF9876aa))
        this.colorMap.put(PrismColor.CONSTANT, Color(0xFF9876aa))
        this.colorMap.put(PrismColor.VARIABLE, Color(0xFF9876aa))
        this.colorMap.put(PrismColor.STRING, Color(0xFF6a8759))
        this.colorMap.put(PrismColor.CHAR, Color(0xFF6a8759))
        this.colorMap.put(PrismColor.ANNOTATION, Color(0xFFbbb438))
        this.colorMap.put(PrismColor.ATTR_VALUE, Color(0xFFa5c261))
        this.colorMap.put(PrismColor.URL, Color(0xFF287bde))
        this.colorMap.put(PrismColor.FUNCTION, Color(0xFFffc66d))
        this.colorMap.put(PrismColor.CLASS_NAME, Color(0xFFffc66d))
        this.colorMap.put(PrismColor.REGEX, Color(0xFF364135))
        this.colorMap.put(PrismColor.INSERTED, Color(0xFF294436))
        this.colorMap.put(PrismColor.DELETED, Color(0xFF484a4a))
        this.colorMap.put(PrismColor.ESCAPE_SEQ, Color(0xFFe8bf6a))
        this.colorMap.put(PrismColor.GENERIC_METHOD, Color(0xFF6897bb))
        this.colorMap.put(PrismColor.PSEUDO_ELEMENT, Color(0xFF6897bb))
        this.colorMap.put(PrismColor.PSEUDO_CLASS, Color(0xFF6897bb))
        this.colorMap.put(PrismColor.CLASS, Color(0xFF9876aa))
        this.colorMap.put(PrismColor.ID, Color(0xFF9876aa))
        this.colorMap.put(PrismColor.ATTRIBUTE, Color(0xFF9876aa))
        this.colorMap.put(PrismColor.HEXCODE, Color(0xFF6a8759))
        this.colorMap.put(PrismColor.COMMAND, Color(0xFF6a8759))
        this.colorMap.put(PrismColor.PARAMETER, Color(0xFFbbb438))
        this.colorMap.put(PrismColor.COORD, Color(0xFFa5c261))
        this.colorMap.put(PrismColor.COMMIT_SHA1, Color(0xFF287bde))
        this.colorMap.put(PrismColor.SPOCK_BLOCK, Color(0xFFffc66d))
        this.colorMap.put(PrismColor.NULL, Color(0xFF364135))
        this.colorMap.put(PrismColor.NAMESPACE, Color(0xFF294436))
        this.colorMap.put(PrismColor.SHEBANG, Color(0xFF484a4a))
        return this.colorMap
    }

    init() {
        this.colorMap = HashMap<PrismColor, Color>()
    }

    /**
     * ColorHashmap 构造函数
     *
     * @param map 默认或是自定义的 colorMap
     */
    public init(map: HashMap<PrismColor, Color>) {
        this.colorMap = map
    }

    /**
     * 获取 colormap 属性
     */
    public func getColorMap(): HashMap<PrismColor, Color> {
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

    protected static func fromString(str: String): PrismColor {
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
