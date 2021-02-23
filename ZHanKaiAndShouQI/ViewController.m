//
//  ViewController.m
//  ZHanKaiAndShouQI
//
//  Created by Xdf on 2021/2/21.
//

#import "ViewController.h"
#import <YYKit/YYKit.h>
#import <YYKit/YYTextAttribute.h>
#import "NSAttributedString+YYText.h"
#import <Masonry.h>
#import "TestViewController.h"

@interface ViewController ()
@property(nonatomic,strong) YYLabel * tokenLabel;
@property(nonatomic,strong) YYLabel * label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.view addSubview:self.tokenLabel];
//    UIView * label = [[UIView alloc] init];
//    [self.view addSubview:label];
//
//    [self.tokenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).offset(20);
//        make.right.mas_equalTo(self.view).offset(-20);
//        make.top.mas_equalTo(@(100));
//    }];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).offset(20);
//        make.right.mas_equalTo(self.view).offset(-20);
//        make.top.mas_equalTo(self.tokenLabel.mas_bottom).offset(10);
//        make.bottom.mas_equalTo(self.view);
//    }];
//
//
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:16];
     
    // 添加文本
    //NSString *title = @"当前的群无多群无多群无多群问价哈哈哈哈哈";
    NSString *title = @"当前的群无多群无多群无多群问价哈哈哈哈哈当前的群无多群无多群无多群问价哈哈哈哈哈当群问价哈哈哈哈哈当";
     
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
     
    text.font = font ;
    _label = [YYLabel new];
    _label.userInteractionEnabled = YES;
    _label.numberOfLines = 3;
    _label.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _label.frame = CGRectMake(40,100, self.view.frame.size.width-80,160);
    _label.attributedText = text;
    [self.view addSubview:_label];
    
    [_label sizeToFit];
    //NSLog(@"=============%lu",(unsigned long)self.label.textLayout.rowCount);
     
    _label.layer.borderWidth = 0.5;
    _label.layer.borderColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:1.000].CGColor;
     
    // 添加全文
    [self addSeeMoreButton];
    
    
    
}

- (YYLabel *)tokenLabel {
    if (!_tokenLabel) {
        _tokenLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _tokenLabel.numberOfLines = 0;
        _tokenLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.75];
        [self addSeeMoreButtonInLabel:_tokenLabel];
    }
    
    return _tokenLabel;
}

- (void)addSeeMoreButtonInLabel:(YYLabel *)label {
    UIFont *font16 = [UIFont systemFontOfSize:16];
    NSString * textString = @"我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天 收起 天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输,我是一名少先队员。。。好好学习天天向上，努力向前，不怕不怕不怕输!";
    label.attributedText = [[NSAttributedString alloc] initWithString:textString attributes:@{NSFontAttributeName : font16}];

    NSString *moreString = @"展开";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"... %@", moreString]];
    NSRange expandRange = [text.string rangeOfString:moreString];
    
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:expandRange];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0, expandRange.location)];
    
    //添加点击事件
    YYTextHighlight *hi = [YYTextHighlight new];
    [text setTextHighlight:hi range:[text.string rangeOfString:moreString]];
   
    
    __weak typeof(self) weakSelf = self;
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击展开
        [weakSelf setFrame:YES];
    };
    
    text.font = font16;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.font alignment:YYTextVerticalAlignmentTop];
    
    label.truncationToken = truncationToken;
}

- (NSAttributedString *)appendAttriStringWithFont:(UIFont *)font {
    if (!font) {
        font = [UIFont systemFontOfSize:16];
    }
    
    NSString *appendText = @"\n收起 ";
    NSMutableAttributedString *append = [[NSMutableAttributedString alloc] initWithString:appendText attributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : [UIColor blueColor]}];
    
    YYTextHighlight *hi = [YYTextHighlight new];
    [append setTextHighlight:hi range:[append.string rangeOfString:appendText]];
    
    __weak typeof(self) weakSelf = self;
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击收起
        //[weakSelf setFrame:NO];
        [weakSelf packUpString];
        weakSelf.label.numberOfLines = 3;
        [weakSelf.label sizeToFit];
       // NSLog(@"==============%lf",weakSelf.label.frame.size.height);
    };
    
    return append;
}

- (void)expandString {
    NSMutableAttributedString *attri = [self.label.attributedText mutableCopy];
    [attri appendAttributedString:[self appendAttriStringWithFont:attri.font]];
    self.label.attributedText = attri;
}

- (void)packUpString {
    NSString *appendText = @"\n收起 ";
    NSMutableAttributedString *attri = [_label.attributedText mutableCopy];
    NSRange range = [attri.string rangeOfString:appendText options:NSBackwardsSearch];

    if (range.location != NSNotFound) {
        [attri deleteCharactersInRange:range];
    }

    _label.attributedText = attri;
}


- (void)setFrame:(BOOL)isExpand {
    if (isExpand) {
        [self expandString];
        self.tokenLabel.numberOfLines = 0;
    }
    else {
        [self packUpString];
        self.tokenLabel.numberOfLines = 3;
    }
    //[_tokenLabel sizeToFit];
}
#pragma mark - 添加全文
- (void)addSeeMoreButton {
     
    __weak __typeof(self) weakSelf = self;
     
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...全文"];
 
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
     
    hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) {
        // 点击全文回调
        YYLabel *label = weakSelf.label;
        [weakSelf expandString];
        label.numberOfLines = 0;
        [label sizeToFit];
       // NSLog(@"==============%lf",label.frame.size.height);
    };
     
 
    [text setColor:[UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000] range:[text.string rangeOfString:@"全文"]];
    [text setTextHighlight:hi range:[text.string rangeOfString:@"全文"]];
    text.font = _label.font;
     
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
     
    NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.font alignment:YYTextVerticalAlignmentCenter];
     
    _label.truncationToken = truncationToken;
}
 
- (IBAction)pushVCAction:(UIButton *)sender {
    [self.navigationController pushViewController:[TestViewController new] animated:YES];
    
}

@end
