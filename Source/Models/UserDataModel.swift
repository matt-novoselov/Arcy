//
//  UserDataModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 07/05/24.
//

import Foundation
import SwiftData

@Model
class UserDataModel: Identifiable{
    
    var id: UUID
    var userName: String
    var userPicture: Data
    var userScore: Int
    
    init(userName: String, userPicture: Data, userScore: Int) {
        self.id = UUID()
        self.userName = userName
        self.userPicture = userPicture
        self.userScore = userScore
    }
}
