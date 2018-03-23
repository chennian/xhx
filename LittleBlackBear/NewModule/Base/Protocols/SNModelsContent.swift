//
//  DDZModelsContent.swift
//  diandianzanumsers
//
//  Created by 楠 on 2017/6/12.
//  Copyright © 2017年 specddz. All rights reserved.
//

import Foundation

protocol SNModelsContent {
    
    associatedtype T
    var models : [T] { get set }
}
