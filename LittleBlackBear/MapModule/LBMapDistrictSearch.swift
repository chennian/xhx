//
//  LBMapDistrictSearch.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/8.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import Foundation
final class LBMapDistrictSearch:NSObject{
    
    
    fileprivate static let share = LBMapDistrictSearch()
    class var searchManager: LBMapDistrictSearch {
        return share
    }
    
    fileprivate override init() {
        
    }
    
    fileprivate var districtSearchResult:((CLLocationCoordinate2D)->())?
    private var districtSearch:BMKDistrictSearch!
    open func searchCity(city:String? = nil, district:String? = nil,completion:@escaping((CLLocationCoordinate2D)->())){
        _init()
        
        let option = BMKDistrictSearchOption()
        option.city = city
        option.district = district
        let flag = districtSearch.districtSearch(option)
        if flag {
            Print("district检索发送成功")
        } else {
            Print("district检索发送失败")
        }
        districtSearchResult = {completion($0)}
    }
    

    private func _init(){
        districtSearch = BMKDistrictSearch()
        districtSearch.delegate = self
    }
    

}
extension LBMapDistrictSearch:BMKDistrictSearchDelegate{
    
    func onGetDistrictResult(_ searcher: BMKDistrictSearch!, result: BMKDistrictResult!, errorCode error: BMKSearchErrorCode) {
        if error == BMK_SEARCH_NO_ERROR {
            guard let action = districtSearchResult else{return}
            action(result.center)
        }
        
    }
    
}
