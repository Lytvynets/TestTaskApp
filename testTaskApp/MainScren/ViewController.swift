//
//  ViewController.swift
//  testTaskApp
//
//  Created by Vlad Lytvynets on 11.10.2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collection: UICollectionView!
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        networkManager.networking(vc: self, collectionView: collection)
    }
}


//MARK: - Collection View
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networkManager.imageArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.backgroundColor = UIColor.lightGray.cgColor
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.layer.cornerRadius = 5
        cell.postedImage.layer.cornerRadius = 5
        
        let img = networkManager.imageArray[indexPath.item].downloadURL
        guard let url = URL(string: img) else { return cell}
        cell.postedImage.sd_setImage(with: url, completed: nil)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let img = networkManager.imageArray[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let imageDetails = storyboard.instantiateViewController(identifier: "ImageDetails") as? ImageDetails else { return }
        imageDetails.author = img.author
        imageDetails.hight = img.height
        imageDetails.width = img.width
        imageDetails.largeImage = img.downloadURL
        show(imageDetails, sender: nil)
        print("Image info: \(img.id), \(img.author)")
    }
}
