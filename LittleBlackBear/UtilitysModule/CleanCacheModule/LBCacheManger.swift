//
//  LBCacheManger.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

final class LBCacheManger: NSObject {
	
	fileprivate static let sharedInstance = LBCacheManger()
	class var cache:LBCacheManger{
		return sharedInstance
	}
	
	func showCacheSize()-> Int{
		let cachePath = NSSearchPathForDirectoriesInDomains( FileManager.SearchPathDirectory.cachesDirectory,  FileManager.SearchPathDomainMask.userDomainMask,  true).last! as NSString
		let files = FileManager.default.subpaths(atPath: cachePath as String)
		var size:Int = 0
		for fileName in files! {
			
			let path = cachePath.appending("/"+fileName)
			let floder = try? FileManager.default.attributesOfItem(atPath: path)
			for (key,value) in floder! {
				if key == FileAttributeKey.size {
					size += value as? Int ?? 0
				}
			}
			
		}
		Print("缓存路径\(cachePath)")
		Print("缓存大小\(size)")
		return size
	}
	func clearCache(completeHandler:@escaping(()->())){
		
		let cachePath = NSSearchPathForDirectoriesInDomains( FileManager.SearchPathDirectory.cachesDirectory,  FileManager.SearchPathDomainMask.userDomainMask,  true).last! as NSString
		let files = FileManager.default.subpaths(atPath: cachePath as String)
        for fileName in files!{
            let path = cachePath.appending("/"+fileName)
            if(FileManager.default.fileExists(atPath: path)){
                // 删除
                do {
                    try FileManager.default.removeItem(atPath: path)
                    completeHandler()
                } catch let error  {
                    Print(error)
                }
            }
        }
    }
	
}
