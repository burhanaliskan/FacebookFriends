//
//  CollectionViewCell.swift
//  FacebookFriends
//
//  Created by Burhan Alışkan on 23.07.2021.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with friendsName: String, with imageLink: String) {
        nameLabel.text = friendsName
        
        guard let url = URL(string: imageLink) else {
            return
        }
        getImage(url)
    }
    
    func getImage(_ imageLink: URL)  {
        let task = URLSession.shared.dataTask(with: imageLink) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
        task.resume()
    }
}
