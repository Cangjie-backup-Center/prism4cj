from std import fs.*
from std import os.*
from std import collection.*
from encoding import json.*
from std import unittest.*
from std import unittest.testmacro.*
from prism4cj import prism.*

public abstract class TestUtils {
    private static let DELIMITER: String = "----------------------------------------------------"

    public static func testFiles(lang: String): Collection<File> {
        let path: ?String = getEnv("cangjie_test_path")
        let folder: String = path.getOrThrow() + "/languages/" + lang + "/"
        let dir: Directory = Directory(folder)
        var arr: ArrayList<File> = ArrayList<File>()
        for (f in dir) {
            arr.append(File(f.path, Open(true, true)))
        }
        return arr
    }

    public static func readCase(file: File): Case {
        let fileValueArr: Array<Byte> = file.readToEnd()
        let raw: String = String.fromUtf8(fileValueArr)
        let split: Array<String> = raw.split(DELIMITER)
        if (split.size < 2) {
            throw Exception("Test file seems to have wrong delimiter, file: " + file.info.path.toString())
        }
        let input: String = split[0].trimAscii()
        let s = split[1].trimAscii()
        let simplifiedOutput: JsonArray = JsonArray().add(JsonValue.fromStr(split[1].trimAscii()))
        let description: String = split[2].trimAscii()
        return Case(input, simplifiedOutput, description)
    }

    public static func assertCase(c: Case, nodes: ArrayList<Node>) {
        let expected: String = c.simplifiedOutput.toString()
        let actual: String = simplify(nodes).toString()
        println("expected===> \n ${expected}")
        println("actual===> \n ${actual}")
        // @Assert(expected, actual)
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