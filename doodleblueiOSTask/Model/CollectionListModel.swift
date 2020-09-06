//
//  CollectionListModel.swift
//  doodleblueiOSTask
//
//  Created by Ramprasath Selvam on 06/09/20.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation

struct CollectionListModel:Decodable {
    
    let id:Int
    let titleText:String
    let image:String
    var isSelected:Bool = false
}
