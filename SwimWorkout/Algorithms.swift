//
//  Algorithms.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 28.11.2024.
//

import Foundation

extension Sequence {
    func grouped<K, V>(by function: (Element) -> (K, V)) -> [K: V] {
        var ret: [K: V] = [:]
        for element in self {
            let (key, value) = function(element)
            ret[key] = value
        }
        return ret
    }
}
