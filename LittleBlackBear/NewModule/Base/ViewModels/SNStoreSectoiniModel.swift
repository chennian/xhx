//
//  DDZStoreSectoiniModel.swift
//  diandianzanumsers
//
//  Created by 楠 on 2017/6/16.
//  Copyright © 2017年 specddz. All rights reserved.
//

import UIKit
import RxDataSources

struct SNStoreSectoiniModel {
    
    var header : String
    var items : [Item]
}

extension SNStoreSectoiniModel : SectionModelType  {
    
//    typealias Item = Mappable
     typealias Item = SNSwiftyJSONAble
    
    init(original: SNStoreSectoiniModel, items: [Item]) {
        self = original
        self.items = items
    }
    
}
