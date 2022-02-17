//
//  UIFontIconsDemoApp.swift
//  Shared
//
//  Created by Brian Strobach on 1/14/22.
//

import SwiftUI
import UIFontLoader
@main
struct UIFontIconsDemoApp: App {
    init() {
        FontLoader.loadAllFonts()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
