//
//  TestUIView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 15/02/2024.
//

import SwiftUI

struct Account {
    var balance: Int = 0
    
    mutating func add(_ amount: Int) {
        balance += amount
    }
}

struct TestUIView: View {
    @State var account = Account()
   
    var body: some View {
        VStack {
            Text("\(account.balance)")
            Button(action: {self.account.add(100)}) {
                Text("Add transaction")
                    .environment(\.myCustomValue, "Test")
            }
            Button(action: {self.account.balance = 0 }, label: {
                Text("Clear Account Balance")
            })
        }
    }
    

}

struct ContactView: View {
//    @State var contact: Contact
    
    var body: some View {
        TabView {
            OtherView()
                .tabItem {
                    Image(systemName: "paperclip")
                    Text("paper clip")
                }
             Text("Items!")
             .tabItem {
             Image(systemName: "list.bullet")
             Text("Items")
             }
            Text("Moon")
             .tabItem { 
                 Text("Moon")
                 Image(systemName: "moon.circle.fill")
                    
             }
             Text("Person!")
             .tabItem {
             Image(systemName: "person")
             Text("Profile")
             }
         }
//        .tabViewStyle(.page)
//        .background(.pizazz)
////        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OtherView: View {
    var body: some View {
        TabView {
            Text("Hello World")
                .tabItem {
                    Image(systemName: "hammer")
                    Text("Second")
                }
        }
    }
}

struct NameView: View {
    @Binding var name: String
    
    var body: some View {
        VStack{
            TextField("Enter your name", text: $name)
        }
    }
}

struct Contact {
    var name: String = "Shireesh"
}

#Preview {
    TestUIView()
}

#Preview {
    ContactView()
}

struct NameView_preview: PreviewProvider {
    static var previews: some View {
       
        NameView(name: Binding<String>.constant(""))
    }
}

struct StackView: View {
 var body: some View {
     NavigationStack {
             List {
                 NavigationLink(destination: DestinationView()) {
                     Text("Tap me")
                 }
             }
             .navigationTitle("Source")
             .toolbar {
                 ToolbarItem(placement: .primaryAction){
                     EditButton()
                 }
             }
     }
 }
}
struct DestinationView: View {
     var body: some View {
         Text("Destination View")
     }
}

struct StackView_Preview: PreviewProvider {
    static var previews: some View{
        StackView()
    }
}

struct ModalView: View {
    @State private var isPresenting: Bool = false
    
    var body: some View {
        Button(action: {isPresenting = true}){
            Text("Tap me")
        }
        .sheet(isPresented: $isPresenting, content: {
            Text("Modal View")
            Text("Modal View")
            Text("Modal View")
            Text("Modal View")
            Text("Modal View")
            Button(action: {isPresenting = false}, label: {
                Text("Close ModalView")
            })
        })
    }
}

struct ModalView_Preview: PreviewProvider{
    static var previews: some View {
        ModalView()
    }
}


struct EnvironmentView: View {
    @Environment (\.horizontalSizeClass) var sizeClass
    @Environment (\.autocorrectionDisabled) private var greeting
       
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack{
                    Text("Compact")
                        .environment(\.myCustomValue, "Another String")
                }
                .environment(\.isEnabled, false)
            } else {
                HStack {
                    Text("Hstack")
                }
            }
        }
    }
}

private struct MyEnvironmentKey: EnvironmentKey {
    static let defaultValue: String = "Default Value"
}

extension EnvironmentValues {
    var myCustomValue: String {
        get { self[MyEnvironmentKey.self] }
        set { self[MyEnvironmentKey.self] = newValue }
    }
}
