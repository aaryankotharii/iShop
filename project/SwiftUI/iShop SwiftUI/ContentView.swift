//
//  SwiftUIView.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 28/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session : sessionStore
    var body: some View {
        Group{
        if (session.session != nil){
            Text("Welcome back")
            } else{
                HomeView()
            }
        }.onAppear(perform: getUser)
    }
    func getUser(){
        session.listen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(sessionStore())
    }
}
