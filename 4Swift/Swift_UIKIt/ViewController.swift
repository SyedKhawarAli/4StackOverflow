//
//  ViewController.swift
//  4Swift
//
//  Created by EAPPLE on 23/05/2022.
//

import UIKit

struct Model {
    let title: String
    let viewController: UIViewController
}

class ViewController: UIViewController {

    @IBOutlet weak var questionTableView: UITableView!

    let questions: [Model] = [
        Model(title: "Collapsable table view cell with arrow buttons", viewController: UIViewController.instantiate(CollapsibleController.self, fromStoryboard: .Questions))
    ]
    
    let experiments: [Model] = [
        Model(title: "Divided collection view", viewController: UIViewController.instantiate(DividedCollectionView.self, fromStoryboard: .Experiments)),
        Model(title: "Colllapse Tableview Section", viewController: UIViewController.instantiate(ColllapseTableViewSection.self, fromStoryboard: .Experiments)),
        Model(title: "Page Slider VIew", viewController: UIViewController.instantiate(SliderViewController.self, fromStoryboard: .Experiments))

    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stack Overflow Answers"
        questionTableView.delegate = self
        questionTableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? questions.count : experiments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = indexPath.section == 0 ? questions[indexPath.row].title : experiments[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewContoller = indexPath.section == 0 ? questions[indexPath.row].viewController : experiments[indexPath.row].viewController
        self.navigationController?.pushViewController(viewContoller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Questions" : "Experiments"
    }
}
