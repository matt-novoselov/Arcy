//
//  AppVersionExtension.swift
//  Arcy
//
//  Created by Matt Novoselov on 08/05/24.
//

import SwiftUI

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
