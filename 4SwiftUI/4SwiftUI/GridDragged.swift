//
//  GridDragged.swift
//  4SwiftUI
//
//  Created by Khawar Shah on 20.12.2022.
//

//Question: https://stackoverflow.com/questions/74863522/swiftui-how-to-properly-allow-user-to-change-dragged-elements-colour-afer-drag/74873889#74873889

import SwiftUI

struct Cell: View, Hashable, Equatable {
    var color: Color = .red
    let id = UUID()
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.color == rhs.color
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(color)
    }

    var body: some View {
        Rectangle()
            .frame(width: 40, height: 40)
            .foregroundColor(color)
    }
}

struct GridDragged: View {
    
    @State private var cells: [[Cell]] = (0..<10).map { _ in
        (0..<10).map { _ in Cell() }
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(cells, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(row, id: \.id) { cell in
                        cell
                    }
                }
            }
        }
        .background(Color.black)
        .gesture(
            DragGesture()
                .onChanged { value in
                    let width = 40
                    let height = 40
                    let x = Int(value.location.x / CGFloat(width))
                    let y = Int(value.location.y / CGFloat(height))
                    // Make sure the indices are within the bounds of the grid
                    if x >= 0 && x < 10 && y >= 0 && y < 10 {
                        self.cells[y][x].color = .green
                    }
                }
        )
    }
}


struct GridDragged_Previews: PreviewProvider {
    static var previews: some View {
        GridDragged()
    }
}
