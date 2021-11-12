//
//  UserModel.swift
//  TestTaskDirect
//
//  Created by Temur on 11/11/2021.
//

import Foundation
import UIKit

struct UserModel:Decodable{
    let id: String
    let firstName: String
    let lastName: String
    let userTag: String
    let position: String
    let phone: String
    let avatarUrl: String
    let birthday: String
    let department: String
    
}


struct Items: Decodable{
    let items: [UserModel]
}

struct usernet{
    let id: String = ""
    let firstName: String = ""
    let lastName: String = ""
    let userTag: String = ""
    let position: String = ""
    let phone: String = ""
    let avatarUrl: String = ""
    let birthday: String = ""
    let department: String = ""
}
