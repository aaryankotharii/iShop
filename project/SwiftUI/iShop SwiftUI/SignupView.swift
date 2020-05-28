//
//  SignupView.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 24/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct SignupView: View {
    
    @EnvironmentObject var session : sessionStore
    
    @State private var name : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmpassword : String = ""
    @State var error : String = ""
    
    @ObservedObject private var keyboard = KeyboardInfo.shared
    
    
    
    var body: some View {
        VStack(spacing: 0){
            Image("default")
                .resizable()
                .clipShape(Circle())
                .frame(width: self.keyboard.keyboardIsUp ? 50 : 88, height: self.keyboard.keyboardIsUp ? 50 : 88)
                .padding(.top, self.keyboard.keyboardIsUp ? 0 : 20)
                .padding(.bottom,20)
            
            VStack(spacing:20){
                customTextField(placeholder: "Full Name", text: self.$name)
                customTextField(placeholder: "Email ID", text: self.$email)
                customTextField(placeholder: "Password", text: self.$password)
                customTextField(placeholder: "Confirm Password", text: self.$confirmpassword)
                Button(action: signUp){
                    CustomButton(title: "SIGN UP")
                }
            }
            .padding(.horizontal,40)
            Spacer()
        }.navigationBarTitle(Text("Sign Up"), displayMode: .large)
    }
    
    func signUp(){
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error{
                self.error = error.localizedDescription
                return
            }
            self.email = ""
            self.password = ""
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
