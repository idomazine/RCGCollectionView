//
//  UIColor+Utility.swift
//  RCGCollectionView
//
//  Created by idomazine on 2021/05/25.
//

import UIKit

extension UIColor {
    /// ランダム色の生成
    /// - Returns: 生成された色
    static func random() -> UIColor {
        UIColor(red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1)
    }

    /// 色の16進数文字列表現
    /// - Returns: 16進数に変換された文字列
    var hexPresentation: String {
        guard let components = cgColor.components else { return "" }

        let toHex = { (component: CGFloat) -> String in
            String(Int(component * 255),
                   radix: 16,
                   uppercase: true)
        }

        return components
            .suffix(3)
            .map(toHex)
            .reduce("#") { $0 + $1 }
    }
}
