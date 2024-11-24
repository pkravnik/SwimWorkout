//
//  UnitSpeed+Unit.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 24.11.2024.
//

import Foundation

extension UnitSpeed {
    static let metersPerMinute = UnitSpeed(symbol: "m/min", converter: UnitConverterLinear(coefficient: 1.0/60.0))
}
