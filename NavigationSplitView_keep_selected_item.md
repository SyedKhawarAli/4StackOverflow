Q: How to keep the selected item on DetailView when picker selection changed
A: You need to add a destination navigationDestination to your VStack like this
Link: https://stackoverflow.com/questions/74719275/how-to-keep-the-selected-item-on-detailview-when-picker-selection-changed
File Name: NavigationSplitView

```
import SwiftUI

struct Model1: Identifiable, Hashable {
  let id = UUID()
  let title: String
  let description: String
}

struct Model2: Identifiable, Hashable {
  let id = UUID()
  let name: String
  let address: String
}


struct CustomData: Identifiable {
  var id =  UUID()
  var docs: [Model1]
  var lites: [Model2]
  
  init(docs: [Model1], lites: [Model2]) {
      self.docs = docs
      self.lites = lites
  }
}

@MainActor
final class TestViewModel: ObservableObject {
    
    @Published var data: CustomData?
    
    func loadData() {
        //FetchData
        let docs = [Model1(title: "title1", description: "desc1"), Model1(title: "title2", description: "desc2"), Model1(title: "title3", description: "desc3")]
        
        let lites = [Model2(name: "value1", address: "desc1"), Model2(name: "value2", address: "desc2"), Model2(name: "value3", address: "desc3")]
        
        self.data = CustomData(docs: docs, lites: lites)
    }
    
    func lites() -> [Model2] {
        return data?.lites ?? []
    }
    
    
    func docs() -> [Model1] {
        return data?.docs ?? []
    }
}

@available(iOS 16.0, *)
struct TestView2: View {
    @State private var subpage = 0
    
    @ObservedObject var viewModel =  TestViewModel()
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Picker("Select option", selection: $subpage) {
                    Text("Lites").tag(0)
                    
                    Text("Docs").tag(1)
                }
                .pickerStyle(.segmented)
                
                //
                VStack() {
                    switch(subpage){
                    case 0: //List of Lites
                        List(viewModel.lites()) { lite in
                            NavigationLink(value: lite) {
                                HStack (alignment: .top) {
                                    Text(lite.name)
                                        .padding(.top, 10)
                                        .padding(.leading, 5)
                                        .font(.system(.headline))
                                }
                            }
                        }
                    case 1:
                        List(viewModel.docs()) { doc in
                            NavigationLink(value: doc) {
                                HStack (alignment: .top) {
                                    Text(doc.title)
                                        .padding(.top, 10)
                                        .padding(.leading, 5)
                                        .font(.system(.subheadline))
                                }
                            }
                        }
                    default:
                        Text("No docs")
                    }
                }
                .accentColor(.blue)
                .padding(.top, 10)
                .scrollContentBackground(.hidden)
                .background(.gray)
                .navigationDestination(for: Model1.self) { doc in
                    DetailView2(path: doc.title)
                }
                .navigationDestination(for: Model2.self) { lite in
                    DetailView2(path: lite.name)
                }
            }
        }
    detail: {
        DetailView2(path: "Example Text")
    }
    .onAppear(){
        viewModel.loadData()
    }
        
    }
}

struct DetailView2: View {
    
    var path: String
    
    var body: some View {
        VStack(spacing: .infinity) {
            Text(path)
        }
        .navigationBarHidden(true)
    }
}

@available(iOS 16.0, *)
struct TestView2_Previews: PreviewProvider {
    static var previews: some View {
        TestView2()
            .previewInterfaceOrientation(.landscapeRight)
            .previewDevice("iPad (9th generation)")
    }
}
```
