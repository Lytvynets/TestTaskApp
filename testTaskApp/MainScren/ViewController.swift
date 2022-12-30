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
    var collectionCustumized = CollectionCustumized()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.itemSize = CGSize(width: view.frame.width / 5, height: view.frame.height / 7)
        collection.setCollectionViewLayout(layout, animated: true)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        networkManager.networking(vc: self, collectionView: collection)
        collection.reloadData()
    }
}
