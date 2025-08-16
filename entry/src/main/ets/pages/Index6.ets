import { codeStringToColorString, PrismBlock, PrismRes, PrismNode } from '@cangjie-tpc/prism';

@Entry
@Component
struct Index6 {
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

  async aboutToAppear(): Promise<void> {
    let prismRes: PrismRes= await codeStringToColorString(this.message, "python", false)
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
    .backgroundColor(Color.Black)
  }
}