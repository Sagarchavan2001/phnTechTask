//
//  productTableViewCell.swift
//  PhnTechTask
//
//  Created by STC on 22/12/22.
//

import UIKit
import SDWebImage
class productTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var jwelaries2 = [ApiResponse]()
   
    
    @IBOutlet weak var labelOnTableView: UILabel!
    
    @IBOutlet weak var product2CollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        datasourceAnddegate1()
        dataFetchingFromApi()
        
        let nibName2 = UINib(nibName: "product2CollectionViewCell", bundle: nil)
        product2CollectionView.register(nibName2, forCellWithReuseIdentifier: "product2CollectionViewCell")
    }
    func datasourceAnddegate1(){
        product2CollectionView.delegate = self
        product2CollectionView.dataSource = self
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
                self.jwelaries2.append(newProoduct)
            }
            
            DispatchQueue.main.async {
                self.product2CollectionView.reloadData()
            }
        }.resume()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jwelaries2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell2 = product2CollectionView.dequeueReusableCell(withReuseIdentifier: "product2CollectionViewCell", for: indexPath) as! product2CollectionViewCell
        collectionCell2.label2.text = jwelaries2[indexPath.row].title
        let img2 = NSURL(string: jwelaries2[indexPath.row].image1)
        collectionCell2.product2image.sd_setImage(with: img2 as URL?)
        return collectionCell2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 220, height: 190)
    }
    
}

