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
@property (nonatomic,strong) UILabel * textLabel;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.config = [[NETextPackAndExpendConfig alloc] init];
    self.config.textString = @"当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群123 多群问价哈哈哈哈哈当前的群无多群无多群无多群 多群问价哈哈哈哈哈当前的群无多群无多群无多群123当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当前的群123 多群问价哈哈哈哈哈当前的群无多群无多群无多群 多群问价哈哈哈哈哈当前的群无多群无多群无多群123";
    
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
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textPackAndExpendView.mas_bottom).offset(100);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [self textAction];
    
}
-(void)textAction{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        //调整行间距
    paragraphStyle.lineSpacing = 0;
    paragraphStyle.minimumLineHeight = 20.0;
    paragraphStyle.maximumLineHeight = 20.0;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:self.config.font};
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]initWithString:self.config.textString attributes:attriDict];
    self.textLabel.attributedText = [attributedText copy];
    [self.textLabel sizeToFit];
    
    NSLog(@"====Height=+++====%lf",CGRectGetHeight(self.textLabel.frame));
    
    
    CGFloat Height = [self getLabelHeight:CGRectGetWidth([UIScreen mainScreen].bounds)-30
                                     text:self.config.textString
                                     font:self.config.font];
    
    NSLog(@"=========%lf",Height);
}

- (CGFloat)getLabelHeight:(CGFloat)width text:(NSString *)text font:(UIFont*)font
{
    CGSize fitLabelSize = CGSizeMake(width, MAXFLOAT);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 0;
    paragraphStyle.minimumLineHeight = 20.0;
    paragraphStyle.maximumLineHeight = 20.0;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [text boundingRectWithSize:fitLabelSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    size.height = ceil(size.height);
    return size.height;
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
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 30;
        _textPackAndExpendView = [[NETextPackAndExpendView alloc]initWithFrame:CGRectMake(0, 0, width, 0) textPackAndExpendConfig:self.config];
        _textPackAndExpendView.delegate = self;
    }
    return _textPackAndExpendView;
}
#pragma mark --- Getters
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth([UIScreen mainScreen].bounds)-30,MAXFLOAT)];
        _textLabel.numberOfLines = 0;
        _textLabel.backgroundColor = [UIColor redColor];
        _textLabel.userInteractionEnabled = YES;
        _textLabel.font = self.config.font;
        _textLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:_textLabel];
    }
    return _textLabel;
}

@end
