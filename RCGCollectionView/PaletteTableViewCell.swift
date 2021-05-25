//
//  PaletteTableViewCell.swift
//  RCGCollectionView
//
//  Created by idomazine on 2021/05/25.
//

import UIKit

final class PaletteTableViewCell: UITableViewCell {
    static let defaultHeight: CGFloat = 320

    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private var titleLabel = UILabel()

    private var colors: [UIColor] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        // セクションのタイトル表示ラベル
        titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.readableContentGuide.leftAnchor),
        ])

        // ページングレイアウト
        layout = PagingForReadableContentGuideLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = ColorCollectionViewCell.defaultSize
        layout.minimumLineSpacing = 16

        // コンテンツ表示用コレクションビュー
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.dataSource = self
        collectionView.register(ColorCollectionViewCell.self,
                                forCellWithReuseIdentifier: "ColorCollectionViewCell")
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: ColorCollectionViewCell.defaultSize.height)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView.contentOffset = .init(x: -collectionView.contentInset.left,
                                             y: -collectionView.contentInset.top)
    }

    override func layoutSubviews() {
        let leftInset = readableContentGuide.layoutFrame.minX
        let rightInset = frame.width - leftInset - layout.itemSize.width
        collectionView.contentInset = .init(top: 0,
                                            left: leftInset,
                                            bottom: 0,
                                            right: rightInset)
        super.layoutSubviews()
    }

    func configure(title: String,
                   colors: [UIColor]) {
        self.colors = colors
        titleLabel.text = title
        collectionView.reloadData()
    }
}

extension PaletteTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell",
                                                      for: indexPath) as! ColorCollectionViewCell
        cell.configure(color: colors[indexPath.row])
        return cell
    }
}

