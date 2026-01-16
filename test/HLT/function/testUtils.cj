import std.fs.*
import std.posix.*
import std.collection.*
import stdx.encoding.json.*
import std.unittest.*
import std.unittest.testmacro.*
import cangjie_tpc::prism4cj.prism.*

public abstract class TestUtils {
    private static let DELIMITER: String = "----------------------------------------------------"

    public static func testFiles(lang: String): Collection<FileInfo> {
        let path: String = getcwd() + "/../../../../HLT/function"
        let folder: String = path + "/languages/" + lang + "/"
        let dir: Array<FileInfo> = Directory.readFrom(folder)
        var arr: ArrayList<FileInfo> = ArrayList<FileInfo>()
        for (f in dir) {
            arr.add(f)
        }
        return arr
    }

    public static func readFile(file: FileInfo): String {
        let fileValueArr: Array<Byte> = File.readFrom(file.path)
        let raw: String = String.fromUtf8(fileValueArr)
        return raw
    }

    public static func readCase(file: FileInfo): Case {
        let fileValueArr: Array<Byte> = File.readFrom(file.path)
        let raw: String = String.fromUtf8(fileValueArr)
        let split: Array<String> = raw.split(DELIMITER)
        if (split.size < 2) {
            throw Exception("Test file seems to have wrong delimiter, file: " + file.path.toString())
        }
        let input: String = split[0].trimAscii()
        let s = split[1].trimAscii()
        let simplifiedOutput: JsonArray = JsonArray().add(JsonValue.fromStr(s))
        let description: String = split[2].trimAscii()
        return Case(input, simplifiedOutput, description)
    }

    public static func simplify(nodes: ArrayList<Node>): JsonArray {
        // root array
        var array: JsonArray = JsonArray()
        for (node in nodes) {
            if (node is Text) {
                let literal: String = (node as Text).getOrThrow().literal()
                if (literal.trimAscii().size != 0) {
                    array.add(JsonString(literal))
                }
            } else {
                let syntax: Syntax = (node as Syntax).getOrThrow()
                var inner: JsonArray = JsonArray()
                inner.add(JsonString(syntax.syntaxType()))
                if (syntax.tokenized()) {
                    inner.add(simplify(syntax.children()))
                } else {
                    inner.add(simplify(syntax.children()))
                }
                array.add(inner)
            }
        }
        return array
    }

    static func parseJsonArray(arr: ArrayList<JsonValue>): String {
        var str: String = ""
        for (jv in arr) {
            if (let Some(v) <- (jv as JsonArray)) {
                str += parseJsonArray(v.getItems())
            } else {
                str += jv.toString()
            }
        }
        return str
    }

    public static func assertCase(c: Case, nodes: ArrayList<Node>): Bool {
        let expected: ArrayList<JsonValue> = c.simplifiedOutput.getItems()
        var str1 = parseJsonArray(expected)
        let actual: ArrayList<JsonValue> = simplify(nodes).getItems()
        var str2 = parseJsonArray(actual)
        // println("str2 > ${str2}")
        return str1 == str2
    }
}

public class Case {
    public let input: String
    public let simplifiedOutput: JsonArray
    public let description: String

    public init(input: String, simplifiedOutput: JsonArray, description: String) {
        this.input = input
        this.simplifiedOutput = simplifiedOutput
        this.description = description
    }
}
