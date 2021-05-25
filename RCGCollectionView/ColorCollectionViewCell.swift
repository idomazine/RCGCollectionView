//
//  ColorCollectionViewCell.swift
//  RCGCollectionView
//
//  Created by idomazine on 2021/05/25.
//

import UIKit

final class ColorCollectionViewCell: UICollectionViewCell {
    static let defaultSize: CGSize = .init(width: 280, height: 280)

    private var hexLabel: UILabel!
    private var colorView: UIView!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not implemented.")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // 色の表示用ビュー
        colorView = UIView()
        contentView.addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            colorView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 240)
        ])

        // 色の16進数文字列表示用ラベル
        hexLabel = UILabel()
        contentView.addSubview(hexLabel)
        hexLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hexLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 8),
            hexLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            hexLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }

    func configure(color: UIColor) {
        colorView.backgroundColor = color
        hexLabel.text = color.hexPresentation
    }
}
