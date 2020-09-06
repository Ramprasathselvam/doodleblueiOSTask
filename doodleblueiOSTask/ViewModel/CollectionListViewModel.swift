//
//  CollectionListViewModel.swift
//  doodleblueiOSTask
//
//  Created by Ramprasath Selvam on 06/09/20.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation

class CollectionListViewModel{
    
    // MARK: - Properties
    let titleText: String
    let image: String
    var isSelected: Bool
    
    // MARK: - (DI)
    init(collectionListModel: CollectionListModel) {
        self.titleText = collectionListModel.titleText
        self.image = collectionListModel.image
        self.isSelected = collectionListModel.isSelected
    }
    
}
