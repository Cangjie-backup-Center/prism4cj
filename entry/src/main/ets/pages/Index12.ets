import { codeStringToColorString, PrismBlock, PrismNode, PrismRes } from '@cangjie-tpc/prism';

@Entry
@Component
struct Index22 {
  @State message: string = '<!DOCTYPE html>\n' +
    '<html>\n' +
    '<head>\n' +
    '    <title>Markdown快速参考</title>\n' +
    '    <style>\n' +
    '        body { font-family: sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }\n' +
    '        h1 { text-align: center; color: #2c3e50; }\n' +
    '        .card { \n' +
    '            background: #f8f9fa; \n' +
    '            border-radius: 8px; \n' +
    '            padding: 15px; \n' +
    '            margin-bottom: 20px;\n' +
    '            box-shadow: 0 2px 5px rgba(0,0,0,0.1);\n' +
    '        }\n' +
    '        .example { \n' +
    '            background: white; \n' +
    '            padding: 15px;\n' +
    '            border-left: 3px solid #3498db;\n' +
    '            font-family: monospace;\n' +
    '            margin: 10px 0;\n' +
    '        }\n' +
    '        .result { margin-top: 15px; padding: 10px; background: white; }\n' +
    '    </style>\n' +
    '</head>\n' +
    '<body>\n' +
    '    <h1>Markdown语法速查</h1>\n' +
    '\n' +
    '    <div class="card">\n' +
    '        <h2>标题</h2>\n' +
    '        <div class="example"># 一级标题\n' +
    '## 二级标题\n' +
    '### 三级标题</div>\n' +
    '        <div class="result">\n' +
    '            <h1>一级标题</h1>\n' +
    '            <h2>二级标题</h2>\n' +
    '            <h3>三级标题</h3>\n' +
    '        </div>\n' +
    '    </div>\n' +
    '\n' +
    '    <div class="card">\n' +
    '        <h2>文本格式</h2>\n' +
    '        <div class="example">**粗体文本**\n' +
    '*斜体文本*\n' +
    '~~删除线~~\n' +
    '`行内代码`</div>\n' +
    '        <div class="result">\n' +
    '            <p><strong>粗体文本</strong><br>\n' +
    '            <em>斜体文本</em><br>\n' +
    '            <del>删除线</del><br>\n' +
    '            <code>行内代码</code></p>\n' +
    '        </div>\n' +
    '    </div>\n' +
    '\n' +
    '    <div class="card">\n' +
    '        <h2>列表</h2>\n' +
    '        <div class="example">- 无序列表项\n' +
    '1. 有序列表项\n' +
    '- [x] 已完成\n' +
    '- [ ] 未完成</div>\n' +
    '        <div class="result">\n' +
    '            <ul><li>无序列表项</li></ul>\n' +
    '            <ol><li>有序列表项</li></ol>\n' +
    '            <ul>\n' +
    '                <li><input type="checkbox" checked disabled> 已完成</li>\n' +
    '                <li><input type="checkbox" disabled> 未完成</li>\n' +
    '            </ul>\n' +
    '        </div>\n' +
    '    </div>\n' +
    '\n' +
    '    <div class="card">\n' +
    '        <h2>链接与代码</h2>\n' +
    '        <div class="example">[GitCode](https://gitcode.com)\n' +
    '```python\n' +
    'print("代码块")\n' +
    '```</div>\n' +
    '        <div class="result">\n' +
    '            <p><a href="https://gitcode.com">GitCode</a></p>\n' +
    '            <pre style="background:#f0f0f0;padding:10px;">print("代码块")</pre>\n' +
    '        </div>\n' +
    '    </div>\n' +
    '\n' +
    '    <div style="text-align:center; margin-top:30px; color:#7f8c8d;">\n' +
    '        <small>TianQi AI 提供 | 最后更新: 2025/07/22</small>\n' +
    '    </div>\n' +
    '</body>\n' +
    '</html>';
  @State
  list: Array<PrismBlock> = new Array<PrismBlock>()
  @State
  txtBackground: number = undefined!
  @State
  defaultFontColor: number = undefined!

  async aboutToAppear(): Promise<void> {
    let prismRes: PrismRes = await codeStringToColorString(this.message, "html", false)
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
