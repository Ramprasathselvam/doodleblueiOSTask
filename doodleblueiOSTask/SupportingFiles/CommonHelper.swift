//
//  CommonHelper.swift
//  doodleblueiOSTask
//
//  Created by Ramprasath Selvam on 06/09/20.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation

class CommonHelper : NSObject{
    
    //MARK: - JsonLocalData
    func fetchData() -> Data{
        let jsonStr = "[{\"id\":1, \"titleText\":\"Title1\", \"image\":\"title1.png\",\"isSelected\":false},{\"id\":2, \"titleText\":\"Title2\", \"image\":\"title1.png\",\"isSelected\":false},{\"id\":3, \"titleText\":\"Title3\", \"image\":\"title1.png\",\"isSelected\":false},{\"id\":4, \"titleText\":\"Title4\", \"image\":\"title1.png\",\"isSelected\":false},{\"id\":5, \"titleText\":\"Title5\", \"image\":\"title1.png\",\"isSelected\":false},{\"id\":6, \"titleText\":\"Title6\", \"image\":\"title1.png\",\"isSelected\":false},{\"id\":7, \"titleText\":\"Title7\", \"image\":\"title1.png\",\"isSelected\":false},{\"id\":8, \"titleText\":\"Title8\", \"image\":\"title1.png\",\"isSelected\":false},{\"id\":9, \"titleText\":\"Title9\", \"image\":\"title1.png\",\"isSelected\":false}]"
        return Data(jsonStr.utf8)
    }
}
