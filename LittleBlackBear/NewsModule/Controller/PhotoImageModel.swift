//
//  PhotoImageModel.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/16.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import Foundation
import Photos

enum ModelType{
    case Button
    case Image
}

struct PhotoImageModel: Equatable {
    var type: ModelType?
    var data: PHAsset?
    
    init(type: ModelType?,data:PHAsset?){
        self.type = type
        self.data = data
    }
    
    static func ==(lhs: PhotoImageModel, rhs: PhotoImageModel) -> Bool {
        return lhs.type == rhs.type && lhs.data == rhs.data
    }
}

