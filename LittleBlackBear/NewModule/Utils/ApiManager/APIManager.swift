//
//  APIManager.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/6.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import RxSwift

//func ShopNetArray<T : SNSwiftyJSONAble>(requestType: API, modelType: T.Type) -> Observable<SNMoyaResult<[T]>> {
//    return APIProvider.request(requestType).mapArray(modelType.self)
//    return APIProvider.rx.request(requestType).asObservable().map(to: [modelType].self)
//}

/// 特殊请求
/**
 * requestType ：请求枚举
 * modelType : 模型
 * availableCode : 请求正确的代码数组
 * 请求结果需要用到。 sp_success 来解析 请求正确的数据
 */
func ZJRequest<T : SNSwiftyJSONAble>(requestType: API, modelType: [T.Type],availableCode : [Int] = [000000]) -> Observable<SNMoyaResult<[T]>> {
    return BMProvider.request(requestType).asObservable().zj_map(to: modelType.self, availableCode: availableCode)
}

//func RequestJson<T : SNSwiftyJSONAble>(requestType: API) -> Observable<SNMoyaResult<[T]>> {
//    return BMProvider.request(requestType).asObservable().z//.zj_map(to: modelType.self, availableCode: availableCode)
//}



func SNRequestString(requestType: API) -> Observable<SNMoyaResult<Bool>> {
    return BMProvider.request(requestType).asObservable().mapToString()
}


func SNRequest<T : SNSwiftyJSONAble>(requestType: API, modelType: [T.Type],availableCode : [String] = [
    "000000"]) -> Observable<SNMoyaResult<[T]>> {
    return BMProvider.request(requestType).asObservable().map(to: modelType.self,availableCode : availableCode)
}

//func ShopNetObject<T : SNSwiftyJSONAble>(requestType: API, modelType: T.Type) -> Observable<SNMoyaResult<T>> {
//    return APIProvider.rx.request(requestType).asObservable().map(to: modelType.self)
//}

func SNRequest<T : SNSwiftyJSONAble>(requestType: API, modelType: T.Type) -> Observable<SNMoyaResult<T>> {
    return BMProvider.request(requestType).asObservable().map(to: modelType.self)
}

//func ShopNetString(requestType: API) -> Observable<SNMoyaResult<String>> {
//    return APIProvider.rx.request(requestType).asObservable().mapToString()
//}

func SNRequest(requestType: API) -> Observable<SNMoyaResult<String>> {
    return BMProvider.request(requestType).asObservable().mapToString()
}

//func shopNetData<T : SNSwiftyJSONAble>(requestType: API, modelType: T.Type) -> Observable<T> {
//    return APIProvider.rx.request(requestType).asObservable().mapWeChatAccessToken(modelType.self)
//}

func SNRequestModel(requestType: API) -> Observable<SNMoyaResult<SNNetModel>> {
    
    return BMProvider.request(requestType).asObservable().mapToNetModel()
}

func SNRequestModel<T : SNSwiftyJSONAble>(requestType: API, modelType: T.Type) -> Observable<SNMoyaResult<T>> {
    return BMProvider.request(requestType).asObservable().mapToModel()
}

func SNRequestBool(requestType: API) -> Observable<SNMoyaResult<Bool>> {
    return BMProvider.request(requestType).asObservable().mapToBool()
}

