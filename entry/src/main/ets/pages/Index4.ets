import { codeStringToColorString, PrismNodesParseRes, PrismNodesParseResColor } from '@cangjie-tpc/prism';

@Entry
@Component
struct Index4 {
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
  list: Array<PrismNodesParseRes> = new Array<PrismNodesParseRes>()
  @State
  txtBackground: number = undefined!
  @State
  defaultFontColor: number = undefined!

  async aboutToAppear(): Promise<void> {
    let a: PrismNodesParseResColor= await codeStringToColorString(this.message, "cangjie", false)
    this.txtBackground = a.getBackground()
    this.defaultFontColor = a.getDefaultFontColor()
    let b :IterableIterator<PrismNodesParseRes> = a.getListColor().values()
    let ret =  b.next()
    this.list.push(ret.value as PrismNodesParseRes)
    while (!ret.done){
      ret = b.next()
      if(!ret.done){
        this.list.push(ret.value as PrismNodesParseRes)
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
                ForEach(this.list, (item: PrismNodesParseRes, index: number) => {
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