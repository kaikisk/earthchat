//
//  ChatCell.swift
//  EarthChat
//
//  Created by main on 2018/12/15.
//  Copyright © 2018 lam7. All rights reserved.
//

import Foundation
import UIKit
import FoldingCell

class ChatCell: FoldingCell{    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        let durations = [0.15, 0.175, 0.175]
        return durations[itemIndex]
        
    }
}

class ForegroundChatView: RotatedView, Nibable{
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    
    weak var nibView: UIView!
    var nibName: String{
        return className
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib(nibName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib(nibName)
    }
}


class ContainerChatView: UINibView{
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var timeStampLabel: UILabel!
}
