//
//  PreviewModifiers.swift
//  SwimWorkout
//
//  Created by Petr Kravnik on 23.11.2024.
//

import SwiftUI

struct ListEmbedded: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        List {
            content
        }
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var listEmbedded: Self = .modifier(ListEmbedded())
}
