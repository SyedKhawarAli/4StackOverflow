//
//  LazyVGridTest.swift
//  4SwiftUI
//
//  Created by EAPPLE on 23/05/2022.
//

import SwiftUI

struct LazyVGridTest: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    private var colors: [Color] = [.yellow, .purple, .green, .orange, .cyan ]
    
    private var gridItemLayout = [GridItem(.adaptive(minimum: 50))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach((0...9999), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(width: 50, height: 50)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct LazyVGridTest_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGridTest()
    }
}
