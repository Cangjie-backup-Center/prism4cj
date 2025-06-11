import { codeStringToColorString, PrismNodesParseResArkts, PrismNodesParseResColorArkts } from 'prismarkts';

@Entry
@Component
struct Index8 {
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
    let a: PrismNodesParseResColorArkts = await codeStringToColorString(this.message, "c", false)
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