//
//  ViewController.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 29/4/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var slideCollectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    
    //let fruits=["kiwi"]
    var imgArr=[UIImage(named:"Banner-1"),UIImage(named:"Banner-2"),UIImage(named:"Banner-3"),UIImage(named:"Banner-4")]
    var timer=Timer()
    var counter=0
    let sections=["fruits","veggies"]
    let items=[["kiwi","Watermelon","Grapefruit"],
    ["Avocado","Cucumber"]]
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(items[section].count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.myImage.image = UIImage(named : (items[indexPath.section][indexPath.row] + ".png"))
        //cell.myImage.layer.cornerRadius = cell.myImage.bounds.size.width / 2.0
        cell.MyLabel.text = items[indexPath.section][indexPath.row]
        cell.myLabelQuant.text=String(kiwi.quantity);
        
        return(cell)
        
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return(sections.count)
    }
    
    @objc func changeImage(){
        
        if counter<imgArr.count{
            
            let index=IndexPath.init(item: counter, section: 0)
            
            self.slideCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
            pageView.currentPage=counter
            
            counter += 1
            
        }else{
            
            counter = 0
            
            let index = IndexPath.init(item: counter, section: 0)
            
            self.slideCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
            pageView.currentPage=counter
            
            counter=1
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        pageView.numberOfPages=imgArr.count
        pageView.currentPage=0
        DispatchQueue.main.async {
            self.timer=Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        //ViewControllerTableViewCell.myImage.layer.cornerRadius = myCell.myImage.bounds.size.width / 2.0
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let kiwi = SupermarketItem (quantity: 0, price: 30)
    
    @IBAction func RemoveItemButton(_ sender: UIButton) {
        kiwi.quantity=kiwi.quantity-1
    }
    @IBAction func AddItemButton(_ sender: UIButton) {
        kiwi.quantity=kiwi.quantity+1
    }
    
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imgArr.count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellSlide=collectionView.dequeueReusableCell(withReuseIdentifier: "cellSlide", for: indexPath)
        
        if let vc=cellSlide.viewWithTag(111) as? UIImageView{
            
            vc.image=imgArr[indexPath.row]
            
        }
            
        else if let ab=cellSlide.viewWithTag(222) as? UIPageControl{
            
            ab.currentPage=indexPath.row
            
        }
        
        return cellSlide
        
    }
    
}



extension ViewController:UICollectionViewDelegateFlowLayout{
    
    
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
    //      return UIEdgeInsets(top:0,left:0,bottom:0,right:0)
    
    // }
    
    
    
    //Esto es para que el ancho y largo del item sea igual a mi collectionview
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size=slideCollectionView.frame.size
        
        return CGSize(width: size.width, height: size.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
        
    }
}
