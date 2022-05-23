Q: How to bring the overlay of one section in front always in swift UI inside list view? (by Dipesh Pokhrel)
A: Use Grid View with `.zIndex(1)` to bring forward

```
import SwiftUI

struct DropdownOption: Hashable {
    let key: String
    let value: String
    
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}

struct DropdownRow: View {
    var option: DropdownOption
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    
    var body: some View {
        Button(action: {
            if let onOptionSelected = self.onOptionSelected {
                onOptionSelected(self.option)
            }
        }) {
            HStack {
                Text(self.option.value)
                    .font(.system(size: 14))
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
}

struct Dropdown: View {
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.options, id: \.self) { option in
                    DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
                }
            }
        }
        .frame(minHeight: CGFloat(options.count) * 30, maxHeight: 250)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

struct DropdownSelector: View {
    @State private var shouldShowDropdown = false
    @State private var selectedOption: DropdownOption? = nil
    var placeholder: String
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    var onDropdownSelected: (() -> Void)
    private let buttonHeight: CGFloat = 45
    
    var body: some View {
        Button(action: {
            self.shouldShowDropdown.toggle()
            onDropdownSelected()
        }) {
            HStack {
                Text(selectedOption == nil ? placeholder : selectedOption!.value)
                    .font(.system(size: 14))
                    .foregroundColor(selectedOption == nil ? Color.gray: Color.black)
                
                Spacer()
                
                Image(systemName: self.shouldShowDropdown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 9, height: 5)
                    .font(Font.system(size: 9, weight: .medium))
                    .foregroundColor(Color.black)
            }
        }
        .padding(.horizontal)
        .cornerRadius(5)
        .frame(width: .infinity, height: self.buttonHeight)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        )
        .overlay(
            VStack {
                Image("top-image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                if self.shouldShowDropdown {
                    Spacer(minLength: buttonHeight + 10)
                    Dropdown(options: self.options, onOptionSelected: { option in
                        shouldShowDropdown = false
                        selectedOption = option
                        self.onOptionSelected?(option)
                    })
                }
            }, alignment: .topLeading
        )
        .background(
            RoundedRectangle(cornerRadius: 5).fill(Color.white)
        )
    }
}

struct CellStatus  {
    var zIndex: Double
    var isOpen: Bool
}

struct DropdownSelectorView: View {

    @State private var address: String = ""
    @State private var indexToBringForward = 0
    @State private var eachCellStatus: [CellStatus] = Array(repeating: CellStatus(zIndex: 0, isOpen: false), count: 6)
    
    static var uniqueKey: String {
        UUID().uuidString
    }
    
    let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Sunday"),
        DropdownOption(key: uniqueKey, value: "Monday"),
        DropdownOption(key: uniqueKey, value: "Tuesday"),
        DropdownOption(key: uniqueKey, value: "Wednesday"),
        DropdownOption(key: uniqueKey, value: "Thursday"),
        DropdownOption(key: uniqueKey, value: "Friday"),
        DropdownOption(key: uniqueKey, value: "Saturday")
    ]
    
    private var gridItemLayout = [GridItem(.adaptive(minimum: 200))]

    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach((0..<6), id: \.self) { index in
                    DropdownSelector(
                        placeholder: "Day of the week",
                        options: options,
                        onOptionSelected: { option in
                            print(option)
                        },
                        onDropdownSelected: {
                            eachCellStatus[index].isOpen.toggle()
                            if ( eachCellStatus[index].isOpen ){
                                let cellWithHighestZIndex = eachCellStatus.max(by: {$0.zIndex < $1.zIndex})
                                eachCellStatus[index].zIndex = (cellWithHighestZIndex?.zIndex ?? 0) + 1
                            }
                        }
                    )
                    .padding(.horizontal)
                    .zIndex(eachCellStatus[index].zIndex)
                }
            }
            .zIndex(1)
            
            Group {
                TextField("Full Address", text: $address)
                    .font(.system(size: 14))
                    .padding(.horizontal)
            }
            .frame(width: 400, height: 45)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
}

struct DropdownSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownSelectorView()
    }
}

```
