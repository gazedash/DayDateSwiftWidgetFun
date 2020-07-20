//
//  DayData.swift
//  DayBattery
//
//  Created by Andrey Efremov on 20.07.2020.
//

import Foundation

struct DayData: Identifiable, Codable {
    let percent: String
    let date: Date

    var id: String { percent }
}
