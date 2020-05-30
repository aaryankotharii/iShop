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
    @State private var isAnimating = false
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9948013425, green: 0.5377405882, blue: 0.26955688, alpha: 1)),Color(#colorLiteral(red: 0.9937531352, green: 0.2513984144, blue: 0.352616936, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 255, height: 255)
                    .clipShape(Circle())
                    .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                    .animation(self.isAnimating ? foreverAnimation : .default)
                    .onAppear { self.isAnimating = true }
                    .onDisappear { self.isAnimating = false }
                AsyncImage(url: URL(string: "https://lh3.googleusercontent.com/a-/AOh14Gh-Bpoh37OUtOAdJOpfu1EpZCC0QrYZJ9w8jGzX_Q=s96-c")!)
                    .frame(width: 240, height: 240)
                    .clipShape(Circle())
            }.padding(.top,100)
            Spacer()
            Button(action: logout){
                CustomButton(title: "LOGOUT")
            }.padding(.bottom,50)
        }
        .padding(.horizontal, 40.0)
        .navigationBarTitle(Text("Profile"), displayMode: .large)
        .onAppear {
            print("appear")
                self.session.getProfileImageUrl(completion: { (url) in
                    //self.profieImage = URLImage(url: url)
                })
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
