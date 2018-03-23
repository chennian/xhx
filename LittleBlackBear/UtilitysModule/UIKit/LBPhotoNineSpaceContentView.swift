//
//  LBPhotoNineSpaceContentView.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2018/1/31.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
class LBPhotoNineSpaceContentView: UIView {

    var showPotoBrowser:((UIImageView)->())?
    
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	var imagePaths:[String]=[String](){
		didSet{
			subviews.forEach{$0.removeFromSuperview()}
			guard imagePaths.count > 0 else {return}
										// 过滤非URL
			createImageView(imagePaths.filter{$0.isURLFormate()==true})
			
		}
	}
	
	
	private func createImageView(_ imagePahts:[String]){
		guard imagePahts.count > 0 else {return}
		
		let rows = numberOfRowInImagePaths(imagePahts)
		let margin:CGFloat = 10
		var index = 0
		
		imagePahts.forEach{
			
			let columnIndex = index % rows
			let rowIndex = index / rows
			let imageView = UIImageView()
            
			imageView.kf.setImage(with: URL(string:$0), completionHandler: {(image, _, _, _) in
                guard let img = image,img.size.height > 0 else{return}
				
				if imagePahts.count == 1 {
					let imageW = img.onlyOneImageForWidth()
					let imageH = img.onlyOneImageForHeight()
					
					imageView.image = img.croppingImage(CGSize(width:imageW,height: imageH))
					imageView.frame = CGRect(x: 0,
											 y: 0,
											 width: imageW,
											 height: imageH)
				
				}else{
					let imageWH = (KSCREEN_WIDTH-4*10)/3
					imageView.image = img.croppingImage(CGSize(width:imageWH , height: imageWH))
				}

			})
			
			if imagePahts.count != 1{
				
				let imageW = imageForWidthAtImagePaths(imagePahts)
				let imageH = imageW
				imageView.frame = CGRect(x: CGFloat(columnIndex)*(imageW+margin),
										 y: CGFloat(rowIndex)*(imageH+margin),
										 width: imageW,
										 height: imageH)
			}
		
            imageView.tag = index
			index += 1
			
			addSubview(imageView)
			imageView.isUserInteractionEnabled = true
			imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImageView(_:))))
            
            
		}

	}
	

	// ImageW
	private func imageForWidthAtImagePaths(_ imagePaths:[String])->CGFloat{
		guard imagePaths.count > 0 else {return 0}
		// 10 -> margin
		return (KSCREEN_WIDTH-4*10)/3
	}
	

	
	// imageH
	private func imageForHeihtAtImagePaths(_ image:UIImage, _ imagePaths:[String]) -> CGFloat {
		
		guard imagePaths.count > 0 else {return 0}
		
		let imageW = imageForWidthAtImagePaths(imagePaths)
		
		guard image.size.height > 0 else {
			return imageW
		}
		
		var imageH:CGFloat = 0
		if imagePaths.count == 1{
				imageH = image.size.height / image.size.width * imageW
		}else{
			imageH = imageW
		}
		return imageH
	}
	
	// 根据imagePaths.count 返回行数
	private func numberOfRowInImagePaths(_ imagePaths:[String]) ->Int {
		guard imagePaths.count > 0 else {return 0}
		
		if imagePaths.count == 4{
			return 2
		}
		return 3
	
	}
	
	func tapImageView(_ tap:UITapGestureRecognizer)  {
        if let view = tap.view as? UIImageView{
            guard let action = showPotoBrowser else{return}
            action(view)
        }
	}
	
	
}
