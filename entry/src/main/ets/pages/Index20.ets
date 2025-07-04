import { PrismNodesParseResColor, PrismNodesParseRes, codeStringToColorStringCustomize,
  PrismColor} from '@cangjie-tpc/prism';
import { ArrayList } from '@kit.ArkTS';

@Entry
@Component
struct Index20 {
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
    let a: PrismNodesParseResColor= await codeStringToColorStringCustomize(this.message, "js", 0xFFFFFFFF, 0XFF000000, map)
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