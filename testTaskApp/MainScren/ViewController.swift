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
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        networkManager.networking(vc: self, collectionView: collection)
    }
}
