/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package prism4cj

class MyPrismTheme <: PrismThemeBase {
    // 背景颜色
    var bg: UInt32
    // 颜色map
    var colorMap: HashMap<String, UInt32>
    // 文本颜色
    var text: UInt32

    init(background: UInt32, colorMap: HashMap<String, UInt32>, text: UInt32) {
        this.bg = background
        this.colorMap = colorMap
        this.text = text
    }

    /**
     * 创建 PrismThemeDarkula 对象的静态方法
     *
     * @return 返回一个默认背景色的主题
     */
    public static func create(background: UInt32, colorMap: HashMap<String, UInt32>, text: UInt32): MyPrismTheme {
        return MyPrismTheme(background, colorMap, text)
    }

    /**
     * 获取背景色
     *
     * @return 返回背景色
     */
    public override func background(): UInt32 {
        return this.bg
    }

    /**
     * 设置背景色
     * @param bg 背景色值
     */
    public override func setBackground(bg: UInt32): Unit {
        this.bg = bg
    }

    /**
     * 获取默认文本颜色
     *
     * @return 返回文本颜色
     */
    public override func textColor(): UInt32 {
        return this.text
    }

    /**
     * 设置文本颜色
     * @param text 文本颜色
     */
    public override func setTextColor(text: UInt32): Unit {
        this.text = text
    }

    /**
     * 获取颜色存储集合
     * @return HashMap<String, Color> 返回颜色存储集合
     */
    public override func getColorMap(): HashMap<String, UInt32> {
        return this.colorMap
    }

    /**
     * 自定义设置颜色存储集合
     * @param HashMap<String, Color> 颜色存储集合
     */
    public override func setColorMap(colorMap: HashMap<String, UInt32>): Unit {
        this.colorMap = colorMap
    }
}
