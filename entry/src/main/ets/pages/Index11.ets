import {
  codeStringToColorStringCustomize,
  PrismNodesParseResArkts,
  PrismNodesParseResColorArkts,
  PrismColor
} from '@cangjie-tpc/prism';
import hilog from '@ohos.hilog';

@Entry
@Component
struct Index11 {
  @State message: string = 'public class FibonacciSequence {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 要计算的斐波那契数列的项数\n' +
    '        \n' +
    '        System.out.println("斐波那契数列的前" + n + "项：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数列的第n项\n' +
    '    public static int fibonacci(int n) {\n' +
    '        if (n <= 1) {\n' +
    '            return n;\n' +
    '        } else {\n' +
    '            return fibonacci(n-1) + fibonacci(n-2);\n' +
    '        }\n' +
    '    }\n' +
    '}';
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
    let a: PrismNodesParseResColorArkts = await codeStringToColorStringCustomize(this.message, "java", 0xFF000000, 0XFFFFFFFF, map)
    this.txtBackground = a.getBackground()
    this.defaultFontColor = a.getDefaultFontColor()
    this.list = a.getListColor()
    for (let index = 0; index < this.list.length; index++) {
      if(this.list[index].getText() === '\n'){
        hilog.error(1,"1",`------------${this.list[index].getText()},${this.list[index].getType()},${this.list[index].getAlias()},${this.list[index].getColor()}`)
      }else{
        hilog.error(1,"1",`-----+++++++${this.list[index].getText()},${this.list[index].getType()},${this.list[index].getAlias()},${this.list[index].getColor()}`)
      }
      // const element = map[index];

    }
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
    .backgroundColor(Color.White)
  }
}