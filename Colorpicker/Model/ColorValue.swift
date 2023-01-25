//
//  ColorValue.swift
//  Colorpicker
//
//  Created by Vitor Trimer on 17/01/23.
//

import Foundation
import SwiftUI

struct ColorValue: Identifiable, Hashable, Equatable {
    var id: UUID = .init()
    var colorCode: String
    var title: String
    var color: Color
}

var colors: [ColorValue] = [
    .init(colorCode: "5F27CD", title: "Warm Purple", color: Color(red: 95/255, green: 39/255, blue: 205/255)),
    .init(colorCode: "222F3E", title: "Imperial Black", color: Color(red: 34/255, green: 47/255, blue: 62/255)),
    .init(colorCode: "E15F41", title: "Old Rose", color: Color(red: 225/255, green: 95/255, blue: 65/255)),
    .init(colorCode: "786FA6", title: "Mountain View", color: Color(red: 120/255, green: 111/255, blue: 166/255)),
    .init(colorCode: "EE5253", title: "Armor Red", color: Color(red: 238/255, green: 82/255, blue: 82/255)),
    .init(colorCode: "05C46B", title: "Orc Skin", color: Color(red: 5/255, green: 196/255, blue: 107/255))
]
