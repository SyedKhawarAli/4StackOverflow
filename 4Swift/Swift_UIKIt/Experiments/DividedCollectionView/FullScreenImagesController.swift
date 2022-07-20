//
//  FullScreenImagesController.swift
//  Swift_UIKIt
//
//  Created by EAPPLE on 24/05/2022.
//

import Foundation
import UIKit

class FullScreenImagesController: UIViewController {
    
    var cellModel: CellModel?
    @IBOutlet var tableView: UITableView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FullScreenImagesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel?.imageNames.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FullScreenTableViewCell
        cell.cellImage.image = UIImage(named: cellModel?.imageNames[indexPath.row] ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}

class FullScreenTableViewCell: UITableViewCell {
    @IBOutlet var cellImage: UIImageView!
}
