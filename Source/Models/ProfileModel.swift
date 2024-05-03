//
//  TestModel.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import Foundation
import SwiftData

@Model
class ProfileData {
    var userName: String
    var myImage640: Data? = nil

    init(userName: String) {
        self.userName = userName
    }
}
