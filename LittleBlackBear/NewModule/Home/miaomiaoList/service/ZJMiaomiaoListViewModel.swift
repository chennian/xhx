//
//  ZJMiaomiaoListViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 12/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift

class ZJMiaomiaoListViewModel: SNBaseViewModel {

    
    
    let reloadPub = PublishSubject<Void>()
    var cellModels : [ZJHomeMiaoMiaoModel] = []
    
    func reuquestData(shopid : String){
        SNRequest(requestType: API.getMiaomiaoList(shopId: shopid), modelType: [ZJHomeMiaoMiaoModel.self]).subscribe(onNext: { (res) in
            switch res{
            case .success(let models):
                self.cellModels = models
                self.reloadPub.onNext(())
            case .fail:
                SZHUD("获取秒秒列表失败", type: .error, callBack: nil)
            default:
                return
            }
        }).disposed(by: disposeBag)
    }
    
}
extension ZJMiaomiaoListViewModel : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ZJMiaomiaoCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentify(ZJMiaomiaoCollectionCell.self), for: indexPath) as! ZJMiaomiaoCollectionCell
        cell.model = cellModels[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = LBShopDetailsController()
        vc.miaomiaoModel = cellModels[indexPath.row]
        self.jumpSubject.onNext(SNJumpType.push(vc: vc, anmi: true))
    }
}
