//
//  DDZRXSectionModel.swift
//  diandianzanumsers
//
//  Created by 楠 on 2017/6/23.
//  Copyright © 2017年 specddz. All rights reserved.
//

import Foundation
import RxDataSources
//import ObjectMapper

struct SNRXSectionModel {
    var header : String
    var items : [Item]
}

extension SNRXSectionModel: SectionModelType {
//    typealias Item = Mappable
     typealias Item = SNSwiftyJSONAble
    init(original: SNRXSectionModel, items: [Item]) {
        self = original
        self.items = items
    } 
}


struct SNRXModelSectionModel {
    var header : SNSwiftyJSONAble
    var items : [Item]
}

extension SNRXModelSectionModel: SectionModelType {
//    typealias Item = Mappable
     typealias Item = SNSwiftyJSONAble
    
    init(original: SNRXModelSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

