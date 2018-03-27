//
//  SNMoya_ResponseMapper.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/5.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON


public extension Response {
    
    /// Maps data received from the signal into an object which implements the SNSwiftyJSONAble protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: SNSwiftyJSONAble>(to type:T.Type) throws -> SNMoyaResult<T> {
//        let jsonObject = try mapJSON()
        let jsonData = try JSON(data: self.data)
        
        let jsonCode = jsonData[MOYA_RESULT_CODE]
        let jsonObj = jsonData[MOYA_RESULT_DATA]
        let jsonMsg = jsonData[MOYA_RESULT_MSG]
        
//        let jsonObject = jsonObj.object
//        guard let mappedObject = T(jsonData: jsonData/*JSON(jsonObject)*/) else {
//            throw MoyaError.jsonMapping(self)
//            return SNMoyaResult.fail(code: jsonCode.int, msg: jsonMsg.string)
//        }
        
        guard jsonCode.stringValue == "000000", let mappedObject = T(jsonData: jsonObj) else {
            return SNMoyaResult.fail(code: jsonCode.stringValue, msg: jsonMsg.string)
        }
        
//        return mappedObject
        return SNMoyaResult.success(mappedObject)
    }
    
    /// Maps data received from the signal into an array of objects which implement the SNSwiftyJSONAble protocol
    /// If the conversion fails, the signal errors.
    public func map<T: SNSwiftyJSONAble>(to type:[T.Type],availableCode : [String]) throws -> SNMoyaResult<[T]> {
//        let jsonObject = try mapJSON()
        let jsonData = try JSON(data: self.data)
//        let mappedArray = JSON(jsonObject)
        SNLog(jsonData)
        let jsonCode = jsonData[MOYA_RESULT_CODE]
        let jsonObj = jsonData[MOYA_RESULT_DATA]
        let jsonMsg = jsonData[MOYA_RESULT_MSG]
        
        let mappedArray = jsonObj
        
        //错误处理
        guard jsonCode.stringValue != "" && availableCode.contains(jsonCode.stringValue) else {//jsonCode.int == 000000
            
            return SNMoyaResult.fail(code: jsonCode.stringValue, msg: jsonMsg.string)
        }
        
        let mappedObjectsArray = mappedArray.arrayValue.flatMap { T(jsonData: $0) }
        
        return SNMoyaResult.success(mappedObjectsArray)
    }
    

    
    ///zj special
    public func zj_map<T: SNSwiftyJSONAble>(to type:[T.Type],availableCode : [Int]) throws -> SNMoyaResult<[T]> {
        //        let jsonObject = try mapJSON()
        let jsonData = try JSON(data: self.data)
        //        let mappedArray = JSON(jsonObject)
        SNLog(jsonData)
        let jsonCode = jsonData[MOYA_RESULT_CODE]
        let jsonObj = jsonData[MOYA_RESULT_DATA]
        let jsonMsg = jsonData[MOYA_RESULT_MSG]
        
        let mappedArray = jsonObj
        
        
        
        //错误处理
        if jsonCode.int != nil && !availableCode.contains(jsonCode.int!){
            
            return SNMoyaResult.fail(code: jsonCode.stringValue, msg: jsonMsg.string)
        }
        

        
        let mappedObjectsArray = mappedArray.arrayValue.flatMap { T(jsonData: $0) }
        
        return SNMoyaResult.sp_success(mappedObjectsArray, code: jsonCode.int ?? 000000, msg: jsonMsg.string ?? "")//.success(mappedObjectsArray)
    }
    
    
    
    public func mapToString() throws -> SNMoyaResult<String> {
        
        let jsonData = JSON(data: self.data)
        
        let jsonCode = jsonData[MOYA_RESULT_CODE]
        let jsonObj = jsonData[MOYA_RESULT_DATA]
        let jsonMsg = jsonData[MOYA_RESULT_MSG]
        
        guard jsonCode.int == 000000, let mappedString = jsonObj.string else {
            //throw SNMoyaError.fail(code: nil, msg: jsonMsg.string)
            return SNMoyaResult.fail(code: jsonCode.stringValue, msg: jsonMsg.string)
        }
        
        return SNMoyaResult.success(mappedString)
    }
    
    public func mapToNetModel() throws -> SNMoyaResult<SNNetModel> {
        
        let jsonData = JSON(data: self.data)
        
        guard let model = SNNetModel(jsonData: jsonData) else {
            throw MoyaError.jsonMapping(self)
        }
        guard model.code == "000000" else {
            return SNMoyaResult.fail(code: model.code, msg: model.msg)
        }
        return SNMoyaResult.success(model)
    }
    
    public func mapToModel<T: SNSwiftyJSONAble>() throws -> SNMoyaResult<T> {
        
        let jsonData = JSON(data: self.data)
        
        guard let model = T(jsonData: jsonData) else {
            return SNMoyaResult.fail(code: "9999", msg: "数据错误")
        }
        
        return SNMoyaResult.success(model)
    }
    
    public func mapToString() throws -> SNMoyaResult<Bool> {
        let jsonData = JSON(data: self.data)
        
        guard let model = SNNetModel(jsonData: jsonData) else {
            throw MoyaError.jsonMapping(self)
        }
        ZJLog(messagr: jsonData)
        guard model.code == "000000" else {
            ZJLog(messagr: model.code)
            return SNMoyaResult.fail(code: model.code, msg: model.msg)
        }
        return SNMoyaResult.bool(msg: model.data!.stringValue)
    }
    
    public func mapToBool() throws -> SNMoyaResult<Bool> {
        let jsonData = JSON(data: self.data)
        
        guard let model = SNNetModel(jsonData: jsonData) else {
            throw MoyaError.jsonMapping(self)
        }
        guard model.code == "000000" else {
            return SNMoyaResult.fail(code: model.code, msg: model.msg)
        }
        return SNMoyaResult.bool(msg: model.msg)
    }
    
}
