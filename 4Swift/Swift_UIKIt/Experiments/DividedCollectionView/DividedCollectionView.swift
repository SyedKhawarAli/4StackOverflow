//
//  DividedCollectionView.swift
//  Swift_UIKIt
//
//  Created by EAPPLE on 24/05/2022.
//

import Foundation
import UIKit

struct CellModel {
    let imageNames: [String]
}

class DividedCollectionView: UIViewController {
    
    let data = [
        CellModel(imageNames: ["truck", "truck2", "truck3"]),
        CellModel(imageNames: ["truck3", "truck1", "truck4"])
    ]
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension DividedCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DividedCollectionViewCell
        cell.largeImageView.image = UIImage(named: data[indexPath.row].imageNames[0])
        cell.smallImageView1.image = UIImage(named: data[indexPath.row].imageNames[1])
        cell.smallImageView2.image = UIImage(named: data[indexPath.row].imageNames[2])
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2 - 16, height: collectionView.bounds.width/2 * 3/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UIViewController.instantiate(FullScreenImagesController.self, fromStoryboard: .Experiments)
        controller.cellModel = data[indexPath.row]
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true)
//        self.navigationController?.pushViewController(controller, animated: true)
    }
}

class DividedCollectionViewCell: UICollectionViewCell {
    @IBOutlet var largeImageView: UIImageView!
    @IBOutlet var smallImageView1: UIImageView!
    @IBOutlet var smallImageView2: UIImageView!
}
