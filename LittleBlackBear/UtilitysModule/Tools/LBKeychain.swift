//
//  LBKeychain.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import KeychainAccess
private let KeychainService = "LittleBlackBear"

class LBKeychain: NSObject {
	/// 将value存入keyChain里
	static func set(_ value: String, key: String){
		let keyChain = Keychain(service: KeychainService)
		do {
			return	try keyChain.set(value, key: key)
		} catch let error {
			Print(error)
		}
	}
	/// 传入key值返回Value
	static func get(_ key: String)->String {
		
		let keyChain = Keychain(service: KeychainService)
		do {
			return try keyChain.get(key) ?? ""
		} catch let error {
			Print(error)
		}
		return ""
	}
	// 删除所有keyChain的值
	static func removeKeyChain() {
		do {
			try Keychain(service: KeychainService).removeAll()
		} catch let error {
			Print(error)
		}
		
	}
}
