import { codeStringToColorStringCustomize, PrismNodesParseResArkts, PrismNodesParseResColorArkts,PrismColor } from '@cangjie-tpc/prism';

@Entry
@Component
struct Index19 {
  @State message: string = '// 待办事项管理器\n' +
    'class TodoManager {\n' +
    '  constructor() {\n' +
    '    this.todos = JSON.parse(localStorage.getItem(\'todos\')) || [];\n' +
    '    this.todoListElement = document.getElementById(\'todo-list\');\n' +
    '    this.todoInput = document.getElementById(\'todo-input\');\n' +
    '    this.addButton = document.getElementById(\'add-button\');\n' +
    '    \n' +
    '    this.init();\n' +
    '  }\n' +
    '\n' +
    '  // 初始化\n' +
    '  init() {\n' +
    '    this.renderTodos();\n' +
    '    this.addButton.addEventListener(\'click\', () => this.addTodo());\n' +
    '    this.todoInput.addEventListener(\'keypress\', (e) => {\n' +
    '      if (e.key === \'Enter\') this.addTodo();\n' +
    '    });\n' +
    '  }\n' +
    '\n' +
    '  // 添加待办事项\n' +
    '  addTodo() {\n' +
    '    const text = this.todoInput.value.trim();\n' +
    '    if (!text) return;\n' +
    '\n' +
    '    const newTodo = {\n' +
    '      id: Date.now(),\n' +
    '      text,\n' +
    '      completed: false\n' +
    '    };\n' +
    '\n' +
    '    this.todos.unshift(newTodo);\n' +
    '    this.saveAndRender();\n' +
    '    this.todoInput.value = \'\';\n' +
    '  }\n' +
    '\n' +
    '  // 删除待办事项\n' +
    '  deleteTodo(id) {\n' +
    '    this.todos = this.todos.filter(todo => todo.id !== id);\n' +
    '    this.saveAndRender();\n' +
    '  }\n' +
    '\n' +
    '  // 切换完成状态\n' +
    '  toggleTodo(id) {\n' +
    '    this.todos = this.todos.map(todo => \n' +
    '      todo.id === id ? {...todo, completed: !todo.completed} : todo\n' +
    '    );\n' +
    '    this.saveAndRender();\n' +
    '  }\n' +
    '\n' +
    '  // 保存到 localStorage\n' +
    '  saveTodos() {\n' +
    '    localStorage.setItem(\'todos\', JSON.stringify(this.todos));\n' +
    '  }\n' +
    '\n' +
    '  // 渲染待办事项列表\n' +
    '  renderTodos() {\n' +
    '    this.todoListElement.innerHTML = \'\';\n' +
    '    \n' +
    '    if (this.todos.length === 0) {\n' +
    '      this.todoListElement.innerHTML = \'<p class="empty-message">暂无待办事项</p>\';\n' +
    '      return;\n' +
    '    }\n' +
    '\n' +
    '    this.todos.forEach(todo => {\n' +
    '      const li = document.createElement(\'li\');\n' +
    '      li.className = `todo-item $\{todo.completed ? \'completed\' : \'\'}`;\n' +
    '      li.innerHTML = `\n' +
    '        <span class="todo-text $\{todo.completed ? \'line-through\' : \'\'}">$\{todo.text}</span>\n' +
    '        <div class="actions">\n' +
    '          <button class="toggle-btn">\n' +
    '            <i class="fa $\{todo.completed ? \'fa-check-square-o\' : \'fa-square-o\'}"></i>\n' +
    '          </button>\n' +
    '          <button class="delete-btn">\n' +
    '            <i class="fa fa-trash-o"></i>\n' +
    '          </button>\n' +
    '        </div>\n' +
    '      `;\n' +
    '\n' +
    '      li.querySelector(\'.toggle-btn\').addEventListener(\'click\', () => this.toggleTodo(todo.id));\n' +
    '      li.querySelector(\'.delete-btn\').addEventListener(\'click\', () => this.deleteTodo(todo.id));\n' +
    '      this.todoListElement.appendChild(li);\n' +
    '    });\n' +
    '  }\n' +
    '\n' +
    '  // 保存并重新渲染\n' +
    '  saveAndRender() {\n' +
    '    this.saveTodos();\n' +
    '    this.renderTodos();\n' +
    '  }\n' +
    '}\n' +
    '\n' +
    '// 页面加载完成后初始化\n' +
    'document.addEventListener(\'DOMContentLoaded\', () => {\n' +
    '  new TodoManager();\n' +
    '});';
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
    let a: PrismNodesParseResColorArkts = await codeStringToColorStringCustomize(this.message, "js", 0xFF000000, 0XFFFFFFFF, map)
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