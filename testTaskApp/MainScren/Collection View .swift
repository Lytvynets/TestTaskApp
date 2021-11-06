//
//  Collection View .swift
//  testTaskApp
//
//  Created by Vlad Lytvynets on 06.11.2021.
//

import Foundation
import UIKit
import SDWebImage

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networkManager.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        collectionCustumized.makeShadow(cell: cell, cornerRadius: 2.0, borderWidth: 1.0, borderColor: UIColor.clear.cgColor, backgroundColor: UIColor.lightGray.cgColor, shadowColor: UIColor.darkGray.cgColor, shadowRadius: 5.0, Opacity: 0.5)
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
