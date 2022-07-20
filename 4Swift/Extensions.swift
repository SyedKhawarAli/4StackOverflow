//
//  Extensions.swift
//  4Swift
//
//  Created by EAPPLE on 23/05/2022.
//

import UIKit

extension UIStoryboard {
    enum Name: String {
        case Main
        case Questions
        case Experiments
    }
}

extension UIViewController {
    static var storyboardId: String {
        return String(describing: self)
    }
    
    static func instantiate<ViewController: UIViewController>(_ viewControllerType: ViewController.Type, fromStoryboard storyboardName: UIStoryboard.Name) -> ViewController {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: viewControllerType.storyboardId) as! ViewController
    }
}
