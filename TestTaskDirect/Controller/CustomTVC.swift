//
//  CustomTVC.swift
//  TestTaskDirect
//
//  Created by Temur on 11/11/2021.
//

import UIKit

class CustomTVC: UITableViewCell {
    @IBOutlet weak var CustomCellView: UIView!
    @IBOutlet weak var AvatarIcon: UIImageView!
    @IBOutlet weak var JobLable: UILabel!
    @IBOutlet weak var NameLable: UILabel!
    
    @IBOutlet weak var MetaLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        AvatarIcon.layer.cornerRadius = 50
        AvatarIcon.clipsToBounds = true
    }

    
   

}

