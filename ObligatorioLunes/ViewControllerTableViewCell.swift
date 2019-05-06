//
//  ViewControllerTableViewCell.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 30/4/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var MyLabel: UILabel!
    @IBOutlet weak var MyLabelPrice: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabelQuant: UILabel!
    
    @IBOutlet weak var myButtonAddFirst: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol ProductTableViewCellDelegate:class{
    func productTapInAdd(id:Int,indexPath:IndexPath)
    func productTapInRemove(id:Int,indexPath:IndexPath)
    func productTapInPlus(id:Int,indexPath:IndexPath)
}
