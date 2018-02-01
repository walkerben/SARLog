//
//  LogEntryTypeCollectionViewCell.swift
//  SARLog2
//
//  Created by Benjamin Walker on 10/13/17.
//  Copyright © 2017 Benjamin Walker. All rights reserved.
//

import UIKit

class LogEntryTypeCollectionViewCell: UICollectionViewCell {
    var entryTypeLabel: UILabel
    
    override init(frame: CGRect) {
        entryTypeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        super.init(frame: frame)
        entryTypeLabel.font = UIFont.systemFont(ofSize: 12.0)
        contentView.addSubview(entryTypeLabel)
        layer.cornerRadius = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    
    
}
