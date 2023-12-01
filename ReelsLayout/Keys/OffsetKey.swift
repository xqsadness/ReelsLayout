//
//  OffsetKey.swift
//  ReelsLayout
//
//  Created by darktech4 on 30/11/2023.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect){
        value = nextValue()
    }
}
