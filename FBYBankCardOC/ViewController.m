//
//  ViewController.m
//  FBYBankCardOC
//
//  Created by fanbaoying on 2019/10/16.
//  Copyright © 2019 fby. All rights reserved.
//

#import "ViewController.h"
#import "FBYBankCardOC-Swift.h"

#define kWidth [[UIScreen mainScreen] bounds].size.width
#define kHeight [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()

@property(strong, nonatomic)WalletView *walletView;
@property(strong, nonatomic)UIView *walletHeaderView;
@property(strong, nonatomic)UIButton *addCardViewButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.walletView = [[WalletView alloc]initWithFrame:CGRectMake(10, 0, kWidth - 20, kHeight - 20)];
    [self.view addSubview:_walletView];
    
    self.walletHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth - 20, 44)];
    
    _walletView.walletHeader = self.walletHeaderView;
    _walletView.useHeaderDistanceForStackedCards = true;
    _walletView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    self.addCardViewButton = [[UIButton alloc]initWithFrame:CGRectMake(kWidth - 64, 0, 44, 44)];
    [self.addCardViewButton setImage:[UIImage imageNamed:@"add"] forState:0];
    [self.addCardViewButton addTarget:self action:@selector(addCardButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.walletHeaderView addSubview:_addCardViewButton];
    
    NSMutableArray *coloredCardViews = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *imageArr = @[@"招商",@"建设",@"农业"];
    for (int i = 0; i < imageArr.count; i ++) {
        ColoredCardView *cardView = [[ColoredCardView alloc]init];
        cardView.cardImage = imageArr[i];
        [coloredCardViews addObject:cardView];
    }
    
    [_walletView reloadWithCardViews:coloredCardViews];
    
    __weak typeof(self) weakSelf = self;
    _walletView.didPresentCardViewBlock = ^(CardView * _Nullable PresentedCardViewDidUpdateBlock) {
        [weakSelf showAddCardViewButtonIfNeeded];
    };
}

- (void)showAddCardViewButtonIfNeeded {
    BOOL isViewBool = _walletView.presentedCardView == nil || _walletView.insertedCardViews.count <= 1;
    self.addCardViewButton.alpha = isViewBool ? 1.0 : 0.0;
}

- (void)addCardButton:(UIButton *)sender {
    ColoredCardView *cardViews = [[ColoredCardView alloc]init];
    [_walletView insertWithCardView:cardViews animated:YES presented:YES completion:^{
        
    }];
}


@end
