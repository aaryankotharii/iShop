//
//  TabBar.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 29/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView{
            TabView {
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
            }
            
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
