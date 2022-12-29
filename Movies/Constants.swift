//
//  Constants.swift
//

import UIKit

typealias Closure = () -> ()
typealias StringClosure = (String) -> Void
typealias ImageClosure = (UIImage?) -> Void

enum Storyboard {
    static let Main = "Main"
}

enum Offset {
    static let tiny: CGFloat = 5.0
    static let standart: CGFloat = tiny * 2
    static let normal: CGFloat = tiny * 3
    static let big: CGFloat = tiny * 4
}

enum Constants {
    static let cup: String = "🏆"
    
    static let corner: CGFloat = Offset.standart
    static let cellHeight: CGFloat = 110.0
    static let pi: CGFloat = 1.41421
    static let popularMaximum: Int = 100
    
    static let baseURL: String = "https://api.themoviedb.org/3"
    static let imageBaseURL: String = "https://image.tmdb.org/t/p/w500"
    static let apiKeyPlistKey: String = "API_KEY"
    static let apiKeyKey: String = "api_key"
}

enum Alpha {
    static let transparent: CGFloat = 0.05
    static let medium: CGFloat = 0.6
}

enum Assets {
    static let icMore = "ic_more"
}

enum FontSize {
    static let small: CGFloat = 12.0
    static let normal: CGFloat = 16.0
}
