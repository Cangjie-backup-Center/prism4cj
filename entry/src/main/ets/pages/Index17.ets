import { codeStringToColorStringCustomize, PrismNodesParseResArkts, PrismNodesParseResColorArkts,PrismColor } from '@cangjie-tpc/prism';

@Entry
@Component
struct Index17 {
  @State message: string = '/* 温度监控系统核心逻辑 */\n' +
    '#include <stdio.h>\n' +
    '#include <stdint.h>\n' +
    '\n' +
    '#define TEMP_THRESHOLD 30.0\n' +
    '\n' +
    'typedef struct {\n' +
    '    uint8_t sensor_id;\n' +
    '    float current_temp;\n' +
    '    uint8_t cooling_status;\n' +
    '} DeviceState;\n' +
    '\n' +
    'void check_temperature(DeviceState *device) {\n' +
    '    // 模拟从传感器读取数据\n' +
    '    device->current_temp = 25.0 + (rand() % 15);\n' +
    '    \n' +
    '    if(device->current_temp > TEMP_THRESHOLD) {\n' +
    '        device->cooling_status = 1;\n' +
    '        printf("警告：传感器%d温度%.1f°C，启动散热\\n", \n' +
    '               device->sensor_id, device->current_temp);\n' +
    '    } else {\n' +
    '        device->cooling_status = 0;\n' +
    '    }\n' +
    '}\n' +
    '\n' +
    'int main() {\n' +
    '    DeviceState main_device = {1, 0.0, 0};\n' +
    '    \n' +
    '    while(1) {\n' +
    '        check_temperature(&main_device);\n' +
    '        sleep(1); // 1秒检测间隔\n' +
    '    }\n' +
    '    return 0;\n' +
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
    let a: PrismNodesParseResColorArkts = await codeStringToColorStringCustomize(this.message, "c", 0xFF000000, 0XFFFFFFFF, map)
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
    .backgroundColor(Color.White)
  }
}