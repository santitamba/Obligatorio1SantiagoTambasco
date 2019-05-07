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
    @IBOutlet var myButtonMinus: UIButton!
    @IBOutlet var myButtonPlus: UIButton!
    var indexPath : IndexPath?
    weak var delegate: ViewControllerTableViewCellDelegate?
    
    @IBAction func myButtonAdd(_ sender: UIButton) {
        if let index = indexPath{
            delegate?.productTapInAdd(indexPath: index)
        }else{
            print (indexPath)
        }
    }
    @IBAction func myButtonPlus(_ sender: UIButton) {
        if let index = indexPath{
            delegate?.productTapInPlus(indexPath: index)
        }else{
            print (indexPath)
        }
    }
    @IBAction func myButtonMinus(_ sender: UIButton) {
        if let index = indexPath{
            delegate?.productTapInRemove(indexPath: index)
        }else{
            print (indexPath)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        myImage.layer.cornerRadius=myImage.frame.width / 2
        if(self.myLabelQuant.text == "0"){
            myButtonAddFirst.isHidden = true
            myLabelQuant.isHidden = false
            myButtonMinus.isHidden = false
            myButtonPlus.isHidden = false
        }else{
            myButtonAddFirst.isHidden = false
            myLabelQuant.isHidden = true
            myButtonMinus.isHidden = true
            myButtonPlus.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}

protocol ViewControllerTableViewCellDelegate:class{
    func productTapInAdd(indexPath:IndexPath)
    func productTapInRemove(indexPath:IndexPath)
    func productTapInPlus(indexPath:IndexPath)
}
