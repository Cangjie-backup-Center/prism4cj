import { PrismNodesParseResColor, PrismNodesParseRes, codeStringToColorStringCustomize,
  PrismColor} from '@cangjie-tpc/prism';
import { ArrayList } from '@kit.ArkTS';

@Entry
@Component
struct Index18 {
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
  list: ArrayList<PrismNodesParseRes> = new ArrayList<PrismNodesParseRes>()
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
    let a: PrismNodesParseResColor= await codeStringToColorStringCustomize(this.message, "c", 0xFFFFFFFF, 0XFF000000, map)
    this.txtBackground = a.getBackground()
    this.defaultFontColor = a.getDefaultFontColor()
    let b :IterableIterator<PrismNodesParseRes> = a.getListColor().values()
    let ret =  b.next()
    this.list.add(ret.value as PrismNodesParseRes)
    while (!ret.done){
      ret = b.next()
      if(!ret.done){
        this.list.add(ret.value as PrismNodesParseRes)
      }
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
                ForEach(this.list.convertToArray(), (item: PrismNodesParseRes, index: number) => {
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