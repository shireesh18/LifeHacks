//
//  ForEachUIView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 16/02/2024.
//

import SwiftUI

struct ForEachUIView: View {
   @State var strings = [
    "first",
    "second",
    "third",
    "fourth",
    "fifth"
    ]
    
    @State var canids = ["Wolf", "Jackal", "Coyote", "Fox", "Dog"]
    @State var felids = ["Leopard", "Lion", "Jaguar", "Tiger", "Cat"]
    
    var body: some View {
//        List{
//            Text("Hello World")
//                .font(.largeTitle)
//            Text("Welcome to SwiftUI")
//                .font(.headline)
//            HStack{
//                Image(systemName: "flame")
//                    .font(.largeTitle)
//                Text("This is a stack")
//            }
//            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
//            .listRowInsets(.init(top: 40.0, leading: 0.0, bottom: 40, trailing: 0.0))
//        }
//        VStack {
//            List {
//                ForEach(strings, id:\.self){ string in
//                    Text(string)
//                }
//                Button(action: {strings.shuffle()}, label: {
//                    Text("Shuffle")
//                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
//                })
//            }
//            .animation(.default, value: strings)
            
            List{
                Section(header: Text("Canids")) {
                    ForEach(canids, id: \.self) {canid in
                        Text(canid)
                    }
                    .onDelete(perform: { canids.remove(atOffsets: $0) })
                }
                Section(header: Text("Felids")) {
                    ForEach(felids, id: \.self){ felid in
                        Text(felid)
                    }
                    .onMove(perform: { felids.move(fromOffsets: $0, toOffset: $1)
                    })
                }
            }
//        }
    }
}

#Preview {
    ForEachUIView()
}
