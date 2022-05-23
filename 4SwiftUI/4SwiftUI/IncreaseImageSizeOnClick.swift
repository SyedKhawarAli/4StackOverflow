//
//  IncreaseImageSizeOnClick.swift
//  4SwiftUI
//
//  Created by EAPPLE on 23/05/2022.
//

import SwiftUI

struct IncreaseImageSizeOnClick: View {
    @State private var selected: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "camera.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    selected.toggle()
                }
                .scaleEffect(self.selected ? 1.5 : 1)
        }
        .frame(width: 200, height: 200, alignment: .center)
    }
}

struct IncreaseImageSizeOnClick_Previews: PreviewProvider {
    static var previews: some View {
        IncreaseImageSizeOnClick()
    }
}
