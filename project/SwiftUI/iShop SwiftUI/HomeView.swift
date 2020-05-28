//
//  ContentView.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 24/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI
import Combine


struct HomeView: View {
    @EnvironmentObject var session : sessionStore

    @ObservedObject private var keyboard = KeyboardInfo.shared
    
    @State var email : String = ""
    @State var password : String = ""
    @State var error : String = ""


    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Image("gardient")
                        .offset(y: self.keyboard.keyboardIsUp ? -15 : 0)
                        .padding(.bottom,self.keyboard.keyboardIsUp ? -15 : 0)
                    Image("logo").scaleEffect(self.keyboard.keyboardIsUp ? 0.8 : 1)
                }
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Hello")
                                .font(.system(size: 50, weight: .bold))
                            Text("Sign in to your account")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(Color(#colorLiteral(red: 0.325458765, green: 0.325510323, blue: 0.3254474401, alpha: 1)))
                        }
                        Spacer()
                    }
                    VStack(spacing:20){
                        customTextField(placeholder: "Email", text: $email)
                        customTextField(placeholder: "Password", text: $password)
                        HStack{
                            Spacer()
                            Button(action: forgotPassword){
                                Text("Forgot Password?")
                                    .foregroundColor(Color(red: 0.286, green: 0.282, blue: 0.286))
                                    .font(.system(size: 18, weight: .thin))
                            }
                        }
                    }
                }
                .padding(.horizontal, 40.0)
                .offset(y: self.keyboard.keyboardIsUp ? -30 : 0)
                
                Button(action: login){
                    CustomButton(title: "LOGIN")
                }.padding(.horizontal, 40.0)
                    .padding(.top,10)
                Spacer()
                orLabel()
                HStack{
                    NavigationLink(destination: SignupView()) {
                        Image("signup")
                            .renderingMode(.original)
                    }
                    Spacer()
                    Button(action: googleSignin){
                        Image("google")
                            .renderingMode(.original)
                    }
                }.padding(.horizontal, 22.5)
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func signIn(){
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error{
                self.error = error
                return
            }
            
        }
    }
    
    func forgotPassword(){
        print("forgot password")
    }
    
    func login(){
        print("Login")
    }
    
    func emailSignUp(){
        print("email sign up")
    }
    func googleSignin(){
        print("google sign up")
    }
}


struct orLabel : View{
    var body :some View{
        HStack{
            Color(#colorLiteral(red: 0.2748741508, green: 0.2901260555, blue: 0.3430637717, alpha: 1)).frame(height: 1)
            Text("OR")
            Color(#colorLiteral(red: 0.2748741508, green: 0.2901260555, blue: 0.3430637717, alpha: 1)).frame(height: 1)
        }.padding(.horizontal, 20.0)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
