import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Scroll() {
      Column() {
        Row() {
          Text("")// 宽度
            .width(10)
          Button("1. 深色，java语言")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index1' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("2. 浅色，java语言")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index2' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("3. 深色，cangjie")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index3' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("4. 浅色，cangjie")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index4' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("5. 深色，python")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index5' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("6. 浅色，python")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index6' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("7. 深色，c")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index7' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("8. 浅色，c")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index8' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("9. 深色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index9' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("10. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index10' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("11. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index11' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("12. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index12' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("13. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index13' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("14. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index14' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("15. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index15' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("16. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index16' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("17. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index17' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("18. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index18' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("19. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index19' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')

        Row() {
          Text("")// 宽度
            .width(10)
          Button("20. 浅色，js")
            .height(50)// 高度
            .layoutWeight(1)// 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
            .fontColor(0xFFFFFFFF)// 文本颜色
            .backgroundColor(0xFFFF0000)// 背景颜色
            .margin({ top: 5, bottom: 5 })// 外边距
            .align(Alignment.Center)// 内容对齐方式
            .fontSize(12)// 字体大小
            .onClick(e => {
              // 点击动作触发该方法调用
              router.pushUrl({ url: 'pages/Index20' })
            })
          Text("")// 宽度
            .width(10)
        }
        .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .scrollBar(BarState.Off)
  }
}