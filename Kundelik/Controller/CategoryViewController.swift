//
//  CategoryViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 3/2/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    private let categoryTitles = ["Образование", "Работа", "Спорт", "Дополнительные занятия", "Транспорт", "Развлечения", "Другое"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFlowLayout()
        collectionView?.register(UINib(nibName: CategoryCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.cellID)
    }
    
    func setupFlowLayout() {
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.className, for: indexPath) as! CategoryCollectionViewCell
        
        cell.title.text = categoryTitles[indexPath.row]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = backViewController() as? NewEventTableViewController {
            vc.event?.title = categoryTitles[indexPath.row]
            navigationController?.popViewController(animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        cell.highlight(isHighlighted: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        cell.highlight(isHighlighted: true)
    }
    
}
