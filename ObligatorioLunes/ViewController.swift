//
//  ViewController.swift
//  ObligatorioLunes
//
//  Created by Adrian Perez Garrone on 29/4/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ProductTableViewCellDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var slideCollectionView: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    
    var imgArr=[UIImage(named:"Banner-1"),UIImage(named:"Banner-2"),UIImage(named:"Banner-3"),UIImage(named:"Banner-4")]
    var timer=Timer()
    var counter=0
    let sections=["fruits","veggies"]
    //let items=[["kiwi","Watermelon","Grapefruit"],
    //["Avocado","Cucumber"]]
    let items = [0 : ["kiwi","Watermelon","Grapefruit"], 1:["Avocado","Cucumber"]]
    //var currentSection[]()
    //let fruits = [SupermarketItem]()
    //let veggies = [SupermarketItem]()
    var searchedItem = [String]()
    var prueba = [String]()
    var searching = false
    //var items = [SupermarketItem]()
    //var currentItems = [SupermarketItem]()
    var elementInCart=[String:Int]()
    
    //private func setUpItems() {
        // Fruits
      //  items.append(SupermarketItem(quantity:0, price:30, name: "kiwi", category: .fruits))
      //  items.append(SupermarketItem(quantity:0, price:30, name: "Watermelon", category: .fruits))
       // items.append(SupermarketItem(quantity:0, price:45, name: "Grapefruit", category: .fruits))
        // Veggies
       // items.append(SupermarketItem(quantity:0, price:30, name: "Avocado", category: .veggies))
        //items.append(SupermarketItem(quantity:0, price:45, name: "Cucumber", category: .veggies))

        
        //currentItems = items
    //}
    
    //let kiwi = SupermarketItem (quantity: 0, price: 30,name: "kiwi")
    //let watermelon = SupermarketItem (quantity: 0, price: 45,name: "watermelon")
    //let grapefruit = SupermarketItem (quantity: 0, price: 45,name: "grapefruit")
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
        //return currentItems[section].category.rawValue
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searching {
            return searchedItem.count
        } else {
            return(items[section]!.count)
        }
        //return(currentItems[section].category.rawValue.count)
        //if(currentItems[section].category.rawValue=="Fruit"){
         //   print (currentItems[section].category.rawValue)
          //  return(fruits.count)
        //}else{
         //   print(currentItems[section].category.rawValue)
          //  return(veggies.count)
        //}
    }
    // func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //   return 100
    //}
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        if searching {
            cell.MyLabel.text = searchedItem[indexPath.row]
            cell.myImage.image = UIImage(named : (searchedItem[indexPath.row] + ".png"))
            cell.myImage.layer.cornerRadius = cell.myImage.frame.width / 2.0
        } else {
            cell.MyLabel.text = items[indexPath.section]?[indexPath.row]
            cell.myImage.image = UIImage(named : ((items[indexPath.section]?[indexPath.row])! + ".png"))
            cell.myImage.layer.cornerRadius = cell.myImage.frame.width / 2.0
            
        }
        return cell
        
        /*
        //cell.myImage.image = UIImage(named : (currentItems[indexPath.section][indexPath.row] + ".png"))
        cell.myImage.image = UIImage(named : (currentItems[indexPath.section][indexPath.row].description + ".png"))
        cell.myImage.layer.cornerRadius = cell.myImage.frame.width / 2.0
        //print (cell.myImage.frame)
        //cell.MyLabel.text = currentItems[indexPath.section][indexPath.row]
        cell.MyLabel.text = currentItems[indexPath.section][indexPath.row].description
        print (currentItems[indexPath.section][indexPath.row].description)
        //currentItems[indexPath.section]=currentItems[indexPath.row].category
        //cell.myLabelQuant.text=String(kiwi.quantity);
        return(cell)
        */
    }
    
    //Search Bar
    //private func setUpSearchBar(){
     //   searchBar.delegate = self
   // }
    
  /*  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentItems = items
            myTableView.reloadData()
            return
            
        }
        currentItems=items.filter({ item -> Bool in
            item.name.uppercased().contains(searchText.uppercased())
        })
        myTableView.reloadData()
    }*/
    
    
    
    // func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    //  <#code#>
    //}
    
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
        //setUpItems()
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
    
    func productTapInAdd(id: Int, indexPath: IndexPath) {
        //let itemSelected=items[indexPath.section]
        //itemSelected.quantity=1
        //print(itemSelected)
    }
    
    func productTapInRemove(id: Int, indexPath: IndexPath) {
        print ("hola")
    }
    
    func productTapInPlus(id: Int, indexPath: IndexPath) {
        print ("hola")
    }
    
    
    @IBAction func RemoveItemButton(_ sender: UIButton) {
        //kiwi.quantity=kiwi.quantity-1
        //print (kiwi.quantity)
    }
    @IBAction func AddItemButton(_ sender: UIButton) {
        //kiwi.quantity=kiwi.quantity+1
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
    /*
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == " "{
            searching = false
            myTableView.reloadData()
        }
        searchedItem = items.values.filter({ item -> Bool in
            item.lowercased().contains(searchText.lowercased())
            //searchedItem = items.values.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
           // searching = true
            myTableView.reloadData()

        //for a in items{
        //searchedItem = a.filter({ item -> Bool in
         //   item.lowercased().contains(searchText.lowercased())
        })

        //}
    }*/
    

    
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
        
        
       /*
        for (key, value) in items {
            //print("The value to '\(key)' is '\(value)'.")
            for a in value{
                //print (a)
                prueba.append(a)
            }
            guard !searchText.isEmpty else {
                searchedItem = prueba
                myTableView.reloadData()
                return
            
            }
            print (prueba)
            searchedItem=prueba.filter{ $0.lowercased().contains(searchText.lowercased()) }
            myTableView.reloadData()
        }
        //guard !searchText.isEmpty else {
         //   searchedItem = items
          //  myTableView.reloadData()
           // return
            
        //}
        //searchedItem=items.filter{ $0.lowercased().contains(searchText.lowercased()) }
        //myTableView.reloadData()
  */
    }

    
    
}
