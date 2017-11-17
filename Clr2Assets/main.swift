//
//  main.swift
//  Clr2Assets
//
//  Created by 山口　恭兵 on 2017/11/17.
//  Copyright © 2017年 Recruit Lifestyle Co., Ltd. All rights reserved.
//
//  カラーパレット(.clr)からAssetCatalogで利用できるColorSetを生成する。

import Foundation
import AppKit.NSColor

let executable = URL(string: CommandLine.arguments[0])!

func showHelp() {
    print("usage:")
    print("\(executable.lastPathComponent) <path to color palette file> <path to output dir>")
}

/// 色定義格納用ディレクトリを作成する
func createColorsDir(at urlOfOutputDir: URL) throws -> URL {
    let colorsDir = urlOfOutputDir.appendingPathComponent("Colors", isDirectory: true)
    let contentsJSONDir = colorsDir.appendingPathComponent("Contents.json")
    
    let contentsJSON = try JSONEncoder().encode(BaseContents())
    
    try FileManager.default.createDirectory(at: colorsDir, withIntermediateDirectories: true, attributes: nil)
    try contentsJSON.write(to: contentsJSONDir)
    
    return colorsDir
}

/// 色定義ディレクトリを作成する
func createColorset(with color: NSColor, name: String, at dir: URL) throws -> URL {
    print("\(name): \(color)")
    
    let colorDir = dir.appendingPathComponent(name + ".colorset", isDirectory: true)
    let contentsJSONDir = colorDir.appendingPathComponent("Contents.json")
    
    let colorContentsJSON = try JSONEncoder().encode(ColorContents(color: color))
    
    try FileManager.default.createDirectory(at: colorDir, withIntermediateDirectories: true, attributes: nil)
    try colorContentsJSON.write(to: contentsJSONDir)
    
    return colorDir
}

func main() {
    guard CommandLine.argc == 3 else {
        showHelp()
        return
    }
    
    let urlOfClr = URL(fileURLWithPath: CommandLine.arguments[1])
    let urlOfOutputDir = URL(fileURLWithPath: CommandLine.arguments[2])
    
    guard let colorList = NSColorList(name: NSColorList.Name(urlOfClr.lastPathComponent), fromFile: urlOfClr.path) else {
        showHelp()
        return
    }

    let colorsDir = try! createColorsDir(at: urlOfOutputDir)

    colorList.allKeys.forEach {
        let color = colorList.color(withKey: $0)!
        _ = try! createColorset(with: color, name: $0.rawValue, at: colorsDir)
    }
}

main()
