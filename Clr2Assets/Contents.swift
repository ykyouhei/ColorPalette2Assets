//
//  Contents.swift
//  Clr2Assets
//
//  Created by 山口　恭兵 on 2017/11/17.
//  Copyright © 2017年 Recruit Lifestyle Co., Ltd. All rights reserved.
//

import Foundation
import AppKit.NSColor

struct Info: Codable {
    let version = 1
    let author = "xcode"
}

struct ColorInfo: Codable {
    
    struct Color: Codable {
        enum CodingKeys: String, CodingKey {
            case colorSpace = "color-space"
            case components = "components"
        }
        
        struct Components: Codable {
            let red: Float
            let green: Float
            let blue: Float
            let alpha: Float
        }
        
        let colorSpace = "srgb"
        let components: Components
    }
    
    let idiom = "universal"
    let color: Color
}

struct BaseContents: Codable {
    let info = Info()
}

struct ColorContents: Codable {
    let info: Info
    let colors: [ColorInfo]
    
    init(color: NSColor) {
        self.info = Info()
        self.colors = [
            ColorInfo(color: ColorInfo.Color(components: ColorInfo.Color.Components(red: Float(color.redComponent),
                                                                                    green: Float(color.greenComponent),
                                                                                    blue: Float(color.blueComponent),
                                                                                    alpha: Float(color.alphaComponent))))
        ]
    }
}
