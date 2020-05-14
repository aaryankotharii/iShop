//
//  productsVC.swift
//  iShop
//
//  Created by Aaryan Kothari on 14/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class productsVC: UIViewController {
    /// TableView that displays products
    @IBOutlet var productsTableView: UITableView!
}

extension productsVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK:- SAMPLE CELL
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.detailTextLabel?.text = "Product \(indexPath.row + 1)"
        cell.backgroundView?.backgroundColor = #colorLiteral(red: 0.9985503554, green: 0.9494881034, blue: 0.5791102052, alpha: 1)
        cell.contentView.backgroundColor = #colorLiteral(red: 0.9985503554, green: 0.9494881034, blue: 0.5791102052, alpha: 1)
        return cell
    }
}
