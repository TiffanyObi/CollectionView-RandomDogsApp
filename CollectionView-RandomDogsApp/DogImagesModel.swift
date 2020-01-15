//
//  DogImagesModel.swift
//  CollectionView-RandomDogsApp
//
//  Created by Tiffany Obi on 1/14/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation

typealias DogImage = String


struct RandomDogInfo: Decodable {
    let message : [DogImage]
    let status: String
}
