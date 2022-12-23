//
//  secondViewController.swift
//  PhnTechTask
//
//  Created by STC on 22/12/22.
//

import UIKit
import SDWebImage
class secondViewController: UIViewController {
    
    @IBOutlet weak var name: UIBarButtonItem!
    
    @IBOutlet weak var productTableView: UITableView!
    var jwelaries = [ApiResponse]()
    var products = [ApiResponse]()
    var timer : Timer?
    var currentIndex = 0
    var dataFromFVC : String?
    @IBOutlet weak var jwelariesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourceAndDelegate()
        dataFetchingFromApi()
        dataFetchingFromApi2()
        registerNib()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(SlideToNext), userInfo: nil, repeats: true)
        self.name.title = dataFromFVC
    }
    @objc func SlideToNext(){
        if currentIndex < jwelaries.count-1
        {
            currentIndex = currentIndex + 1
        }
        else{
            currentIndex = 0
          }
        jwelariesCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
    }
    
    func registerNib(){
        let nibName = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        jwelariesCollectionView.register(nibName, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        let nibname3 = UINib(nibName: "productTableViewCell", bundle: nil)
        productTableView.register(nibname3, forCellReuseIdentifier: "productTableViewCell")
    }
    func dataSourceAndDelegate(){
        jwelariesCollectionView.dataSource = self
        jwelariesCollectionView.delegate = self
        productTableView.dataSource  = self
        productTableView.delegate = self
    }
    func  dataFetchingFromApi(){
        let myUrl = "https://fakestoreapi.com/products"
        var url = URL(string: myUrl)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let  datatask = session.dataTask(with: request){ data ,responce , error in
            print(data)
            print("responce\(responce)")
            let jsonObj = try! JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
            guard data != nil else {
                print("data not found")
                return
            }
            for dictinary in jsonObj {
                let eachdictionary = dictinary as! [String : Any]
                var proTitle = eachdictionary["title"] as! String
                var ProCategory = eachdictionary["category"] as! String
                var ProImage = eachdictionary["image"] as! String
              
                let newProoduct = ApiResponse(title: proTitle, category: ProCategory, image1: ProImage)
                self.jwelaries.append(newProoduct)
            }
            
            DispatchQueue.main.async {
                self.jwelariesCollectionView.reloadData()
            }
        }.resume()
    }
    func  dataFetchingFromApi2(){
        let myUrl = "https://fakestoreapi.com/products"
        var url = URL(string: myUrl)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let  datatask = session.dataTask(with: request){ data ,responce , error in
            print(data)
            print("responce\(responce)")
            let jsonObj = try! JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
            guard data != nil else {
                print("data not found")
                return
            }
            for dictinary in jsonObj {
                let eachdictionary = dictinary as! [String : Any]
                var proTitle = eachdictionary["title"] as! String
                var ProCategory = eachdictionary["category"] as! String
                var ProImage = eachdictionary["image"] as! String
              
                let newProoduct = ApiResponse(title: proTitle, category: ProCategory, image1: ProImage)
                self.products.append(newProoduct)
            }
            
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        }.resume()
    }
    
}
extension secondViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jwelaries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  collectionCell = jwelariesCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        let img = NSURL(string: jwelaries[indexPath.row].image1)
        collectionCell.productImage.sd_setImage(with: img as URL?)
        return collectionCell
    }
}
extension secondViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 250, height: 100)
    }
}
extension secondViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jwelaries.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        jwelaries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = productTableView.dequeueReusableCell(withIdentifier: "productTableViewCell", for: indexPath) as! productTableViewCell
        tableCell.labelOnTableView.text = jwelaries[indexPath.row].category
        return tableCell
    }
}
extension secondViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}
