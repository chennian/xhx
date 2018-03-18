
#import "LBBaiduMapAPI.h"

@implementation LBBaiduMapAPI

@end

//@interface HouseTypeMapVC
//
//@end
//@interface HouseTypeMapVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
//    BMKLocationService * _locService;
//}
//@property (nonatomic,strong) UIView * locationView;
//@property (nonatomic,strong) UIImageView * locImageView;
//@property (nonatomic,strong) UIView * messageView;
//@property (nonatomic,strong) UILabel * addressLabel;
//@property (nonatomic,strong) UIButton * sureButton;
//@property (nonatomic,strong) NSString * name;
//@property (nonatomic,assign) CLLocationCoordinate2D location2D;
//@property (nonatomic, strong)BMKGeoCodeSearch* searchAddress;
//@property (strong, nonatomic) IBOutlet BMKMapView *mapView;
//@property (nonatomic,strong)BMKUserLocation *userLocation; //定位功能
//@end
//@implementation HouseTypeMapVC
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear: animated];
//    [_mapView viewWillAppear];
//    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _locService.delegate = self;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [_mapView viewWillDisappear];
//    _mapView.delegate = nil; // 不用时，置nil
//    _locService.delegate = nil;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//}
//- (void)initUI{
//    [self goBackBtn];
//    _mapView.mapType=BMKMapTypeStandard;
//    [self initlocationService];
//}
//#pragma mark --initlocationService--定位
//-(void)initlocationService{
//    _locService = [[BMKLocationService alloc]init];
//    [_locService startUserLocationService];
//    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
//    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
//    _mapView.showsUserLocation = YES;//显示定位图层
//    _mapView.showMapScaleBar = YES;//显示比例尺
//    _mapView.zoomLevel = 17;//地图显示的级别
//    _searchAddress = [[BMKGeoCodeSearch alloc]init];
//    _searchAddress.delegate = self;
//}
////这里是创建中心显示的图片和显示详细地址的View
//- (void)createLocationSignImage{
//    //LocationView定位在当前位置，换算为屏幕的坐标，创建的定位的图标
//    self.locationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 28, 35)];
//    self.locImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 35)];
//    self.locImageView.image = [UIImage imageNamed:@"myLocation"];
//    [self.locationView addSubview:self.locImageView];
//    //messageView 展示定位信息的View和Label和button
//    self.messageView = [[UIView alloc]init];
//    self.messageView.backgroundColor = [UIColor whiteColor];
//    //把当前定位的经纬度换算为了View上的坐标
//    CGPoint point = [self.mapView convertCoordinate:_mapView.centerCoordinate toPointToView:_mapView];
//    //当解析出现错误的时候，会出现超出屏幕的情况，一种是大于了屏幕，一种是小于了屏幕
//    if(point.x > ScreenWidth || point.x < ScreenWidth/5){
//        point.x = _mapView.centerX;
//        point.y = _mapView.centerY-64;
//    }
//    NSLog(@"Point------%f-----%f",point.x,point.y);
//    //重新定位了LocationView
//    self.locationView.center = point;
//    [self.locationView setFrame:CGRectMake(point.x-14, point.y-18, 28, 35)];
//    //重新定位了messageView
//    [self.messageView setFrame:CGRectMake(30, point.y-40-20, SCREEN_WIDTH-60, 40)];
//    //展示地址信息的label
//    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.messageView.frame.size.width - 80, 40)];
//    self.addressLabel.font = [UIFont systemFontOfSize:13.0f];
//    [self.messageView addSubview:self.addressLabel];
//    //把地址信息传递到上个界面的button
//    self.sureButton = [[UIButton alloc]initWithFrame:CGRectMake(self.addressLabel.frame.origin.x + self.addressLabel.frame.size.width, 0,self.messageView.frame.size.width - self.addressLabel.frame.origin.x - self.addressLabel.frame.size.width, 40)];
//    [self.messageView addSubview:self.sureButton];
//    self.sureButton.backgroundColor = [UIColor colorWithHex:0x2ecb7d];
//    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
//    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
//    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.mapView addSubview:self.messageView];
//    [self.mapView addSubview:self.locationView];
//}
///**
// *用户位置更新后，会调用此函数
// *@param userLocation 新的用户位置
// */
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
//    BMKCoordinateRegion region;
//    region.center.latitude  = userLocation.location.coordinate.latitude;
//    region.center.longitude = userLocation.location.coordinate.longitude;
//    region.span.latitudeDelta = 0;
//    region.span.longitudeDelta = 0;
//    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);    [_mapView updateLocationData:userLocation];
//    [_locService stopUserLocationService];//取消定位  这个一定要写，不然无法移动定位了
//    _mapView.centerCoordinate = userLocation.location.coordinate;
//    NSLog(@" _mapView.centerCoordinate------%f-----%f", _mapView.centerCoordinate.latitude, _mapView.centerCoordinate.longitude);
//    [self createLocationSignImage];
//}//确定按钮的点击
//- (void)sureButtonClick:(UIButton *)button{
//    if([self.chosseAddressDelegate respondsToSelector:@selector(chosseAddressBack:name:point:)]){
//        [self.chosseAddressDelegate chosseAddressBack:self.addressLabel.text name:self.name point:self.location2D];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}
//- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
//    NSLog(@"点击了");
//    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
//    pt=(CLLocationCoordinate2D){mapView.region.center.latitude,mapView.region.center.longitude};
//    BMKReverseGeoCodeOption * option = [[BMKReverseGeoCodeOption alloc]init];
//    option.reverseGeoPoint = pt;
//    BOOL flag=[_searchAddress reverseGeoCode:option];
//    if (flag) {
//        //        _mapView.showsUserLocation=NO;//不显示自己的位置
//    }
//}//地图被拖动的时候，需要时时的渲染界面，当渲染结束的时候我们就去定位然后获取图片对应的经纬度
//- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus*)status{
//    NSLog(@"onDrawMapFrame");
//}
//- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
//    NSLog(@"regionWillChangeAnimated");
//}
//- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    NSLog(@"regionDidChangeAnimated");    CGPoint touchPoint = self.locationView.center;
//    CLLocationCoordinate2D touchMapCoordinate =
//    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];//这里touchMapCoordinate就是该点的经纬度了
//    NSLog(@"touching %f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
//    BMKReverseGeoCodeOption * option = [[BMKReverseGeoCodeOption alloc]init];
//    option.reverseGeoPoint = touchMapCoordinate;
//    BOOL flag=[_searchAddress reverseGeoCode:option];
//    if (flag) {
//        //        _mapView.showsUserLocation=NO;//不显示自己的位置
//    }
//}//定位自己的位置
//- (IBAction)locationButtonClick:(UIButton *)sender {
//    [_locService startUserLocationService];
//    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
//    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
//    _mapView.showsUserLocation = YES;//显示定位图层
//}
////点击地图的空白区域
//- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
//    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
//}
////点击地图中的背景有标记的区域
//- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi{
//    NSLog(@"点击onClickedMapPoi---%@",mapPoi.text);
//    CLLocationCoordinate2D coordinate = mapPoi.pt;
//    //长按之前删除所有标注
//    NSArray *arrayAnmation=[[NSArray alloc] initWithArray:_mapView.annotations];
//    [_mapView removeAnnotations:arrayAnmation];
//    //设置地图标注
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    annotation.coordinate = coordinate;
//    annotation.title = mapPoi.text;
//    [_mapView addAnnotation:annotation];
//    BMKReverseGeoCodeOption *re = [[BMKReverseGeoCodeOption alloc] init];
//    re.reverseGeoPoint = coordinate;
//    [SVProgressHUD show];
//    [_searchAddress reverseGeoCode:re];
//    BOOL flag =[_searchAddress reverseGeoCode:re];
//    if (!flag){
//        NSLog(@"search failed!");
//    }
//}
////根据经纬度返回点击的位置的名称
//-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
//    [SVProgressHUD dismiss];
//    NSString * resultAddress = @"";
//    NSString * houseName = @"";
//    CLLocationCoordinate2D  coor = result.location;
//    if(result.poiList.count > 0){
//        BMKPoiInfo * info = result.poiList[0];
//        if([info.name rangeOfString:@"-"].location != NSNotFound){
//            houseName = [info.name componentsSeparatedByString:@"-"][0];
//        }else{
//            houseName = info.name;
//        }
//        resultAddress = [NSString stringWithFormat:@"%@%@",result.address,info.name];
//    }else{
//        resultAddress =result.address;
//    }
//    if(resultAddress.length == 0){
//        self.addressLabel.text = @"位置解析错误，请拖动重试！";
//        return;
//    }
//    self.addressLabel.text = resultAddress;
//    self.location2D = coor;
//    self.name = houseName;
//}
////点击一个大头针
//- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
//    NSLog(@"点击didSelectAnnotationView-");
//}
///**
// *在地图View将要启动定位时，会调用此函数
// *@param mapView 地图View
// */
//- (void)willStartLocatingUser
//{
//    NSLog(@"start locate");
//}
///**
// *用户方向更新后，会调用此函数
// *@param userLocation 新的用户位置
// */
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    [_mapView updateLocationData:userLocation];
//    NSLog(@"heading is %@",userLocation.heading);
//}/**
//  *在地图View停止定位后，会调用此函数
//  *@param mapView 地图View
//  */
//- (void)didStopLocatingUser
//{
//    NSLog(@"stop locate");
//}
///**
// *定位失败后，会调用此函数
// *@param mapView 地图View
// *@param error 错误号，参考CLError.h中定义的错误号
// */
//- (void)didFailToLocateUserWithError:(NSError *)error
//{
//    NSLog(@"location error");

//}
//- (void)dealloc {
//    if (_mapView) {
//        _mapView = nil;
//    }
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//@end

