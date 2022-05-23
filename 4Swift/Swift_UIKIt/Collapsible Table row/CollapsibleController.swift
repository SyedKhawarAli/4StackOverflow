//
//  CollapsibleController.swift
//  4Swift
//
//  Created by EAPPLE on 23/05/2022.
//

import UIKit

class CollapsibleController: UIViewController {
    let data = [
        ["Nothing", "description is very long description is very long description is very long description is very long description is very long description is very long description is very long description is very long description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "],
        ["Nothing", "description is very long "]
    ]
    var eachCellStatus: [Bool] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        for _ in data {
            eachCellStatus.append(true)
        }
    }
}

extension CollapsibleController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        cell.titleCell.text = data[indexPath.row][0]
        cell.detail.text = data[indexPath.row][1]
        cell.detail.isHidden = eachCellStatus[indexPath.row]
        cell.updateArrowImage(expandStatus: self.eachCellStatus[indexPath.row])
        cell.onArrowClick = { button in
            self.eachCellStatus[indexPath.row].toggle()
            cell.updateArrowImage(expandStatus: self.eachCellStatus[indexPath.row])
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class CustomCell: UITableViewCell {
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var arrowButton: UIButton!
    
    let upArrow = UIImage(systemName: "chevron.up.circle.fill")
    let downArrow = UIImage(systemName: "chevron.down.circle.fill")
    var onArrowClick: ((UIButton)->())!
    
    @IBAction func handleArrowButton(sender: UIButton){
        onArrowClick(sender)
    }
    
    func updateArrowImage(expandStatus: Bool){
        arrowButton.setImage(expandStatus ? downArrow : upArrow, for: .normal)
    }
}
