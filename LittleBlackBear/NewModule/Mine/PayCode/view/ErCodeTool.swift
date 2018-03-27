//
//  ErCodeTool.swift
//  geoTest
//
//  Created by zhijian chen on 2017/4/4.
//  Copyright © 2017年 zhijian chen. All rights reserved.
//

import UIKit

class ErCodeTool: NSObject {
    
//    class func creatQRCodeImage(text: String,size : CGFloat)
    
    
    //MARK: -传进去字符串,生成二维码图片
    class func creatQRCodeImage(text: String,size : CGFloat,icon : UIImage?,iconWidth : CGFloat = 0.25) -> UIImage{
        
        //创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        //还原滤镜的默认属性
        filter?.setDefaults()
        //设置需要生成二维码的数据
        filter?.setValue(text.data(using: String.Encoding.utf8), forKey: "inputMessage")
        //从滤镜中取出生成的图片
        let ciImage = filter?.outputImage
        //这个清晰度不好
        //let bgImage = UIImage(cgImage: ciImage! as! CGImage)
        //这个清晰度好
        let bgImage = createNonInterpolatedUIImageFormCIImage(image: ciImage!, size: size)
        
        //创建一个头像
        guard let img = icon else{
            return bgImage
        }
        
        let newIcon = imageAddBorder(img: img, width: size * iconWidth)
        //合成图片(把二维码和头像合并)
        let newImage = creatImage(bgImage: bgImage, iconImage: newIcon,size : size)
        //返回生成好的二维码
        return newImage
    }
    
    
    
    
    //MARK: - 根据背景图片和头像合成头像二维码
    class func creatImage(bgImage: UIImage, iconImage:UIImage ,size : CGFloat) -> UIImage{
        
        //开启图片上下文
        //        UIGraphicsBeginImageContext(bgImage.size)
        UIGraphicsBeginImageContextWithOptions(bgImage.size, false,UIScreen.main.scale)
        //绘制背景图片
        bgImage.draw(in: CGRect(origin: CGPoint.zero, size: bgImage.size))
        //绘制头像
        let width: CGFloat = iconImage.size.width
        let height: CGFloat = width
        let x = (bgImage.size.width - width) * 0.5
        let y = (bgImage.size.height - height) * 0.5
        
        iconImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        //取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        //返回合成好的图片
        return newImage!
    }
    
    //MARK: - 根据CIImage生成指定大小的高清UIImage
    class func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = image.extent.integral
        let scale: CGFloat = min(size/extent.width, size/extent.height)
        
        let width = extent.width * scale
        let height = extent.height * scale
        
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: extent)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: scale, y: scale)
        bitmapRef.draw(bitmapImage, in: extent)
        let scaledImage: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: scaledImage)
    }
    
    
    
    class func imageAddBorder(img : UIImage,width : CGFloat) -> UIImage{
        let imgsize = CGSize(width: width, height: width)
        let rect = CGRect(x: 0, y: 0, width: width, height: width)
        UIGraphicsBeginImageContextWithOptions(imgsize, false,UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        
        UIColor.white.set()
        
        
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: width / 7.0)
        bezierPath.lineCapStyle = .butt
        ctx?.addPath(bezierPath.cgPath)
        ctx?.fillPath()
        let bezierPathS = UIBezierPath(roundedRect: CGRect(x: width / 35.0, y: width / 35.0, width: width - width / 35.0 * 2.0, height: width - width / 35.0 * 2.0), cornerRadius: width / 7.0)
        ctx?.addPath(bezierPathS.cgPath)
        
        
        ctx?.clip()
        img.draw(in: CGRect(x: width / 35.0, y: width / 35.0, width: width - width / 35.0 * 2.0, height: width - width / 35.0 * 2.0))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    
    
    
    
    


}
