//
//  ViewController.swift
//  4Swift
//
//  Created by EAPPLE on 23/05/2022.
//

import UIKit

struct Question {
    let title: String
    let viewController: UIViewController
}

class ViewController: UIViewController {

    @IBOutlet weak var questionTableView: UITableView!

    let questions: [Question] = [
        Question(title: "Collapsable table view cell with arrow buttons", viewController: UIViewController.instantiate(CollapsibleController.self, fromStoryboard: .Collapsible))
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stack Overflow Answers"
        questionTableView.delegate = self
        questionTableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = questions[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(questions[indexPath.row].viewController, animated: true)
    }
}
