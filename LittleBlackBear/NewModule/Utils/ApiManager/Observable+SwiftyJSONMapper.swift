//
//  Observable+SwiftyJSONMapper.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/6.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SwiftyJSON

/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension ObservableType where E == Response {
    
    /// Maps data received from the signal into an object which implements the ALSwiftyJSONAble protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: SNSwiftyJSONAble>(to type: T.Type) -> Observable<SNMoyaResult<T>> {
        return flatMap { response -> Observable<SNMoyaResult<T>> in
            return Observable.just(try response.map(to: type))
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the ALSwiftyJSONAble protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: SNSwiftyJSONAble>(to type: [T.Type],availableCode : [String]) -> Observable<SNMoyaResult<[T]>> {
        return flatMap { response -> Observable<SNMoyaResult<[T]>> in
            return Observable.just(try response.map(to: type,availableCode : availableCode))
        }
    }
    
    public func zj_map<T: SNSwiftyJSONAble>(to type: [T.Type],availableCode : [Int]) -> Observable<SNMoyaResult<[T]>> {
        return flatMap { response -> Observable<SNMoyaResult<[T]>> in
            return Observable.just(try response.zj_map(to: type, availableCode: availableCode))//.map(to: type)
        }
    }//zj_jsonStrin// zj_jsonMap
    

    
    public func mapToString() -> Observable<SNMoyaResult<String>> {
        return flatMap({ response -> Observable<SNMoyaResult<String>> in
            return Observable.just(try response.mapToString())
        })
    }
    
    public func mapToNetModel() -> Observable<SNMoyaResult<SNNetModel>> {
        return flatMap({ response -> Observable<SNMoyaResult<SNNetModel>> in
            return Observable.just(try response.mapToNetModel())
        })
    }
    
    public func mapToModel<T: SNSwiftyJSONAble>() -> Observable<SNMoyaResult<T>> {
        return flatMap({ response -> Observable<SNMoyaResult<T>> in
            return Observable.just(try response.mapToModel())
        })
    }
    
    public func mapToBool() -> Observable<SNMoyaResult<Bool>> {
        return flatMap({ response -> Observable<SNMoyaResult<Bool>> in
            return Observable.just(try response.mapToBool())
        })
    }
    
    public func mapToString() -> Observable<SNMoyaResult<Bool>> {
        return flatMap({ response -> Observable<SNMoyaResult<Bool>> in
            return Observable.just(try response.mapToString())
        })
    }
}
