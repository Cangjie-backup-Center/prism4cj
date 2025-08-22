import {
  codeStringToColorStringCustomize,
  PrismColor,
  PrismRes,
  PrismBlock,
  PrismNode
} from '@cangjie-tpc/prism_hybrid';

@Entry
@Component
struct Index15 {
  @State message: string = '# 数据清洗与分析示例\n' +
    'import pandas as pd\n' +
    '\n' +
    'def analyze_sales(file_path):\n' +
    '    # 读取数据\n' +
    '    sales_data = pd.read_csv(file_path)\n' +
    '    \n' +
    '    # 基础处理\n' +
    '    clean_data = sales_data.dropna().query("amount > 0")\n' +
    '    \n' +
    '    # 分析指标\n' +
    '    metrics = {\n' +
    '        \'总销售额\': clean_data[\'amount\'].sum(),\n' +
    '        \'平均订单\': clean_data[\'amount\'].mean(),\n' +
    '        \'热门产品\': clean_data[\'product\'].mode()[0]\n' +
    '    }\n' +
    '    \n' +
    '    return pd.DataFrame.from_dict(metrics, orient=\'index\')\n' +
    '\n' +
    '# 使用示例\n' +
    'results = analyze_sales(\'sales_2024.csv\')\n' +
    'print(results)';
  @State
  list: Array<PrismBlock> = new Array<PrismBlock>()
  @State
  txtBackground: number = undefined!
  @State
  defaultFontColor: number = undefined!

   aboutToAppear(): void {
    let map: Map<PrismColor, number> = new Map(
      [
        [PrismColor.COMMENT, 0xFFD3D3D3], // 注释
        [PrismColor.PROLOG, 0xFFFFFFFF],
        [PrismColor.DOCTYPE, 0xFFFFFFFF],
        [PrismColor.CDATA, 0xFFFFFFFF],
        [PrismColor.PUNCTUATION, 0xFF00FF00], // 符号
        [PrismColor.PROPERTY, 0xFFFFFFFF],
        [PrismColor.TAG, 0xFFFFFFFF],
        [PrismColor.BOOLEAN, 0xFFFFFFFF],
        [PrismColor.NUMBER, 0xFF0000FF], // 数字
        [PrismColor.CONSTANT, 0xFFFFFFFF],
        [PrismColor.SYMBOL, 0xFFFFFFFF],
        [PrismColor.DELETED, 0xFFFFFFFF],
        [PrismColor.SELECTOR, 0xFFFFFFFF],
        [PrismColor.ATTR_NAME, 0xFFFFFFFF],
        [PrismColor.STRING, 0xFFFFFF00], // 字符串
        [PrismColor.CHAR, 0xFFFFFFFF],
        [PrismColor.BUILTIN, 0xFFFFFFFF],
        [PrismColor.INSERTED, 0xFFFFFFFF],
        [PrismColor.OPERATOR, 0xFF696969], // 符号
        [PrismColor.URL, 0xFFFFFFFF],
        [PrismColor.ENTITY, 0xFFFFFFFF],
        [PrismColor.ATRULE, 0xFFFFFFFF],
        [PrismColor.ATTR_VALUE, 0xFFFFFFFF],
        [PrismColor.KEYWORD, 0xFFFF0000], // 关键字
        [PrismColor.FUNCTION, 0xFF87CEEB], // 方法
        [PrismColor.CLASS_NAME, 0xFF808000], // 类名
        [PrismColor.REGEX, 0xFFFFFFFF],
        [PrismColor.IMPORTANT, 0xFFFFFFFF],
        [PrismColor.VARIABLE, 0xFFFFFFFF],
        [PrismColor.DELIMITER, 0xFFFFFFFF],
        [PrismColor.ANNOTATION, 0xFFFFFFFF],
        [PrismColor.ESCAPE_SEQ, 0xFFFFFFFF],
        [PrismColor.GENERIC_METHOD, 0xFFFFFFFF],
        [PrismColor.PSEUDO_ELEMENT, 0xFFFFFFFF],
        [PrismColor.PSEUDO_CLASS, 0xFFFFFFFF],
        [PrismColor.CLASS, 0xFFFFFFFF],
        [PrismColor.ID, 0xFFFFFFFF],
        [PrismColor.ATTRIBUTE, 0xFFFFFFFF],
        [PrismColor.HEXCODE, 0xFFFFFFFF],
        [PrismColor.COMMAND, 0xFFFFFFFF],
        [PrismColor.PARAMETER, 0xFFFFFFFF],
        [PrismColor.COORD, 0xFFFFFFFF],
        [PrismColor.COMMIT_SHA1, 0xFFFFFFFF],
        [PrismColor.SPOCK_BLOCK, 0xFFFFFFFF],
        [PrismColor.NULL, 0xFFFFFFFF],
        [PrismColor.NAMESPACE, 0xFFFFFFFF],
        [PrismColor.SHEBANG, 0xFFFFFFFF],
        [PrismColor.DEFAULT, 0XFFFFFFFF]
      ]
    );
    let prismRes: PrismRes=  codeStringToColorStringCustomize(this.message, "python", 0xFF000000, 0XFFFFFFFF, map)
    this.txtBackground = prismRes.getBackground()
    this.defaultFontColor = prismRes.getDefaultFontColor()
    this.list = Array.from(prismRes.getListColor())
  }

  isColor(getColor: number | undefined): number {
    if (getColor == undefined) {
      return this.defaultFontColor
    } else {
      return getColor
    }
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          Scroll() {
            Column() {
              List() {
                ForEach(this.list, (prismBlock: PrismBlock, index: number) => {
                  ListItem() {
                    Column() {
                      // Text(prismBlock.getText())
                      Text() {
                        ForEach(Array.from(prismBlock.getList()), (prismNode: PrismNode, index: number) => {
                          Span(prismNode.text)
                            .fontColor(this.isColor(prismNode.color))
                        })
                      }
                      .fontSize(14)
                      .textAlign(TextAlign.Start)
                    }
                  }
                })
              }
            }
            .justifyContent(FlexAlign.Start)
            .alignItems(HorizontalAlign.Start)
            .padding(10)
          }
          .backgroundColor(this.txtBackground)
          .scrollBar(BarState.Off)
          .scrollable(ScrollDirection.Horizontal)
          .width(`100%`)
        }
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }
      .width(`100%`)
      .scrollable(ScrollDirection.Vertical)
      .padding({
        left: 10,
        right: 10,
        top: 20,
        bottom: 20
      })
    }
    .width(`100%`)
    .height(`100%`)
    .backgroundColor(Color.White)
  }
}