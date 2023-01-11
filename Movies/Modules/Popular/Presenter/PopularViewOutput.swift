//
//  PopularPopularViewOutput.swift
//

import Foundation

protocol PopularViewOutput {

    func viewOnReady()
    func viewOnAppear()

    func changed(searchText: String)
}
