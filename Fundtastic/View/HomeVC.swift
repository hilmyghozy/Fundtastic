//
//  HomeVC.swift
//  Fundtastic
//
//  Created by hilmy ghozy on 06/12/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var category = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        uiSetup()
    }
    
    func uiSetup(){
        title = "Category"
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: screenWidth/3.4, height: screenHeight/6)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        collectionView!.collectionViewLayout = layout
        collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        self.view.addSubview(collectionView!)
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        
        let items = self.category[indexPath.row]
        
        cell.titleLabel.text = items.capitalized
        cell.imageView.image = UIImage(named: "ic-\(items)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let items = self.category[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController{
            vc.category = items
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
