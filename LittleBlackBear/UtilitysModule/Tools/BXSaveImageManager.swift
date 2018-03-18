//
//  BXSaveImageManager.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 2017/5/24.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
fileprivate let assetImageName = "小黑熊"
final class BXSaveImageManager: NSObject {
	
	fileprivate var collection:PHAssetCollection?
	fileprivate var collectionId:String = ""
	fileprivate weak var createdAsset:PHObjectPlaceholder?
	
	fileprivate static let shareInStance = BXSaveImageManager()
	class var shareSaveImage: BXSaveImageManager {
		return shareInStance
	}
	fileprivate override init() {
        
	}
}
extension BXSaveImageManager{
	
	// 从已存在相册中找到自定义相册对象
	internal func BXAssetCollection()-> PHAssetCollection {
		let collectionResult:PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
		collectionResult.enumerateObjects({ [weak self] (collection, _, _) in
			self?.collection = collection
		})
		
		if collection?.localizedTitle == assetImageName {
			return collection!
		}
		
		// 新建自定义相册
		try? PHPhotoLibrary.shared().performChangesAndWait {
			self.collectionId = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: assetImageName).placeholderForCreatedAssetCollection.localIdentifier
		}
		return PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [collectionId], options: nil).lastObject!
		
	}
	
	
	/// 保存图片
	func saveImage(_ image:UIImage){
		
		DispatchQueue.main.async {
			PHPhotoLibrary.requestAuthorization { [weak self] (status) in
				guard status == PHAuthorizationStatus.authorized else{return}
				
				let collection:PHAssetCollection = (self?.BXAssetCollection())!
				
				let changeBlock: ()->() = {
					let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
					guard let placeholderForCreatedAsset = assetChangeRequest.placeholderForCreatedAsset else {
						Print("保存图片失败 \(#function)")
						return
					}
					guard let aCChangeRequest = PHAssetCollectionChangeRequest(for: collection) else {
						Print("aCChangeRequest \(#function)")
						return
					}

                    aCChangeRequest.addAssets([placeholderForCreatedAsset] as NSFastEnumeration)
				}
				
				PHPhotoLibrary.shared().performChanges(changeBlock, completionHandler: { (sucesse,error) in
					DispatchQueue.main.async {
						if sucesse == true{
                            UIAlertView(title: nil,
                                        message: "已经保存到相册",
                                        delegate: nil,
                                        cancelButtonTitle:"确定").show()
						}else{

                        }
					}
				})
			}
			
		}
	}
	
}
