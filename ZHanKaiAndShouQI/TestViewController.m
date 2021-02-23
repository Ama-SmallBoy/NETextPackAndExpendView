//
//  TestViewController.m
//  ZHanKaiAndShouQI
//
//  Created by Xdf on 2021/2/22.
//

#import "TestViewController.h"
#import "NETextPackAndExpendView.h"
#import <Masonry.h>
@interface TestViewController ()<NETextPackAndExpendViewDelegate>
@property (nonatomic,strong) NETextPackAndExpendView *textPackAndExpendView;
@property (nonatomic,strong) NETextPackAndExpendConfig * config;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.config = [[NETextPackAndExpendConfig alloc] init];
    self.config.textString = @"当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群";
    
    self.config.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    self.config.maxLine = 5;
    //self.config.actionTextPosition = NEActionTextLineStart;
    self.config.actionTextPosition = NEActionTextLineEnd;

    [self.view addSubview:self.textPackAndExpendView];
    [_textPackAndExpendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    
    [self.textPackAndExpendView updateTextView];
}

#pragma mark --- NETextPackAndExpendViewDelegate
 
- (void)updateSelfHeight:(CGFloat)height {
    NSLog(@"========+++++%lf",height);
    [_textPackAndExpendView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}

- (void)showContentInputView {
    
    
}
#pragma mark --- getter
- (NETextPackAndExpendView*)textPackAndExpendView {
    if (!_textPackAndExpendView) {
        CGFloat width = CGRectGetWidth(self.view.frame) - 30; //CGRectGetWidth([UIScreen mainScreen].bounds);
        _textPackAndExpendView = [[NETextPackAndExpendView alloc]initWithFrame:CGRectMake(0, 0, width, 0) textPackAndExpendConfig:self.config];
        _textPackAndExpendView.delegate = self;
        _textPackAndExpendView.backgroundColor = [UIColor redColor];
    }
    return _textPackAndExpendView;
}
@end
