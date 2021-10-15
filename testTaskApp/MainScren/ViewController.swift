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
    
    let decoder = JSONDecoder()
    let session = URLSession.shared
    let sessionConfiguration = URLSessionConfiguration.default
    
    var imageArray = [ImageElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        networking()
    }
    
    
    func networking(){
        guard let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=15") else { return }
        session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            if error == nil, let parsData = data {
                guard let postss = try? strongSelf.decoder.decode([ImageElement].self, from: parsData) else { return }
                strongSelf.imageArray = postss
                
                DispatchQueue.main.async {
                    strongSelf.collection.reloadData()
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                }
            }
            else{
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }.resume()
    }
    
}


//MARK: - Collection View
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
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
        
        let img = imageArray[indexPath.item].downloadURL
        guard let url = URL(string: img) else { return cell}
        cell.postedImage.sd_setImage(with: url, completed: nil)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let img = imageArray[indexPath.item]
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
