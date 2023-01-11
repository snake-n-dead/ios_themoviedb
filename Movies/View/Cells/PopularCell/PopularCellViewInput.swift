//
//  PopularCellViewInput.swift
//

import Foundation

enum PopularCellState {
    case title(String)
    case genres(String)
    case posterURL(String)
    case rating(Double)
    case ratingValue(Float)
}

protocol PopularCellViewInput {
    
    func refresh(state: PopularCellState)
}
