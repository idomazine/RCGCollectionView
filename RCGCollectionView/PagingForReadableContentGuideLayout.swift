//
//  PagingForReadableContentGuideLayout.swift
//  RCGCollectionView
//
//  Created by idomazine on 2021/05/25.
//

import UIKit

final class PagingForReadableContentGuideLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let contentInsetLeft = collectionView?.contentInset.left else { return proposedContentOffset }

        // アイテム1つあたりの表示幅
        let widthPerItem: CGFloat = itemSize.width + minimumLineSpacing

        // 吸着するべきページ数の算出
        let adjustedPage: CGFloat = {
            // contentOffsetはcontentInsetを引いた位置から始まるため、加算して実質的なスクロール位置を算出する
            let relativeOffsetX = proposedContentOffset.x + contentInsetLeft

            // スクロール位置をアイテムの表示幅で割ることでページ数を算出する
            let page = relativeOffsetX / widthPerItem

            if velocity.x > 0 {
                // 右向きにスワイプされたなら右側のアイテムの位置に合わせる
                return ceil(page)
            } else if velocity.x < 0 {
                // 左向きにスワイプされたなら左側のアイテムの位置に合わせる
                return floor(page)
            } else {
                // 静止した状態で指が放されていたなら近いアイテムの位置に移動するため四捨五入する
                return round(page)
            }
        }()

        // ページング補正後のスクロール位置
        let adjustedContentOffsetX = adjustedPage * widthPerItem - contentInsetLeft

        return CGPoint(x: adjustedContentOffsetX,
                       y: proposedContentOffset.y)
    }
}

