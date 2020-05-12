//
//  TabBarVC.swift
//  iShop
//
//  Created by Aaryan Kothari on 12/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

 private let imageView = UIImageView(image: UIImage(named: "default"))

    /// WARNING: Change these constants according to your project's design
    private struct Const {
      /// Image height/width for Large NavBar state
      static let ImageSizeForLargeState: CGFloat = 40
      /// Margin from right anchor of safe area to right anchor of Image
      static let ImageRightMargin: CGFloat = 16
      /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
      static let ImageBottomMarginForLargeState: CGFloat = 12
      /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
      static let ImageBottomMarginForSmallState: CGFloat = 6
      /// Image height/width for Small NavBar state
      static let ImageSizeForSmallState: CGFloat = 32
      /// Height of NavBar for Small state. Usually it's just 44
      static let NavBarHeightSmallState: CGFloat = 44
      /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
      static let NavBarHeightLargeState: CGFloat = 96.5
    }

    /**
     Setup the image in navbar to be on the same line as the navbar title
     */
    private func setupUI() {
      navigationController?.navigationBar.prefersLargeTitles = true
      title = "Large Title"

      // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
      guard let navigationBar = self.navigationController?.navigationBar else { return }

      navigationBar.addSubview(imageView)

      // setup constraints
      imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
      imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
        imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
        imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
      ])
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileTapped)))
        imageView.isUserInteractionEnabled = true
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      // setup Settings navigation bar button
      setupUI()
    }
    
    @objc func profileTapped(){
        print("tap")
    }
}
