//
//  ContentView.swift
//  Shared
//
//  Created by Brian Strobach on 1/14/22.
//

import SwiftUI
import UIFontIcons
import Feather
import FontAwesome
import MaterialIcons
import UIFontLoader

struct ContentView: View {
    var body: some View {
        Text(Feather.Image.rawValue)
            .font(.custom(Feather.name(), size: 10))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//extension FontLoader {
//    static func fontNames() -> [URL] {
//        let bundle = Bundle.main
//       let filenames = ["Feather"]
//       return filenames.map { bundle.url(forResource: $0, withExtension: "ttf")! }
//     }
//}
