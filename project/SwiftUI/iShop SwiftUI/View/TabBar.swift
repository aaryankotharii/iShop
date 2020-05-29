//
//  TabBar.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 29/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var NavigationTitles = ["First","Second","Third"]
    
    @State var showingDetail = false
    @State var tabIndex:Int = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabIndex) {
                Text("First View")
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text("First")
                }.tag(0)
                Text("Second View")
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("Second")
                }.tag(1)
                Text("Third View")
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text("Third")
                }.tag(2)
            }.navigationBarTitle(NavigationTitles[tabIndex])
                .navigationBarItems(trailing: Button(action: showProfile){
                    Image(systemName: "person.fill")
                        .renderingMode(.original)
                        .offset(y:45)
                }.sheet(isPresented: $showingDetail){
                    ProfileView()
                })
        }
    }
    func showProfile(){
        print("showing profile")
        self.showingDetail.toggle()
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
