//
//  Custom+UI.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 24/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct CustomButton: View{
    var title : String
    var body : some View {
        Text(title)
            .frame(minWidth: .zero, maxWidth: .infinity)
            .frame(height: 50)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9948013425, green: 0.5377405882, blue: 0.26955688, alpha: 1)),Color(#colorLiteral(red: 0.9937531352, green: 0.2513984144, blue: 0.352616936, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .font(.system(size: 22, weight: .bold))
            .cornerRadius(8)
    }
}



struct customTextField: View {
    var placeholder : String
    @Binding var text : String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(.all)
            //.aspectRatio(7.444, contentMode: .fit)
            .frame(minWidth: .zero, maxWidth: .infinity)
            .frame(height: 50)
            .textFieldStyle(PlainTextFieldStyle())
            .background(RoundedRectangle(cornerRadius: 7).stroke(Color(#colorLiteral(red: 0.7764018178, green: 0.776514709, blue: 0.7763772011, alpha: 1))))
        
    }
}
