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

struct NavEmbedded: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        NavigationStack {
            content
        }
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var listEmbedded: Self = .modifier(ListEmbedded())
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var navEmbedded: Self = .modifier(NavEmbedded())
}
