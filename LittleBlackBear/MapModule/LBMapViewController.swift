//
//  LBMapViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
private let redPacketReuseId = "redPacket"
private let mercIconReuseId = "mercIconreuseId"

class LBMapViewController: UIViewController{
    
    // MARK: - properties
    fileprivate var _mapView:BMKMapView!
    fileprivate var _searchAddress:BMKGeoCodeSearch!
    fileprivate var locationService: BMKLocationService!
    
    fileprivate var redPacketPointAnnotation:BMKPointAnnotation?
    fileprivate var mercPointAnnotation:BMKPointAnnotation?
    fileprivate var districtSearch: BMKDistrictSearch!
    
    fileprivate let pulsetorLayer = LBMapPulseLayer()
    fileprivate let navgationBar = LBMapNavigationBar()
    fileprivate let userLocationBtn = UIButton()
    
    fileprivate var mapItems:[mapDetailListModel<mapLocation>] = []
	fileprivate var mercItems:[(index:Int,model:mapDetailListModel<mapLocation>)] = []
    fileprivate var redPacketInfoModels:[redPacketInfoModel] = []
	fileprivate var mercIcons:[Int:String] = [:]
    fileprivate var redPacketIndex = 0
	fileprivate var marcIndex = 0
    fileprivate var time:Timer? = nil
    
    fileprivate var redPacketAnimation = true
    fileprivate var isRegionDidChangePulseAnimated:Bool = false
    
    fileprivate let mercId = LBKeychain.get(CURRENT_MERC_ID)
    
    
    fileprivate var piont1:BMKMapPoint = {
        let latitude  = LBKeychain.get(latitudeKey)
        let longidute = LBKeychain.get(longiduteKey)
        return BMKMapPointForCoordinate(CLLocationCoordinate2DMake(Double(latitude) ?? 0,Double(longidute) ?? 0))
    }()
    fileprivate var piont2:BMKMapPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "地图"
        _initMapView()
        districtSearch = BMKDistrictSearch()
        view.addSubview(navgationBar)
        transformCityAction()
        setupUserLocationButton()
        setupPulsetorLayer()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        _mapView.delegate = self
        districtSearch.delegate = self
        startLocation()
        pullRedPacket()
        time  = Timer.scheduledTimer(timeInterval: 30,
                                     target: self,
                                     selector: #selector(pullRedPacket),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        _mapView.delegate = nil
        districtSearch.delegate = nil
        locationService.delegate = nil
        _searchAddress.delegate = nil
        pulsetorLayer.stop()
        time?.invalidate()
        time = nil
    }
    
    fileprivate func _initMapView() {
        
        _mapView = BMKMapView(frame:UIScreen.main.bounds)
        view.addSubview(_mapView!)
        _mapView.zoomLevel = 16
        _mapView.baseIndoorMapEnabled = true
        _mapView.showsUserLocation = false
        _mapView.userTrackingMode = BMKUserTrackingModeFollow
        _mapView.showsUserLocation = true
        _mapView.isZoomEnabledWithTap = true
        
        let locations = locationCoordinateConvert()
        var  loacation = "\(locations.longitude)" + "," + "\(locations.latitude)"
        if LBKeychain.get(LOCATION_CITY_KEY).isChinese() == false  {
            // 深圳
            //lng = "114.047870066526"
            //lat = "22.6008299566074"
            loacation = "114.047870066526,22.6008299566074"

        }
        
        requiredMap(location:loacation, completHandler:{_ in })
        
    }
    
    func startLocation() {
        
        locationService = BMKLocationService()
        locationService.startUserLocationService()
        locationService.delegate = self
        
        _searchAddress = BMKGeoCodeSearch()
        _searchAddress.delegate = self
        
    }
    
    func setupUserLocationButton() {
        
        view.addSubview(userLocationBtn)
        userLocationBtn.translatesAutoresizingMaskIntoConstraints = false
        userLocationBtn.setBackgroundImage(UIImage(named:"user_location_icon"), for: .normal)
        userLocationBtn.addTarget(self, action: #selector(resetUserLoactionAction(_:)), for: .touchUpInside)
        
        view.addConstraint(BXLayoutConstraintMake(userLocationBtn, .right, .equal,view,.right ,-20))
        view.addConstraint(BXLayoutConstraintMake(userLocationBtn, .bottom, .equal,view,.bottom,-100))
        view.addConstraint(BXLayoutConstraintMake(userLocationBtn, .width, .equal,nil,.width,36))
        view.addConstraint(BXLayoutConstraintMake(userLocationBtn, .height, .equal,nil,.height,36))
        
    }
    // 返回用户位置
    func resetUserLoactionAction(_ btn:UIButton)  {
        btn.isSelected = true
        
        _mapView.removeAnnotations(_mapView.annotations)
        navgationBar.cityText = LBKeychain.get(LOCATION_CITY_KEY)
        
        let locations = locationCoordinateConvert()
        let loacation = "\(locations.longitude)" + "," + "\(locations.latitude)"
        
        requiredMap(location:loacation, completHandler: {(result)in
            btn.isSelected = false
        })
        
        pullRedPacket()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.425) {
            self.pulsetorLayer.stop()
        }
        
        
    }
    // 脉冲动画
    func setupPulsetorLayer() {
        view.layer.addSublayer(pulsetorLayer)
        pulsetorLayer.frame = CGRect(x: KSCREEN_WIDTH*0.5, y: KSCREEN_HEIGHT*0.5, width: 0, height: 0 )
        pulsetorLayer.restartIfNeeded()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
// MARK:BMKDistrictSearchDelegate
extension LBMapViewController:BMKDistrictSearchDelegate{
    
    func onGetDistrictResult(_ searcher: BMKDistrictSearch!, result: BMKDistrictResult!, errorCode error: BMKSearchErrorCode) {
        
        Print("onGetDistrictResult error: \(error)")
        _mapView.removeOverlays(_mapView.overlays)
        if error == BMK_SEARCH_NO_ERROR {
            _mapView.removeAnnotations(_mapView.annotations)
            Print("\nname:\(result.name)\ncode:\(result.code)\ncenter latlon:\(result.center.latitude),\(result.center.longitude)");
            let loacation = "\(result.center.longitude)" + "," + "\(result.center.latitude)"
            requiredMap(location:loacation, completHandler: {[weak self](Result)in
                guard let strongSelf = self else{return}
                if Result == false {
                    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+0.75, execute: {
                        strongSelf.pulsetorLayer.stop()
                    })
                    let annotation = BMKPointAnnotation()
                    let point = CLLocationCoordinate2DMake(Double(result.center.latitude),Double(result.center.longitude))
                    annotation.coordinate = point
                    strongSelf._mapView.centerCoordinate = point
                    strongSelf._mapView.addAnnotation(annotation)
                    strongSelf.pullRedPacket()

                }
            })
        }
    }
    
    func onGet(_ cloudRGCResult: BMKCloudReverseGeoCodeResult!, searchType type: BMKCloudSearchType, errorCode: Int) {
        
    }
}

// MARK: BMKCloudSearchDelegate、BMKLocationServiceDelegate
extension LBMapViewController:BMKCloudSearchDelegate,BMKLocationServiceDelegate{
    
    func didUpdate(_ userLocation: BMKUserLocation!) {
        _mapView.updateLocationData(userLocation)
        locationService.stopUserLocationService()
        Print(userLocation)
    }
    
}
// MARK: BMKGeoCodeSearchDelegate
extension LBMapViewController:BMKGeoCodeSearchDelegate{
    
    func onGetGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        
    }
    
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        
    }
    
}
// MARK: BMKMapViewDelegate、BMKPoiSearchDelegate
extension LBMapViewController:BMKMapViewDelegate{
    
    func mapView(_ mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        
        let logitude = mapView.centerCoordinate.longitude
        let latitude = mapView.centerCoordinate.latitude
        piont2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(latitude,logitude))
        // 计算两点距离  范围查询：默认2km
        let distance:CLLocationDistance = BMKMetersBetweenMapPoints(piont1, piont2!)
        // >2km 就查询
        guard  distance > 2000 else {return}
        
        guard isRegionDidChangePulseAnimated == true else {return}
        
        piont1 = piont2!
        pulsetorLayer.start()
        
        let location = "\(logitude)" + "," + "\(latitude)"
        _mapView.removeAnnotations(_mapView.annotations)
        requiredMap(location: location) {[weak self] (result) in
            
            guard let strongSelf = self else {return}
            strongSelf.isRegionDidChangePulseAnimated = false
            
            if result == false {
                DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+0.75, execute: {
                    strongSelf.pulsetorLayer.stop()
                })
            }else{
                DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+0.75, execute: {
                    strongSelf.pulsetorLayer.stop()
                })
            }
            
        }
    }
    
    func mapViewDidFinishRendering(_ mapView: BMKMapView!) {
        if userLocationBtn.isSelected == false {
            isRegionDidChangePulseAnimated = true
        }
    }
    
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        
     
        if (annotation as! BMKPointAnnotation) == redPacketPointAnnotation{
            
            let Identifier = redPacketReuseId
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) as! BMKPinAnnotationView?
            if annotationView == nil {
                annotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: Identifier)
                annotationView?.image = #imageLiteral(resourceName: "map_redPecket")
                annotationView!.isDraggable = false
            }
            annotationView!.animatesDrop = redPacketAnimation
            redPacketAnimation = false
            annotationView?.annotation = annotation
            if redPacketIndex < redPacketInfoModels.count{
                let _id = redPacketInfoModels[redPacketIndex].id
                annotationView?.tag = _id
                mercIcons[_id] = redPacketInfoModels[redPacketIndex].mainImgUrl
                redPacketIndex += 1
            }
            return annotationView
            
        }
        if (annotation as! BMKPointAnnotation) == mercPointAnnotation{
            let Identifier = mercIconReuseId
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) as! BMKPinAnnotationView?
            if annotationView == nil {
                annotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: Identifier)
                annotationView?.image = #imageLiteral(resourceName: "map_merchantIcon")
                annotationView!.animatesDrop = true
                annotationView!.isDraggable = false
            }
			if marcIndex < mapItems.count{
				let id = mapItems[marcIndex].uid
				annotationView?.tag = id
				marcIndex += 1
			}
			
            annotationView?.annotation = annotation
            return annotationView
        }

        let Identifier = "other"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) as! BMKPinAnnotationView?
        if annotationView == nil {
            annotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: Identifier)
       
        }
        annotationView?.annotation = annotation
        return annotationView
        
    }
    
    
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        
        if view.reuseIdentifier == mercIconReuseId {
			showMercAlertView(view.tag)
        }
		if view.reuseIdentifier == redPacketReuseId{
			openRedPacket(id:view.tag)

		}
    }
}
// MARK:LBMapPresenter
extension LBMapViewController:LBMapPresenter{
    
    // 显示地图上的商家
    func requiredMap(location:String,completHandler:@escaping (Bool)->Void){//completHandler (true 有商家，false无商家)
        
        requiredMapData(mercNum: mercId, location: location, success: { [weak self](item) in
            
            guard let strongSelf = self else{return}
            guard item.detail.list.count > 0,item.detail.list.first != nil else{
                completHandler(false)
                return
            }
            
            strongSelf.mapItems.removeAll()
			strongSelf.mercItems.removeAll()
            item.detail.list.forEach{
                strongSelf.mapItems.append(mapDetailListModel<mapLocation>(json:$0))
            }
            
            let annotations = strongSelf._mapView.annotations.filter{($0 as! BMKPointAnnotation) == strongSelf.mercPointAnnotation}
            strongSelf._mapView.removeAnnotations(annotations)
            
            for item in strongSelf.mapItems {
                
                strongSelf.mercPointAnnotation = BMKPointAnnotation()
                let point = CLLocationCoordinate2DMake( Double(item.location.latitude)!,Double(item.location.longidute)!)
				
				strongSelf.mercItems.append((index: item.uid, model:item))
                strongSelf.mercPointAnnotation!.coordinate = point
                strongSelf.mercPointAnnotation!.title = item.address
                strongSelf._mapView.centerCoordinate = point
                strongSelf._mapView.addAnnotation(strongSelf.mercPointAnnotation)
                
            }
            
            completHandler(true)
            
        })
    }
    // 红包位置
    func pullRedPacket() {
        
        redPacketIndex = 0
        redPacketInfoModels.removeAll()
        requestAllRedPacket(mercNum: mercId, success: {[weak self] (model) in
            
            guard let strongSelf = self else{return}
            strongSelf.redPacketInfoModels = model.redPackets
            guard model.lbsCloudSers.count > 0 else {return}
            strongSelf._mapView.removeAnnotation(strongSelf.redPacketPointAnnotation)
            model.lbsCloudSers.forEach{
                
                guard $0.location.latitude.count > 0, $0.location.longidute.count > 0 else{return}
                strongSelf.redPacketPointAnnotation = BMKPointAnnotation()
                let point = CLLocationCoordinate2DMake( Double($0.location.latitude)!,Double($0.location.longidute)!)
                strongSelf.redPacketPointAnnotation?.coordinate = point
                strongSelf.redPacketPointAnnotation?.title = $0.address
                strongSelf._mapView.addAnnotation(strongSelf.redPacketPointAnnotation)
//                strongSelf._mapView.centerCoordinate = point
                
            }
        })
    }
	
    
    func openRedPacket(id:Int){
        
        // 打开红包先弹广告 商家主图
        let adView = LBMapAdView()
        adView.url = mercIcons[id]!
        // 打开 红包
        openRedPacketAction(mercNum: mercId, redPacketId: "\(id)", success: {[weak self] (amount) in
            guard let strongSelf = self else{return}
            adView.showNextView = {
                strongSelf.showRedPacketView("\(amount/100)")
            }
        }) {[weak self] (msg) in
            guard let strongSelf = self else{return}
            adView.showNextView = {
                strongSelf.showRedPacketView("")
            }
            
        }
        UIApplication.shared.keyWindow?.addSubview(adView)
        
    }
	
	func showMercAlertView(_ index:Int) {
		let view = LBMapAlertMercView.initSelf()
		var orgCode = ""
		var mercId = ""
		mercItems.forEach{
			if $0.index == index{
				view.model = $0.model
				orgCode = $0.model.orgcode
				mercId = "\($0.model.uid)"
			}
		}
		view.goonAction = { _ in
			view.removeFromSuperview()
		}
		view.pushShopAction = {[weak self] _ in
			guard let strongSelf = self else { return }
			let viewController = LBShoppingMallDetailViewController()
			viewController.orgCode = orgCode
			viewController.mercId = mercId
			strongSelf.navigationController?.pushViewController(viewController, animated: true)
		}
		UIApplication.shared.keyWindow?.addSubview(view)

	}
}

// MARK: showRedPacket 显示红包
extension LBMapViewController{
    
    func showRedPacketView(_ amount:String = "") {
        
        let  redPacketView = LBMapRePacketView()
        
        UIApplication.shared.keyWindow?.addSubview(redPacketView)
        redPacketView.cickOpenRedPacketAction = {}
        redPacketView.animationCompletionHandler = {(imageView) in
            if amount.count > 0{
                redPacketView.moneyValue = amount
            }else{
                // 领取失败页面
                imageView.image = UIImage(named:"redPacket_gone")
            }
            redPacketView.removeFromSuperviewAction = {
                redPacketView.removeFromSuperview()
            }
        }
        
    }
    
    // 切换城市
    func transformCityAction(){
        
        navgationBar.transformCityAction = {[weak self] (label) in
            guard let strongSelf = self else { return }
            let viewController = LBCityListViewController()
            viewController.selectCity = {(value) in
                label.text = value
                // 发起检索
                strongSelf.setupDistrictSearch(city:value)
            }
            strongSelf.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func setupDistrictSearch(city:String) {
        
        let option = BMKDistrictSearchOption()
        option.city = city
        let flag = districtSearch.districtSearch(option)
        if flag {
            Print("district检索发送成功")
        } else {
            Print("district检索发送失败")
        }
    }
}




