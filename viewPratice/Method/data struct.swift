//
//  data struct.swift

import Foundation
import UIKit

struct Stock {
    let name: String
    let stock_code: String
    let imageName: String
    var isLike: Bool
    var likeBtnImageName: String {
        get {
            self.isLike ? "heartOn" : "heartOff"
        }
        set {
            isLike = newValue == "heartOn" ? true : false
        }
    }
}

//struct Genres {
//    let type: String
//    let imageName: String
//    let color: UIColor
//}
