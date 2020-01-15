//
//  ViewController.swift
//  CollectionView-RandomDogsApp
//
//  Created by Tiffany Obi on 1/14/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

// as of iOS 13 collection view cells are self resizing by default.  in order to prevent that we have to set  "estimated size" in collection view from Automatic to None!
class DogViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dogImages = [DogImage]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .cyan
        fetchDogImages()
    }

    private func fetchDogImages() {
        DogAPIClient.fetchDogs { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("could not get dog images - Error:  \(appError)")
                
            case .success(let dogImages):
                self?.dogImages = dogImages
            }
        }
    }

}

extension DogViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dogCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dogCell", for: indexPath) as? DogCell else {
            fatalError("could not downcast to DogCell")
        }
        
        let dogImage = dogImages[indexPath.row]
        
        dogCell.configureCell(with: dogImage)
        return dogCell
    }
    
    
}


//here we are using UICollectionViewDelegateFlowLayout
extension DogViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let interItemSpacing: CGFloat  = 10 //space between items
        let maxWidth = UIScreen.main.bounds.size.width //maximum screen width
        let numberOfItems: CGFloat = 2 // number of items per row
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth:CGFloat = (maxWidth - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    // content edge insets = the padding or borders around cells
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
