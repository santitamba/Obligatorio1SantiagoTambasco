//
//  ViewController.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 29/4/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ViewControllerTableViewCellDelegate {

    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var slideCollectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    @IBAction func ClickCartButton(_ sender: Any) {
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
    @IBAction func CartButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
    
    var imgArr=[UIImage(named:"Banner-1"),UIImage(named:"Banner-2"),UIImage(named:"Banner-3"),UIImage(named:"Banner-4")]
    var timer=Timer()
    var counter=0
    let sections=["fruits","veggies"]
    let items = [0 : ["kiwi","Watermelon","Grapefruit"], 1:["Avocado","Cucumber"]]
    var searchedItem = [String]()
    var prueba = [String]()
    var keys = [String]()
    var searching = false
    var currentItems = [SupermarketItem]()
    //var elementInCart=[String:Int]() //Producto:cantidad
    var elementInCart=["kiwi" : 0,"Watermelon" : 0,"Grapefruit" : 0,"Avocado" : 0,"Cucumber" : 0]
    
    private func setUpItems() {
        // Fruits
        currentItems.append(SupermarketItem(quantity:0, price:30, name: "kiwi"))
        currentItems.append(SupermarketItem(quantity:0, price:45, name: "Watermelon"))
        currentItems.append(SupermarketItem(quantity:0, price:45, name: "Grapefruit"))
        // Veggies
        currentItems.append(SupermarketItem(quantity:0, price:30, name: "Avocado"))
        currentItems.append(SupermarketItem(quantity:0, price:30, name: "Cucumber"))
        // Fruits

        
        //currentItems = items
    }
    
    let kiwi = SupermarketItem (quantity: 0, price: 30,name: "kiwi")
    let watermelon = SupermarketItem (quantity: 0, price: 45,name: "watermelon")
    let grapefruit = SupermarketItem (quantity: 0, price: 45,name: "grapefruit")
    let avocado = SupermarketItem (quantity: 0, price: 30,name: "avocado")
    let cucumber = SupermarketItem (quantity: 0, price: 30,name: "cucumber")
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if searching {
            return ""
        } else {
            return self.sections[section]
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searching {
            return searchedItem.count
        } else {
            return(items[section]!.count)
        }
    }
    // func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //   return 100
    //}
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        if searching {
            cell.MyLabel.text = searchedItem[indexPath.row]
            cell.MyLabelPrice.text = "$"+String(currentItems[indexPath.row].price)
            cell.myImage.layer.cornerRadius = cell.myImage.frame.width / 2
            cell.myImage.image = UIImage(named : (searchedItem[indexPath.row] + ".png"))
            cell.myLabelQuant.text=String(currentItems[indexPath.row].quantity)
            
        } else {
            cell.MyLabel.text = items[indexPath.section]?[indexPath.row]
            cell.MyLabelPrice.text = "$"+String(currentItems[indexPath.row].price)
            cell.myImage.layer.cornerRadius = cell.myImage.frame.width / 2
            cell.myImage.image = UIImage(named : ((items[indexPath.section]?[indexPath.row])! + ".png"))
            cell.myLabelQuant.text=String(currentItems[indexPath.row].quantity)
            
        }
        return cell
    }
 
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        //return(sections.count)
        if searching {
            return 1
        } else {
            return(sections.count)
        }
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
    
    func LoadItems(){
        for (key,value) in items {
            //print("The value to '\(key)' is '\(value)'.")
            for a in value{
                //print (a)
                prueba.append(a)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpSearchBar()
        setUpItems()
        LoadItems()
        searchBar.delegate = self
        myTableView.delegate = self
        myTableView.dataSource = self
        pageView.numberOfPages=imgArr.count
        pageView.currentPage=0
        DispatchQueue.main.async {
            self.timer=Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func productTapInAdd(indexPath: IndexPath) {
        //if let cell = self.tableView.cellForRow(at: indexPath) as? ViewControllerTableViewCell{
        //    cell.isInCart=true
       // }
        let itemSelected = currentItems[indexPath.row]
        //elementInCart
        itemSelected.quantity=1
        print(itemSelected.name)
        //elementInCart[id]=itemSelected
        //elementInCart[id]=productSelected
        myTableView.reloadData()
        
    }
    func productTapInRemove(indexPath: IndexPath) {
        let itemSelected = currentItems[indexPath.row]
        //elementInCart
        itemSelected.quantity=itemSelected.quantity-1
        print(itemSelected.name)
        //elementInCart[id]=itemSelected
        //elementInCart[id]=productSelected
        myTableView.reloadData()
    }
    
    func productTapInPlus(indexPath: IndexPath) {
        let itemSelected = currentItems[indexPath.row]
        //elementInCart
        itemSelected.quantity=itemSelected.quantity+1
        print(itemSelected.name)
        //elementInCart[id]=itemSelected
        //elementInCart[id]=productSelected
        myTableView.reloadData()
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
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == ""
        {
            searching = false
            myTableView.reloadData()
            
        }else{
        searchedItem = prueba.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        myTableView.reloadData()
        }
    }

    
    
}
