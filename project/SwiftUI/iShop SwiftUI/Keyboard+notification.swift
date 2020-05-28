//
//  Keyboard+notification.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 24/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import SwiftUI

struct KeyboardAware: ViewModifier {
    @ObservedObject private var keyboard = KeyboardInfo.shared
    
    func body(content: Content) -> some View {
        content
            //.padding(.bottom, self.keyboard.height)
            .offset(x: 0, y: self.keyboard.offsetY)
           // .padding(.bottom,self.keyboard.offsetY)
            .edgesIgnoringSafeArea(self.keyboard.height > 0 ? .bottom : [])
            .animation(.easeOut)
    }
}

struct ImageAware: ViewModifier {
    @ObservedObject private var keyboard = KeyboardInfo.shared
    
    func body(content: Content) -> some View {
        content
            .frame(width: self.keyboard.imageHeight, height: self.keyboard.imageHeight, alignment: .center)
            .padding(.bottom,self.keyboard.imagePadding)
    }
}


extension View {
    public func keyboardAware() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAware())
    }
    
    public func imageAware() -> some View {
        ModifiedContent(content: self, modifier: ImageAware())
    }
}

public class KeyboardInfo: ObservableObject {
    
    public static var shared = KeyboardInfo()
    
    @Published public var height: CGFloat = 0
    @Published public var offsetY: CGFloat = 0
    @Published public var imageHeight: CGFloat = UIScreen.main.bounds.width/5
    @Published public var imagePadding : CGFloat = 40
    @Published public var keyboardIsUp : Bool = false
    
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardChanged(notification: Notification) {
        if notification.name == UIApplication.keyboardWillHideNotification {
            self.height = 0
            self.imageHeight = UIScreen.main.bounds.width/5
            self.imagePadding = 40
            self.offsetY = 0
            withAnimation {
                self.keyboardIsUp = false
            }
        } else {
            self.height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
            self.imageHeight = UIScreen.main.bounds.width/8
            self.imagePadding = 20
            self.offsetY = -30
            withAnimation {
                self.keyboardIsUp = true
            }
        }
    }
}
