//
//  HCBaseViewController.m
//  Heacha
//
//  Created by Allen Zhong on 15/1/11.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import "DFBaseViewController.h"

#import "DFView.h"

#import "DFNetwork.h"

#import "UIBarButtonItem+Lite.h"



@interface DFBaseViewController()


@property (strong,nonatomic) UIView *loadingView;
@property (strong,nonatomic) UIActivityIndicatorView *loadingIndicator;


@property (strong,nonatomic) UIView *loadFailView;


@end



@implementation DFBaseViewController

#pragma mark - Lifecycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)dealloc
{
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BaseViewColor;
    
    if (self.navigationController.viewControllers.count > 1) {
        if ([self leftBarButtonItem] != nil) {
            self.navigationItem.leftBarButtonItem = [self leftBarButtonItem];
        }
    }
    
    
    if ([self rightBarButtonItem] != nil) {
        self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}



#pragma mark - Method

-(void) hudShowText:(NSString *)text
{
    [self hudShowText:text second:HudDefaultHideTime];
}


-(void) hudShowText:(NSString *)text second:(NSInteger)second
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.removeFromSuperViewOnHide = YES;
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:second];
}


-(MBProgressHUD *) hudShowLoading
{
    return [self hudShowLoading:@"加载中..."];
}


-(MBProgressHUD *) hudShowLoading:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.removeFromSuperViewOnHide = YES;
    hud.label.text = text;
    hud.square = YES;
    return hud;
}



-(void) hudShowOk:(NSString *) text
{
    NSString *imageName = @"check_success";
    [self hudShowIcon:imageName text:text];
}


-(void) hudShowFail:(NSString *) text
{
    NSString *imageName = @"fail";
    [self hudShowIcon:imageName text:text];
}




-(void) hudShowIcon:(NSString *) imageName text:(NSString *) text
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view.window addSubview:hud];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = text;
    hud.square = YES;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:3];
    
}





-(void) showLoadingView
{
    [self showLoadingView:YES];
}


-(void) hideLoadingView
{
    [self showLoadingView:NO];
}


-(void)showLoadingView:(BOOL)show
{
    if (show) {
        
        if (_loadingView == nil) {
            _loadingView = [[UIView alloc] initWithFrame:self.view.frame];
            _loadingView.backgroundColor = [UIColor whiteColor];
            
            CGFloat x, y , width, height;
            x = CGRectGetMidX(self.view.frame);
            y = CGRectGetMidY(self.view.frame);
            width = 50;
            height = 50;
            _loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            _loadingIndicator.center = CGPointMake(x, y);
            _loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            [_loadingView addSubview:_loadingIndicator];
            [self.view addSubview:_loadingView];
            
        }
        
        [_loadingIndicator startAnimating];
        _loadingView.hidden = NO;
        [self.view bringSubviewToFront:_loadingView];
        
        
    }else{
        if (_loadingView != nil) {
            _loadingView.hidden = YES;
            [_loadingIndicator stopAnimating];
        }
    }
}

-(void) showLoadFailView
{
    [self showLoadFailView:YES];
}


-(void) hideLoadFailView
{
    [self showLoadFailView:NO];
}

-(void)showLoadFailView:(BOOL)show
{
    if (show) {
        
        if (_loadFailView == nil) {
            _loadFailView = [[UIView alloc] initWithFrame:self.view.frame];
            _loadFailView.backgroundColor = [UIColor whiteColor];
            
            CGFloat x, y , width, height;
            x = CGRectGetMidX(self.view.frame);
            y = CGRectGetMidY(self.view.frame);
            width = 100;
            height = 100;
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            button.center = CGPointMake(x, y);
            [button addTarget:self action:@selector(onClickLoadButton:) forControlEvents:UIControlEventTouchUpInside];
            
            width = 55;
            height = width;
            x = (CGRectGetWidth(button.frame) - width)/2;
            y = 0;
            UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            imageView.image = [UIImage imageNamed:@"refresh"];
            [button addSubview:imageView];
            
            x = 0 ;
            y = CGRectGetMaxY(imageView.frame) + 10;
            width = CGRectGetWidth(button.frame);
            height = 15;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            label.text = @"点击重新加载";
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = [UIColor lightGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            [button addSubview:label];
            [_loadFailView addSubview:button];
            [self.view addSubview:_loadFailView];
            
        }
        
        _loadFailView.hidden = NO;
        [self.view bringSubviewToFront:_loadFailView];
        
        
    }else{
        if (_loadFailView != nil) {
            _loadFailView.hidden = YES;
        }
    }
}

-(void) onClickLoadButton:(id) sender
{
    [self onClickLoadFailView];
}

-(void)onClickLoadFailView
{
    
}


-(BOOL)enableAutoLoadStateView
{
    return YES;
}



#pragma - mark DFDataServiceDelegate


-(void)onRequestError:(NSError *)error dataService:(DFBaseDataService *)dataService
{
    if (error.code == CustomErrorConnectFailed || error.code == -1005) {
        [self hudShowText:@"网络无法连接"];
    }
    
    if (error.code == -1001) {
        [self hudShowText:@"网络超时"];
    }
    
    if ([self enableAutoLoadStateView]) {
        [self hideLoadingView];
        [self showLoadFailView];
    }
    
    
    NSLog(@"%@",error);
}

-(void)onStatusError:(DFBaseResponse *)response dataService:(DFBaseDataService *)dataService
{
    if (response.errorCode == 0 || response.errorMsg == nil) {
        [self hudShowText:@"未知错误, 请联系客服"];
    }else{
        NSLog(@"CODER-ERROR: %@",[NSString stringWithFormat:@"%ld:%@",(long)response.errorCode,response.errorMsg]);
        [self hudShowText:[NSString stringWithFormat:@"%@",response.errorMsg]];
    }
    
    if ([self enableAutoLoadStateView]) {
        [self hideLoadingView];
        [self showLoadFailView];
    }
    
    
}

- (void)onStatusOk:(DFBaseResponse *)response dataService:(DFBaseDataService *)dataService
{
    if ([self enableAutoLoadStateView]) {
        [self hideLoadingView];
        [self hideLoadFailView];
    }
}



-(UIBarButtonItem *) rightBarButtonItem
{
    return nil;
}
-(UIBarButtonItem *) leftBarButtonItem
{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 34, 44);
    [backBtn addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 11, 22, 22)];
    imageV.image = [UIImage imageNamed:@"my_fh"];
    [backBtn addSubview:imageV];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    return btnItem;
}

-(UIBarButtonItem *)defaultReturnBarButtonItem
{
    return [UIBarButtonItem back:@"返回" selector:@selector(onBack:) target:self];
}

-(void) onBack:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
