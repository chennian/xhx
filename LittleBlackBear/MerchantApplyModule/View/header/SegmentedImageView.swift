//
//  SegmentedImageView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class SegmentedImageView: UIImageView {
    
    fileprivate var segmentedImages: [UIImage]
    
    fileprivate let action: (_ index: Int) -> ()
    
    init(segmentedImageStrs: [String], action: @escaping (_ index: Int) -> ()) {
        self.action = action
        self.segmentedImages = segmentedImageStrs.map{
            guard let image = UIImage(named: $0) else {
                assert(false, "\($0) 图片名称不存在")
                return UIImage()
            }
            return image
        }
        super.init(frame: .zero)
        setup()
    }
    
    
    init(segmentedImages: UIImage..., action: @escaping (_ index: Int) -> ()) {
        self.segmentedImages = segmentedImages
        self.action = action
        super.init(frame: .zero)
        setup()
    }
    
    func setup() {
        self.image = segmentedImages.first
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SegmentedImageView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint = touch.location(in: self)
        guard self.bounds.contains(touchPoint) else {
            return false
        }
        let segmentWidth = self.frame.width / segmentedImages.count.f
        let index = Int(touchPoint.x / segmentWidth)
        
        self.image = segmentedImages[index]
        action(index)
        return false
    }
}
