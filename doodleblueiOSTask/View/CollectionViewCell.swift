//
//  CollectionViewCell.swift
//  doodleblueiOSTask
//
//  Created by Ramprasath Selvam on 06/09/20.
//  Copyright © 2020 example. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    //Properties
    @IBOutlet var title:UILabel!
    @IBOutlet var image:UIImageView!
    @IBOutlet var bgView:UIView!
    
    var viewModel: CollectionListViewModel!{
        didSet{
            title.text = viewModel.titleText
            image.image = UIImage(named: viewModel.image)
            if (viewModel.isSelected){
                bgView.backgroundColor = UIColor.lightGray
            }else{
                bgView.backgroundColor = UIColor.white
            }
        }
    }
    
}
