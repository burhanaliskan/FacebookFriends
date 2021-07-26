//
//  FriendListManager.swift
//  FacebookFriends
//
//  Created by Burhan Alışkan on 24.07.2021.
//

import UIKit

protocol FriendListManagerDelegate {
    func didUpdateFriendList(_ friendListManager: FriendListManager, friendList: FriendModel)
    func didFailWithError(error: Error)
}

class FriendListManager {
    let baseUrl = "https://randomuser.me/api/?results=10"
        
    var delegate: FriendListManagerDelegate?

    var friends: [FriendModel] = []
    
    func fetchFriends() {
        let urlString = baseUrl
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let friendList = self.parseJson(safeData) {
                        self.delegate?.didUpdateFriendList(self, friendList: friendList)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ friendListData: Data) -> FriendModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(FriendData.self, from: friendListData)

            var friendList = FriendModel(gender: "", name: "", location: "", email: "", birthDate: "", age: 0, phone: "", picture: "", nationality: "")
            
            for index in 0 ... decodedData.results.count - 1 {
                let gender = decodedData.results[index].gender
                let name = decodedData.results[index].name.title + " " + decodedData.results[index].name.first + " " + decodedData.results[index].name.last
                let location = decodedData.results[index].location.city
                let email = decodedData.results[index].email
                let birth = decodedData.results[index].dob.date
                let indexBirth = birth.index(birth.startIndex, offsetBy: 10)
                let birthDate = String(birth[..<indexBirth])
                let age = decodedData.results[index].dob.age
                let phone = decodedData.results[index].phone
                let picture = decodedData.results[index].picture.large
                let nationality = decodedData.results[index].nat
                
                friendList = FriendModel(gender: gender, name: name, location: location, email: email, birthDate: birthDate, age: age, phone: phone, picture: picture, nationality: nationality)
                    friends.append(friendList)
            }
            
            return friendList
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
