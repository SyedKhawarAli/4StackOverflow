//
//  ColllapseTableViewSection.swift
//  Swift_UIKIt
//
//  Created by EAPPLE on 24/05/2022.
//

import UIKit

struct TableData {
    let sectionTitle: String
    let rows: [String]
}

class ColllapseTableViewSection: UIViewController {
    
    let data = [
        TableData(sectionTitle: "sec 1", rows: ["row 1", "sdf", "gfsa "]),
        TableData(sectionTitle: "sec 2", rows: ["saf", "asdf", "asdf", "fasga"])
    ]
    
    var hiddenSections: [Int] = [Int]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate =  self
        tableView.dataSource = self
    }
    
    @objc
    func handleSectionSelection(sender: UIGestureRecognizer){
        let tag = sender.view?.tag ?? 0
        if hiddenSections.contains(where: { $0 == tag}) {
            let index = hiddenSections.firstIndex(where: { $0 == tag}) ?? 0
            hiddenSections.remove(at: index)
        }else {
            hiddenSections.append(tag)
        }
        tableView.reloadSections([tag], with: .automatic)
    }
}

extension ColllapseTableViewSection: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hiddenSections.contains(section) ? 0 : data[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.section].rows[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        let text = UILabel()
        text.text = data[section].sectionTitle
        text.textColor = .red
        text.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(text)
        view.backgroundColor = .green
        view.isUserInteractionEnabled = true
        view.tag = section
        NSLayoutConstraint.activate([
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            text.topAnchor.constraint(equalTo: view.topAnchor),
            text.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSectionSelection(sender:))))
        return view
    }
}
