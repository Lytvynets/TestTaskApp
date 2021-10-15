//
//  imageDetails.swift
//  testTaskApp
//
//  Created by Vlad Lytvynets on 11.10.2021.
//

import Foundation
import UIKit
import SDWebImage

class ImageDetails: UIViewController {
    
    var largeImage = ""
    var author = ""
    var hight = 0
    var width = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var autorNameLabel: UILabel!
    @IBOutlet weak var hightLable: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.layer.cornerRadius = 15
        self.autorNameLabel.text = self.author
        self.hightLable.text = "\(self.hight)"
        self.widthLabel.text = "\(self.width)"
        let imageURL = URL(string: largeImage)
        self.imageView.sd_setImage(with: imageURL , completed: nil)
    }
    
    
    @IBAction func downloadButton(_ sender: UIButton) {
        guard let imgDownload = URLComponents (string: largeImage) else { return }
        UIApplication.shared.open(imgDownload.url! , options: [:], completionHandler: nil)
    }
    
}
