//
//  FriendData.swift
//  FacebookFriends
//
//  Created by Burhan Alışkan on 24.07.2021.
//

import Foundation

struct FriendData: Codable {
    let results: [Results]
}

//MARK: - Results Section

struct Results: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let dob: Birth
    let phone: String
    let picture: Picture
    let nat: String
}

//MARK: - Name Section

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

//MARK: - Location Section

struct Location: Codable {
    let city: String
    let state: String
    let country: String
    let coordinates: Coordinates
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

//MARK: - Birth Section

struct Birth: Codable {
    let date: String
    let age: Int
}

//MARK: - Picture Section

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
