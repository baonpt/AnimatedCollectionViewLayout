//
//  LinearCardAttributesAnimator.swift
//  AnimatedCollectionViewLayout
//
//  Created by Jin Wang on 8/2/17.
//  Copyright © 2017 Uthoft. All rights reserved.
//

import UIKit

/// An animator that turns the cells into card mode.
/// - warning: You need to set `clipsToBounds` to `false` on the cell to make
/// this effective.
public struct LinearCardAttributesAnimator: LayoutAttributesAnimator {
  /// The alpha to apply on the cells that are away from the center. Should be
  /// in range [0, 1]. 0.5 by default.
  public var minAlpha: CGFloat
  
  /// The spacing ratio between two cells. 0.4 by default.
  public var itemSpacing: CGFloat
  
  /// The scale rate that will applied to the cells to make it into a card.
  public var scaleRate: CGFloat
  
  public init(minAlpha: CGFloat = 0.5, itemSpacing: CGFloat = 0.4, scaleRate: CGFloat = 0.7) {
    self.minAlpha = minAlpha
    self.itemSpacing = itemSpacing
    self.scaleRate = scaleRate
  }
  
  public func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes) {
    let position = attributes.middleOffset
    let translationTransform: CGAffineTransform
    
    if attributes.scrollDirection == .horizontal {
      let width = collectionView.frame.width
      let translationX = -(width * itemSpacing * position)
      let scaleX = scaleRate - 0.1 * abs(position)
      let scaleY = 0.9 - 0.1 * abs(position)
      let scaleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
      translationTransform = CGAffineTransform(translationX: translationX, y: 0)
      attributes.transform = translationTransform.concatenating(scaleTransform)
    } else {
      let height = collectionView.frame.height
      let translationY = -(height * itemSpacing * position)
      let scaleY = scaleRate - 0.1 * abs(position)
      let scaleX = 0.9 - 0.1 * abs(position)
      let scaleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
      translationTransform = CGAffineTransform(translationX: 0, y: translationY)
      attributes.transform = translationTransform.concatenating(scaleTransform)
    }
    
    attributes.alpha = 1.0 - abs(position) + minAlpha
    
  }
}
