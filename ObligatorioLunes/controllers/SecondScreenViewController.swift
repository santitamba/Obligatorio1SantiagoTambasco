//
//  SecondScreenViewController.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 6/5/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
class SecondScreenViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellSecondView=collectionView.dequeueReusableCell(withReuseIdentifier: "cellSecondView", for: indexPath) as? ViewControllerSeconViewCell else { return UICollectionViewCell()}
       
        cellSecondView.item = elements[indexPath.row]
        if elements.count>0{
            ChechoutButton.isEnabled=true
        }
        cellSecondView.configure()
        
        return cellSecondView
    }
    
    
    @IBAction func TapImageButton(_ sender: UIButton) {
        print("hola")
    }
    @IBOutlet var ChechoutButton: UIButton!

    @IBAction func CheckOutButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Successful", message: "Congratulation for purchase in the Shop",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Accept",style: .default, handler: indexAlert))
        self.present(alert, animated: true)
    }
    @IBAction func BackButton(_ sender: Any) {
        self.performSegue(withIdentifier: "FirstViewSegue", sender: self)
    }
    
    let untis=0
    
    var elements=[SupermarketItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChechoutButton.layer.cornerRadius=10
      
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func indexAlert(alert: UIAlertAction!){
        self.navigationController?.popViewController(animated: true)
    }
    
}
