//
//  Network manager.swift
//  testTaskApp
//
//  Created by Vlad Lytvynets on 06.11.2021.
//

import Foundation
import UIKit
import SDWebImage

class NetworkManager {
    
    
    let decoder = JSONDecoder()
    let session = URLSession.shared
    let sessionConfiguration = URLSessionConfiguration.default
    
    var imageArray = [ImageElement]()
    
    func networking(vc: ViewController, collectionView: UICollectionView){
        guard let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=15") else { return }
        session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            if error == nil, let parsData = data {
                guard let postss = try? strongSelf.decoder.decode([ImageElement].self, from: parsData) else { return }
                strongSelf.imageArray = postss
                
                DispatchQueue.main.async {
                    collectionView.reloadData()
                    vc.activityIndicator.isHidden = true
                    vc.activityIndicator.stopAnimating()
                }
            }
            else{
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }.resume()
    }
}
