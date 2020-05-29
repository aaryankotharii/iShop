//
//  ProfileView.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 29/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session : sessionStore
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    var body: some View {
        Button(action: logout){
            Text("logout")
        }
    }
    func logout(){
        self.presentationMode.wrappedValue.dismiss()
        self.isPresented = false
        session.signOut()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isPresented: .constant(true))
    }
}
