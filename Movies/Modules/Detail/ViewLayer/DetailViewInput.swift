//
//  DetailDetailViewInput.swift
//

import Foundation

enum DetailState {
    case posterURL(String)
    case overview(String)
    case rating(Double)
    case cast(String)
}

protocol DetailViewInput: BaseModuleViewInput {
    func update(state: DetailState)
}
