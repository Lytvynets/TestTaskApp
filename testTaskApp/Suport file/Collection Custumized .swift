//
//  Collection Custumized .swift
//  testTaskApp
//
//  Created by Vlad Lytvynets on 07.11.2021.
//

import Foundation
import UIKit

class CollectionCustumized {
    
    func makeShadow(cell: CollectionViewCell, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor, backgroundColor: CGColor, shadowColor: CGColor, shadowRadius: CGFloat, Opacity: Float  ) {
        cell.contentView.layer.cornerRadius = cornerRadius
        cell.contentView.layer.borderWidth = borderWidth
        cell.contentView.layer.borderColor = borderColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.backgroundColor = backgroundColor
        cell.layer.shadowColor = shadowColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0) //CGSizeMake(0, 2.0)
        cell.layer.shadowRadius = shadowRadius
        cell.layer.shadowOpacity = Opacity
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.layer.cornerRadius = 5
        cell.postedImage.layer.cornerRadius = 5
    }
}
