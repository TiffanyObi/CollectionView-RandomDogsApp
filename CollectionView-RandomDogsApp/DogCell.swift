//
//  DogCell.swift
//  CollectionView-RandomDogsApp
//
//  Created by Tiffany Obi on 1/14/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import ImageKit //this has getImage() which is our extension on UIimage view.

class DogCell: UICollectionViewCell {
    
    @IBOutlet weak var dogImageView: UIImageView!
    
    public func configureCell(with dogImage: DogImage) {
        dogImageView.getImage(with: dogImage) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.dogImageView.image = UIImage(systemName: "exclamationmark-triangle")
                }
                
            case.success(let image):
                DispatchQueue.main.async {
                    self?.dogImageView.image = image
                }
            }
        }
    }
}
