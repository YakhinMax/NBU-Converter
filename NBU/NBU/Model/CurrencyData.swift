//
//  CurrencyData.swift
//  NBU
//
//  Created by Maxim Yakhin on 30.11.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

struct CurrencyData: Decodable {
    let r030: Int
    let txt: String
    let rate: Double
    let cc: String
    let exchangedate: String
}
