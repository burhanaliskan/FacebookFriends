//
//  FriendListCollectionViewController.swift
//  FacebookFriends
//
//  Created by Burhan Alışkan on 23.07.2021.
//

import UIKit


class FriendListCollectionViewController: UICollectionViewController {
    
    
    var friendsName: String? = ""
    var dataSource: [FriendModel] = []
    var index = 0
        
    var friendListManager = FriendListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        friendListManager.delegate = self
        friendListManager.fetchFriends()
        
    }
}

//MARK: - FriendListManagerDelegate

extension FriendListCollectionViewController: FriendListManagerDelegate {
    func didUpdateFriendList(_ friendListManager: FriendListManager, friendList: FriendModel) {
        DispatchQueue.main.async {
            self.dataSource = friendListManager.friends
            self.friendsName = friendList.name
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UICollectionViewDataSource

extension FriendListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let friendsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FriendsCollectionViewCell {
            
            
            friendsCell.configure(with: dataSource[indexPath.row].name, with: dataSource[indexPath.row].picture)
            configure(friendsCell)
            
            cell = friendsCell
        }
        
        return cell
    }
    
    func configure(_ cell: FriendsCollectionViewCell) {
        let myColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //MARK: - ImageView Design
        cell.imageView.layer.cornerRadius = 15.0
        cell.imageView.layer.shadowColor = myColor.cgColor
        cell.imageView.layer.shadowRadius = 10.0
        cell.imageView.layer.shadowOpacity = 0.1
        cell.imageView.layer.borderWidth = 1.0
        cell.imageView.layer.borderColor = myColor.cgColor
        
        //MARK: - ContentView Design
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = myColor.cgColor
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.shadowColor = myColor.cgColor
        cell.contentView.layer.shadowRadius = 10.0
        cell.contentView.layer.shadowOpacity = 0.1
        
        //MARK: - Label Design
        cell.nameLabel.layer.borderWidth = 1.0
        cell.nameLabel.layer.borderColor = myColor.cgColor
        cell.nameLabel.layer.cornerRadius = 15.0
        cell.nameLabel.layer.shadowColor = myColor.cgColor
        cell.nameLabel.layer.shadowRadius = 10.0
        cell.nameLabel.layer.shadowOpacity = 0.1
        
    }
}

//MARK: - UICollectionViewDelegate

extension FriendListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "goToDetailFriend", sender: self)
    }
}

extension FriendListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 280)
    }
}

//MARK: - Segue Transfer

extension FriendListCollectionViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailFriend" {
            let destinationVC = segue.destination as! DetailFriendsViewController
            destinationVC.imageLink = dataSource[index].picture
            destinationVC.name = dataSource[index].name
            destinationVC.gender = dataSource[index].gender
            destinationVC.location = dataSource[index].location
            destinationVC.email = dataSource[index].email
            destinationVC.birthDate = dataSource[index].birthDate
            destinationVC.age = dataSource[index].age
            destinationVC.phone = dataSource[index].phone
            destinationVC.nationality = dataSource[index].nationality
        }
    }
}

   
