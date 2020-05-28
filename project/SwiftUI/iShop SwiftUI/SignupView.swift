//
//  SignupView.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 24/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

//TODO refactor image modifier
struct SignupView: View {
    
    @EnvironmentObject var session : sessionStore
    
    @State private var name : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmpassword : String = ""
    @State var error : String = ""
    @State private var showingImagePicker = false
    @State private var inputImage : UIImage?
    @State var profileImage : Image?
    
    @ObservedObject private var keyboard = KeyboardInfo.shared
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                if profileImage != nil {
                    profileImage!
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: self.keyboard.keyboardIsUp ? 50 : 88, height: self.keyboard.keyboardIsUp ? 50 : 88)
                        .padding(.top, self.keyboard.keyboardIsUp ? 0 : 20)
                        .padding(.bottom,20)
                        .onTapGesture {
                            self.showingImagePicker = true
                    }
                }else {
                    Image("default")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: self.keyboard.keyboardIsUp ? 50 : 88, height: self.keyboard.keyboardIsUp ? 50 : 88)
                        .padding(.top, self.keyboard.keyboardIsUp ? 0 : 20)
                        .padding(.bottom,20)
                        .onTapGesture {
                            self.showingImagePicker = true
                    }
                }
            }
            
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
            .sheet(isPresented: $showingImagePicker,onDismiss: loadImage){
                ImagePicker(image: self.$inputImage)
        }
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
    
    func loadImage(){
        guard let inputImage = inputImage else { return}
        profileImage = Image(uiImage: inputImage)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
