//
//  ApiStructure.swift
//  SwapcardChallenge
//
//  Created by Lucas Alves Da Silva on 12/03/2019.
//  Copyright © 2019 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit


struct Response: Codable {
    var results: [User]
    var info: Info
}

struct User: Codable {
    var gender: String
    var name: Name
    var location: Location
    var email: String
    var login: Login
    var dob: Dob
    var registered: Registered
    var phone: String
    var cell: String
    var id: ID
    var picture: Picture
    var nat: String
}

struct Name: Codable {
    var title: String
    var first: String
    var last: String
}

struct Location: Codable {
    var street: String
    var city: String
    var state: String
    var postcode: Int
    var coordinates: Coordinates
    var timezone: UserTimezone
}

struct Coordinates: Codable{
    var latitude: String
    var longitude: String
}

struct UserTimezone: Codable {
    var offset: String
    var description: String
}

struct Login: Codable {
    var uuid: String
    var username: String
    var password: String
    var salt: String
    var md5: String
    var sha1: String
    var sha256: String
}

struct Dob: Codable {
    var date: String
    var age: Int
}

struct Registered: Codable {
    var date: String
    var age: Int
}

struct ID: Codable {
    var name: String
    var value: String
}

struct Picture: Codable {
    var large: String
    var medium: String
    var thumbnail: String
}

struct Info: Codable {
    var seed: String
    var results: Int
    var page: Int
    var version: String
}
