//
//  ICEImageViewController.m
//  ZXT
//
//  Created by 1 on 2019/5/27.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEImageViewController.h"

#import "ICEImageViewCell.h"
#import "ICEWatchImageView.h"

#define Margin 0.1

@interface ICEImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>

//数据源-包含图片链接和图片
@property (nonatomic, strong) NSMutableArray *lastSelectPhotos;
//展示视图
@property (nonatomic, strong) UICollectionView * collectionView;
//是否在上传
@property (nonatomic,assign) BOOL isUploading;
//是否处于编辑删除状态
@property (nonatomic,assign) BOOL isEditDelete;
//删除数组
@property (nonatomic, strong) NSMutableArray *deleteDataArr;
//上传失败的下标集合
@property (nonatomic, strong) NSMutableArray *uploadFailDataArr;

@end

@implementation ICEImageViewController

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
        fl.minimumInteritemSpacing = Margin;
        fl.minimumLineSpacing = Margin;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavHegith) collectionViewLayout:fl];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:0.8 ];
        [_collectionView registerNib:[UINib nibWithNibName:@"ICEImageViewCell" bundle:nil] forCellWithReuseIdentifier:@"ICEImageViewCell"];
        [self.view addSubview: _collectionView];
    }
    return _collectionView;
}

- (NSMutableArray*)lastSelectPhotos{
    if (!_lastSelectPhotos) {
        _lastSelectPhotos = [NSMutableArray array];
    }
    return _lastSelectPhotos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.isUploading = false;
    self.isEditDelete = false;
    [self.collectionView reloadData];
    
    [self initUI];
}

- (void) initUI {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    [btn setTitle:@"删除" forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateSelected];
    btn.size = CGSizeMake(30, 30);
    [btn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void) edit:(UIButton *) sender {
    sender.selected = !sender.selected;
    self.isEditDelete = sender.selected;
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger numPreRow = 4;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - Margin*(numPreRow +1)) /numPreRow;
    return CGSizeMake(width, width);
}

#pragma mark -- dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.lastSelectPhotos.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ICEImageViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ICEImageViewCell" forIndexPath:indexPath];
    if (indexPath.row == self.lastSelectPhotos.count) {
        cell.mb_v.hidden = cell.deleteBtn.hidden = true;
        cell.icon.image = [UIImage imageNamed:@"addimage"];
    }else{
        if (!self.isUploading && !self.isEditDelete) {
            //非上传非删除状态
           cell.mb_v.hidden = cell.deleteBtn.hidden = true;
        }else if (!self.isUploading && self.isEditDelete){
            //非上传删除状态
            cell.mb_v.hidden = true;
            cell.deleteBtn.hidden = false;
        }else{
            //上传状态
            cell.mb_v.hidden = false;
            cell.deleteBtn.hidden = true;
        }
        [cell updateCell:self.lastSelectPhotos[indexPath.row]];
    }
    return cell;
}

//调节item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, Margin, 0, Margin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //有上传状态的就不允许操作了
    if (self.isUploading) {
        return;
    }
    if (indexPath.row == self.lastSelectPhotos.count) {
        if (self.isEditDelete) {
            return;
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController的标题" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self getPhotos];
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self openCamera];
            }];
            UIAlertAction *oction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [alertController addAction:oction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else{
        if (self.isEditDelete) {
            //进行删除选中操作,刷新当前的那个item
        }else{
            //预览图片
            ICEWatchImageView * v = [[ICEWatchImageView alloc] initWithFrame:[UIScreen mainScreen].bounds dataArray:self.lastSelectPhotos index:indexPath.row];
            [[UIApplication sharedApplication].keyWindow addSubview:v];
        }
    }
}

//打开相机
- (void) openCamera{
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
            [self requestAuthorizationForVideo];
        else{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = false;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    else{
        NSLog(@"没有摄像头");
    }
}

//进入相册的方法:
-(void)getPhotos{
    __weak typeof(self) weakSelf = self;
    NSInteger maxCount = 9;
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount delegate:weakSelf];
    imagePickerVc.maxImagesCount = maxCount;
    //不拍视频
    imagePickerVc.allowTakeVideo = false;
    //不选视频
    imagePickerVc.allowPickingVideo = false;
    //禁止拍照
    imagePickerVc.allowTakePicture = false;
    //照片排序
    imagePickerVc.sortAscendingByModificationDate = false;
    //不选原图
    imagePickerVc.allowPickingOriginalPhoto = false;
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        NSLog(@"选中图片photos === %@",photos);
        for (UIImage * image in photos) {
            [weakSelf.lastSelectPhotos addObject:image];
        }
        weakSelf.isUploading = true;
        [weakSelf.collectionView reloadData];
    }];
    [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    //通过key值获取到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
   //给UIimageView赋值已经选择的相片
    [self.lastSelectPhotos addObject:image];
    [self.collectionView reloadData];
    
    [self uploadImage:image];
    
    //上传图片到服务器--在这里进行图片上传的网络请求，这里不再介绍
    [self dismissViewControllerAnimated:YES completion:nil];
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ==== 图片上传 ====
- (void) uploadImage:(UIImage *) image{
    //http://10.10.1.18:8081/fdym/test/upload
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    [self PUT:@"https://fdym-attach-img-test.oss-cn-shenzhen.aliyuncs.com/contract/A82F36.jpg?Expires=1559216040&OSSAccessKeyId=LTAI7KCHvoz8QokZ&Signature=nl3%2F0j0gG7yh8sHyFZS2CBPycZM%3D" data:imageData];
}

#pragma mark  ==== 图片上传 ====
- (void)PUT:(NSString *)URLString data:(NSData *)data {
    
    NSString * md5Str =  [[data MD5Digest]  base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    request.HTTPMethod = @"PUT";
    
    [request setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionUploadTask *task = [manager uploadTaskWithRequest:request fromData:data progress:^(NSProgress * _Nonnull uploadProgress) {
       // NSLog(@"=====progress is %@",uploadProgress);
    } completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        //.... httpResponse.statusCode == 200 并且交验md5成功才算上传成功
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        NSDictionary * dic = httpResponse.allHeaderFields;
        NSLog(@">>>>>%zd \n%@ ",httpResponse.statusCode,dic[@"Content-MD5"]);
        if (httpResponse.statusCode == 200) {
            if ([md5Str isEqualToString:dic[@"Content-MD5"]]) {
                //成功
            }
        }else{
            //失败
        }
        
       }];
    
    [task resume];
}

#pragma mark  ==== 请求权限 ====
- (void)requestAuthorizationForVideo
{
    __weak typeof(self) weakSelf = self;
    // 请求相机权限
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (videoAuthStatus != AVAuthorizationStatusAuthorized)
    {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        if (appName == nil) appName = @"APP";
        NSString *message = [NSString stringWithFormat:@"允许%@访问你的相机？", appName];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
        
        UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
        [alertController addAction:okAction];
        [alertController addAction:setAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


- (void)dealloc {
    // NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}

@end
