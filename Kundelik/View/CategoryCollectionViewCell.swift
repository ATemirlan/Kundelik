//
//  CategoryCollectionViewCell.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 3/2/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    lazy var blur: UIView = {
        let v = UIView(frame: contentView.frame)
        v.backgroundColor = UIColor.black.withAlphaComponent(0.14)
        return v
    }()
    
    func highlight(isHighlighted: Bool) {
        if !isHighlighted {
            contentView.addSubview(blur)
        } else {
            blur.removeFromSuperview()
        }
    }
    
}
