//
//  ViewExtension.swift
//  FoodGrab
//
//  Created by jayvee on 3/2/24.
//

import Foundation
import SwiftUI

extension View {
    func bindFocusState<T: Equatable>(_ binding: Binding<T>, with focusState: FocusState<T>) -> some View {
        self
            .onChange(of: binding.wrappedValue) {
                focusState.wrappedValue = $0
            }
            .onChange(of: focusState.wrappedValue) {
                binding.wrappedValue = $0
            }
    }
}
