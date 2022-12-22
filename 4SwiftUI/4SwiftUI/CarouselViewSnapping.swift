//
//  CarouselViewSnapping.swift
//  4SwiftUI
//
//  Created by Khawar Shah on 22.12.2022.
//
// Question: https://stackoverflow.com/questions/74883080/carouselview-not-snapping-onto-the-image/74889709#74889709

import SwiftUI

struct Home: View {
    @State var currentIndex: Int = 0
    @State var posts: [Post] = []
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 15){
                Text("Testing Carousel View Snapping")
                    .font(.title)
                    .fontWeight(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            // Carousel snapping
            CarouselViewSnapping(spacing: 15, index: $currentIndex, items: posts) { post in
                
                GeometryReader { proxy in
                    
                    let size = proxy.size
                    
                    Image(post.postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width)
                        .cornerRadius(12)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear{
            for index in 1...5 {
                posts.append(Post(postImage: "post\(index)"))
            }
        }
    }
}

struct CarouselViewSnapping_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct CarouselViewSnapping<Content : View,T: Identifiable>: View{
    var content: (T) -> Content
    var list: [T]
    
    // Properties...
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    init(spacing: CGFloat = 15,trailingSpace: CGFloat = 100,index: Binding<Int>,items: [T],@ViewBuilder content: @escaping (T)->Content)
    {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    //offset
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        
        GeometryReader{ proxy in
            
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2) - spacing*2
            
            HStack(spacing: spacing){
                ForEach(list){item in
                    content(item)
                        .frame(width: proxy.size.width - (trailingSpace + spacing))
                }
                .padding(.horizontal,spacing)
                .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustMentWidth : 0) + offset)
                .gesture(
                    DragGesture()
                        .updating($offset, body: { value, out, _ in
                            
                            out = value.translation.width
                        })
                        .onEnded({ value in
                            
                            //Update current index for scroll
                            let offsetX = value.translation.width
                            
                            //convert the translation into progress (0-1)
                            //round the value based on the currentIndex
                            
                            let progress = -offsetX / width
                            
                            let roundIndex = progress.rounded()
                            
                            //setting max and min
                            currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                            
                            //updating index
                            currentIndex = index
                        })
                        .onChanged({ value in
                            let offsetX = value.translation.width
                            
                            //convert the translation into progress (0-1)
                            //round the value based on the currentIndex
                            
                            let progress = -offsetX / width
                            
                            let roundIndex = progress.rounded()
                            
                            //setting max and min
                            index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        })
                )
            }
            
        }
        //animation when offset = 0
        .animation(.easeInOut, value: offset == 0)
    }
}

struct Post: Identifiable {
    var id = UUID().uuidString
    var postImage: String
}
