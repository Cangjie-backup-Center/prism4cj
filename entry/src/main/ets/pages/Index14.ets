import { codeStringToColorStringCustomize, PrismNodesParseResArkts, PrismNodesParseResColorArkts,PrismColor } from '@cangjie-tpc/prism';

@Entry
@Component
struct Index14 {
  @State message: string = 'main(): Unit {\n' +
    '    let future = spawn { // Create a new thread\n' +
    '        while (true) {\n' +
    '            if (Thread.currentThread.hasPendingCancellation) {\n' +
    '                return 0\n' +
    '            }\n' +
    '        }\n' +
    '        return 1\n' +
    '    }\n' +
    '    //...\n' +
    '    future.cancel()    // Send a termination request\n' +
    '    let res = future.get() // Wait for thread termination\n' +
    '    println(res) // 0\n' +
    '}\n';
  @State
  list: Array<PrismNodesParseResArkts> = undefined!
  @State
  txtBackground: number = undefined!
  @State
  defaultFontColor: number = undefined!

  async aboutToAppear(): Promise<void> {
    let map: Map<PrismColor, number> = new Map(
      [
        [PrismColor.COMMENT, 0xFFD3D3D3], // 注释
        [PrismColor.PROLOG, 0xFF000000],
        [PrismColor.DOCTYPE, 0xFF000000],
        [PrismColor.CDATA, 0xFF000000],
        [PrismColor.PUNCTUATION, 0xFF00FF00], // 符号
        [PrismColor.PROPERTY, 0xFF000000],
        [PrismColor.TAG, 0xFF000000],
        [PrismColor.BOOLEAN, 0xFF000000],
        [PrismColor.NUMBER, 0xFF0000FF], // 数字
        [PrismColor.CONSTANT, 0xFF000000],
        [PrismColor.SYMBOL, 0xFF000000],
        [PrismColor.DELETED, 0xFF000000],
        [PrismColor.SELECTOR, 0xFF000000],
        [PrismColor.ATTR_NAME, 0xFF000000],
        [PrismColor.STRING, 0xFFFFFF00], // 字符串
        [PrismColor.CHAR, 0xFF000000],
        [PrismColor.BUILTIN, 0xFF000000],
        [PrismColor.INSERTED, 0xFF000000],
        [PrismColor.OPERATOR, 0xFF696969], // 符号
        [PrismColor.URL, 0xFF000000],
        [PrismColor.ENTITY, 0xFF000000],
        [PrismColor.ATRULE, 0xFF000000],
        [PrismColor.ATTR_VALUE, 0xFF000000],
        [PrismColor.KEYWORD, 0xFFFF0000], // 关键字
        [PrismColor.FUNCTION, 0xFF87CEEB], // 方法
        [PrismColor.CLASS_NAME, 0xFF808000], // 类名
        [PrismColor.REGEX, 0xFF000000],
        [PrismColor.IMPORTANT, 0xFF000000],
        [PrismColor.VARIABLE, 0xFF000000],
        [PrismColor.DELIMITER, 0xFF000000],
        [PrismColor.ANNOTATION, 0xFF000000],
        [PrismColor.ESCAPE_SEQ, 0xFF000000],
        [PrismColor.GENERIC_METHOD, 0xFF000000],
        [PrismColor.PSEUDO_ELEMENT, 0xFF000000],
        [PrismColor.PSEUDO_CLASS, 0xFF000000],
        [PrismColor.CLASS, 0xFF000000],
        [PrismColor.ID, 0xFF000000],
        [PrismColor.ATTRIBUTE, 0xFF000000],
        [PrismColor.HEXCODE, 0xFF000000],
        [PrismColor.COMMAND, 0xFF000000],
        [PrismColor.PARAMETER, 0xFF000000],
        [PrismColor.COORD, 0xFF000000],
        [PrismColor.COMMIT_SHA1, 0xFF000000],
        [PrismColor.SPOCK_BLOCK, 0xFF000000],
        [PrismColor.NULL, 0xFF000000],
        [PrismColor.NAMESPACE, 0xFF000000],
        [PrismColor.SHEBANG, 0xFF000000],
        [PrismColor.DEFAULT, 0xFF000000]
      ]
    );
    let a: PrismNodesParseResColorArkts = await codeStringToColorStringCustomize(this.message, "cangjie", 0xFFFFFFFF, 0XFF000000, map)
    this.txtBackground = a.getBackground()
    this.defaultFontColor = a.getDefaultFontColor()
    this.list = a.getListColor()
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
              Text() {
                ForEach(this.list, (item: PrismNodesParseResArkts, index: number) => {
                  Span(item.getText())
                    .fontColor(this.isColor(item.getColor()))
                })
              }
              .fontSize(14)
              .textAlign(TextAlign.Start)
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