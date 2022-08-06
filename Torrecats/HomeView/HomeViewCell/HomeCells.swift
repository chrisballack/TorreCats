//
//  Cells.swift
//  Torrecats
//
//  Created by Dev IOS on 6/08/22.
//

import Foundation
import UIKit

class CatsCell:UITableViewCell{
    
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var DislikeImage: UIImageView!
    @IBOutlet weak var LikeImage: UIImageView!
    @IBOutlet weak var BackView: UIViewX!
    @IBOutlet weak var ImageViewBack: UIImageView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var DislikeButton: UIButton!
    @IBOutlet weak var HeightLike: NSLayoutConstraint!
    @IBOutlet weak var HeightDisLike: NSLayoutConstraint!
    
}

class LikeDisLikeCell:UITableViewCell{
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var LikeImage: UIImageView!
    
}
