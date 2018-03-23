//
//  UIImageExtension.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
// 根据颜色生成图片
extension UIImage{
	/// createImageWithColor
	class func imageWithColor(_ color:UIColor) -> UIImage {
		
		let ract:CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)
		
		UIGraphicsBeginImageContextWithOptions(ract.size, false, 0)
		color.setFill()
		UIRectFill(ract)
		
		let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return image
	}
	
	class func scaleImage(_ image:UIImage) -> Data {
		var oldImage = image
		
		let scale:CGFloat = oldImage.size.height / oldImage.size.width
		
		let size:CGSize = CGSize(width: 240, height: 240*scale)
		if oldImage.size.height > oldImage.size.width {
			oldImage = UIImage(cgImage: oldImage.cgImage!, scale: 1.0, orientation: UIImageOrientation.right)
		}
		
		UIGraphicsBeginImageContextWithOptions(size, true, 0)
		oldImage .draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		var imageData:Data = UIImagePNGRepresentation(newImage!)!
		var compereScale = 0.9
		while 400*1024 < imageData.count {
			imageData = UIImageJPEGRepresentation(newImage!, CGFloat(compereScale))!
			compereScale -= 0.1
		}
		
		return imageData
	}
	/// 裁剪
	 func croppingImage(_ size:CGSize)->UIImage{
		guard let cgImage = self.cgImage else {return self}

		let contextImage:UIImage = UIImage(cgImage: cgImage)
		let contextSize:CGSize = contextImage.size
		let aspect:CGFloat = size.width/size.height
		// posX = positionX,posY = postionY
		var posX:CGFloat = 0
		var posY:CGFloat = 0
		var cgWidth:CGFloat = size.width
		var cgHeight:CGFloat = size.height
		
		if size.width > size.height {// Landscape
			cgWidth = contextSize.height
			cgHeight = contextSize.width/aspect
			posY = (contextSize.height - cgHeight)/2
		
		}else if size.width < size.height{ // Portrait
			cgHeight = contextSize.height
			cgWidth = contextSize.height * aspect
			posX = ( contextSize.width - cgWidth)/2
			
		}else{// Square
			if contextSize.width >= contextSize.height{
				cgWidth =  contextSize.height * aspect
				cgHeight = contextSize.height
				posX = ( contextSize.width - cgWidth)/2

			}else{
				cgWidth = contextSize.width
				cgHeight = contextSize.width / aspect
				posY = (contextSize.height - cgHeight)/2
			}
		}
		let rect:CGRect = CGRect(x: posX, y: posY, width: cgWidth, height: cgHeight)
		// creat bitImageWidthContextImage
		let imageRef:CGImage = (contextImage.cgImage?.cropping(to: rect))!
	
		let image:UIImage = UIImage(cgImage: imageRef,
									scale: self.scale,
									orientation: self.imageOrientation)
//
//		UIGraphicsBeginImageContextWithOptions(size, true, self.scale)
//		image.drawAsPattern(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//		image = UIGraphicsGetImageFromCurrentImageContext()!
//		UIGraphicsEndImageContext()
		return image
		
	}
	/// 指定大小缩略图
	func thumbnailWithImage(size:CGSize)->UIImage{
		guard self.size.height > 0 else{return self}
		UIGraphicsBeginImageContext(size)
		self.draw(in: CGRect(origin: .zero, size: size))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return newImage
	}
	/// 保持原来的长宽比，生成一个缩略图
	func thumbnailWithImageWithoutScale(size:CGSize) -> UIImage{
		
		guard self.size.height > 0 else{return self}
		let oldSize = self.size
		var rect:CGRect
		
		if (size.width/size.height)>(oldSize.width/oldSize.height){
			
			let widht = size.height*(oldSize.width/oldSize.height)
			let height = size.height
			rect = CGRect(x:0 , y: 0, width: widht, height: height)
			
		}else{
			
			let widht = size.width
			let height = size.width*(oldSize.height/oldSize.width)
			let y = (size.height - height)/2
			rect = CGRect(x: 0, y: y, width: widht, height: height)
			
		}
		
		UIGraphicsBeginImageContext(size)
		guard let context = UIGraphicsGetCurrentContext() else {return self}
		context.setFillColor(UIColor.clear.cgColor)
		UIRectFill(rect)
		self.draw(in: rect, blendMode: .normal, alpha: 1)
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage!
	}
	/// return imageHeight
	func onlyOneImageForHeight()->CGFloat{
		guard self.size.height > 0 else{return 0}
		
		let imageW = self.onlyOneImageForWidth()
		let imageH = self.size.height * imageW / self.size.width
		
		//  默认最大宽高, image_marginX = 10
		// 360px 模仿微信朋友圈 一张图片时最大高度
		let defaultHeight = 180*AUTOSIZE_Y
		// 默认最小高度
		let defaultMinHeight = 75*AUTOSIZE_Y
		if imageH > defaultHeight{
			return defaultHeight
		}
		if imageH < defaultMinHeight{
			return defaultMinHeight
		}
		return imageH
	}
	/// return imageWidth
	func onlyOneImageForWidth()->CGFloat{
		guard self.size.height > 0 else{return 0}
		
		//  默认最大宽, image_marginX = 10
		let defaultMaxWidth = KSCREEN_WIDTH - 20
		// 默认最小宽度
		let defaultMinWidth = 75*AUTOSIZE_X
		// 默认最大高度
		let defaultMaxHeight = 180*AUTOSIZE_Y
		
		let imageH = self.size.height
		
		let imageW = defaultMaxHeight / imageH * self.size.width
		
		
		if imageW > defaultMaxWidth {
			return defaultMaxWidth
		}
		
		if imageW < defaultMinWidth{
			return defaultMinWidth
		}
		
		return imageW
		
	}
}














