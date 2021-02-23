//
//  NETextPackAndExpendView.m
//  ZHanKaiAndShouQI
//
//  Created by Xdf on 2021/2/22.





//1.判定是否小于5行 是 就直接不展示 全部的按钮
//2.判定是否等于5行 是 判定 range > visibleRange 是

#import "NETextPackAndExpendView.h"
#import <YYKit/YYKit.h>
#import "NSAttributedString+YYText.h"
#import <Masonry.h>
@interface NETextPackAndExpendView ()
@property (nonatomic, strong) YYLabel *textLabel;
@property (nonatomic, strong) UIButton *actionBtn;
@property (nonatomic, strong) NSMutableAttributedString *attributedText;
@property (nonatomic, strong) NETextPackAndExpendConfig *textPackAndExpendConfig;
@end
#define kActionButtonHeight 20
@implementation NETextPackAndExpendConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (void) defaultConfig{
    
    self.defaultTextString = @"默认信息可以自定义处理";
    self.textString = @"默认信息可以自定义处理";
    self.maxLine = 5;
    self.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    self.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.lineSpace = 5.0;
    self.actionTextPosition = NEActionTextLineStart;
    self.isOpenNormalTextAction = YES;
    self.actionTextColor = [UIColor colorWithRed:31/255.0 green:184/255.0 blue:149/255.0 alpha:1.0];
    
    #pragma mark -- NEActionTextLineStart
    self.titleExpend = @"全文";
    self.titlePack = @"收起";
    
}

@end

@implementation NETextPackAndExpendView
-(instancetype)initWithFrame:(CGRect)frame textPackAndExpendConfig:(NETextPackAndExpendConfig *)textPackAndExpendConfig{
    self = [super initWithFrame:frame];
    if (self) {
        self.textPackAndExpendConfig = textPackAndExpendConfig;
        [self layoutSubView];
    }
    return self;
}

- (void)layoutSubView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textLabel];
    [self addSubview:self.actionBtn];
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.actionBtn.mas_top);
        make.top.mas_equalTo(self);
    }];
}

- (void)updateTextView{
    
    self.textLabel.attributedText = self.attributedText;
    [self.textLabel sizeToFit];

    CGFloat extentHeight = 0;
    switch (self.textPackAndExpendConfig.actionTextPosition) {
        case NEActionTextLineEnd:
        {
            // 添加全文
            [self addSeeMoreButton];
            self.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            extentHeight = 0;
            self.actionBtn.hidden = YES;
        }
            break;
        case NEActionTextLineStart:
        {
            BOOL isShowButton = [self isShowExpendButtonInActionTextLineStartPattern];
            CGFloat height  = isShowButton ? kActionButtonHeight : 0;
            extentHeight = height;
            self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.actionBtn.hidden = NO;
            [self addSeeMoreButtonInActionTextLineStartPattern];
        }
            break;
            
        default:
            break;
    }
    if (self.textPackAndExpendConfig.isOpenNormalTextAction) {
        [self setNormalText:self.textPackAndExpendConfig.textString
                 normalFont:self.textPackAndExpendConfig.font
                normalColor:self.textPackAndExpendConfig.textColor
              highlightText:self.textPackAndExpendConfig.textString
             highlightColor:self.textPackAndExpendConfig.textColor
            highlightBColor:self.textPackAndExpendConfig.textColor];
    }
    //NSLog(@"============%lf",extentHeight);
    if ([self.delegate respondsToSelector:@selector(updateSelfHeight:)]) {
        [self.delegate updateSelfHeight:self.textLabel.frame.size.height + extentHeight];
    }
}

#pragma mark ------ NEActionTextLineEnd
#pragma mark - 添加全文
- (void)addSeeMoreButton {
    __weak __typeof(self) weakSelf = self;
    NSString * actionTitle = [NSString stringWithFormat:@"...%@",self.textPackAndExpendConfig.titleExpend];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:actionTitle];
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:self.textPackAndExpendConfig.textColor];
     
    hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) {
        // 点击全文回调
        [weakSelf updateFrameInNEActionTextLineEndPattern:YES];
    };
    
    [text setColor:self.textPackAndExpendConfig.actionTextColor range:[text.string rangeOfString:self.textPackAndExpendConfig.titleExpend]];
    [text setTextHighlight:hi range:[text.string rangeOfString:self.textPackAndExpendConfig.titleExpend]];
    text.font = _textLabel.font;
     
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
     
    NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.font alignment:YYTextVerticalAlignmentCenter];
    
    _textLabel.truncationToken = truncationToken;
}
#pragma mark - 添加收起

- (NSAttributedString *)appendAttriStringWithFont:(UIFont *)font {
    if (!font) {
        font = [UIFont systemFontOfSize:14.0];
    }
    NSString *appendText = [NSString stringWithFormat:@" %@ ",self.textPackAndExpendConfig.titlePack];
    NSMutableAttributedString *append = [[NSMutableAttributedString alloc] initWithString:appendText attributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : self.textPackAndExpendConfig.actionTextColor}];
    
    YYTextHighlight *hi = [YYTextHighlight new];
    [append setTextHighlight:hi range:[append.string rangeOfString:appendText]];
    
    __weak typeof(self) weakSelf = self;
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击收起
        [weakSelf updateFrameInNEActionTextLineEndPattern:NO];
    };
    return append;
}

- (void)expandString {
    NSMutableAttributedString *attri = [self.textLabel.attributedText mutableCopy];
    [attri appendAttributedString:[self appendAttriStringWithFont:attri.font]];
    self.textLabel.attributedText = attri;
}
- (void)packUpString {
    NSString *appendText = [NSString stringWithFormat:@" %@ ",self.textPackAndExpendConfig.titlePack];
    NSMutableAttributedString *attri = [self.textLabel.attributedText mutableCopy];
    NSRange range = [attri.string rangeOfString:appendText options:NSBackwardsSearch];

    if (range.location != NSNotFound) {
        [attri deleteCharactersInRange:range];
    }

    self.textLabel.attributedText = attri;
}
- (void)updateFrameInNEActionTextLineEndPattern:(BOOL)isExpand {
    if (isExpand) {
        [self expandString];
        self.textLabel.numberOfLines = 0;
    } else {
        [self packUpString];
        self.textLabel.numberOfLines = self.textPackAndExpendConfig.maxLine;
    }
    [self.textLabel sizeToFit];
    if ([self.delegate respondsToSelector:@selector(updateSelfHeight:)]) {
        [self.delegate updateSelfHeight:self.textLabel.frame.size.height];
    }
}
#pragma mark ------ NEActionTextLineStart
//1.在 头部添加模式下 ，是否需要展示 全部按钮
- (BOOL) isShowExpendButtonInActionTextLineStartPattern{
    if (self.textLabel.textLayout.rowCount < self.textPackAndExpendConfig.maxLine) {
        return NO;
    }else if (self.textLabel.textLayout.rowCount == self.textPackAndExpendConfig.maxLine){
        NSInteger rangeLen = self.textLabel.textLayout.range.length;
        NSInteger visibleRangeLen = self.textLabel.textLayout.visibleRange.length;
        return rangeLen > (visibleRangeLen);
    }else if (self.textLabel.textLayout.rowCount > self.textPackAndExpendConfig.maxLine){
        return YES;
    }else{
        return NO;
    }
}
//2.展示 收起
- (void)updateFrameInActionTextLineStartPattern:(BOOL)isExpand {

    if (isExpand) {
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    } else {
        self.textLabel.numberOfLines = self.textPackAndExpendConfig.maxLine;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    [self.textLabel sizeToFit];
    CGFloat height = [self isShowExpendButtonInActionTextLineStartPattern] ? (self.textLabel.frame.size.height+kActionButtonHeight) : self.textLabel.frame.size.height;
    if ([self.delegate respondsToSelector:@selector(updateSelfHeight:)]) {
        [self.delegate updateSelfHeight:height];
    }
}
//3.标注 单个 高亮 状态
-(void)setNormalText:(NSString *)normalText
          normalFont:(UIFont *)normalFont
         normalColor:(UIColor*)normalColor
       highlightText:(NSString *)highlightText
      highlightColor:(UIColor*)highlightColor
     highlightBColor:(UIColor*)highlightBColor{
    // 1. 创建属性字符串。
    NSRange range =[normalText rangeOfString:highlightText];
    @weakify(self)
    [self.attributedText setTextHighlightRange:range
                                      color:highlightColor
                            backgroundColor:highlightBColor
                                  tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        @strongify(self)
        if ([self.delegate respondsToSelector:@selector(showContentInputView)]) {
            [self.delegate showContentInputView];
        }
    }];
    self.textLabel.attributedText = self.attributedText;
    self.textLabel.textAlignment = NSTextAlignmentLeft;
}

- (void) addSeeMoreButtonInActionTextLineStartPattern {
    // 分行添加全文
    [self.actionBtn setTitle:self.textPackAndExpendConfig.titleExpend forState:UIControlStateNormal];
    [_actionBtn setTitle:self.textPackAndExpendConfig.titlePack forState:UIControlStateSelected];
    [_actionBtn setTitleColor:self.textPackAndExpendConfig.actionTextColor forState:UIControlStateNormal];
    [self addSubview:_actionBtn];
    BOOL isShowButton = [self isShowExpendButtonInActionTextLineStartPattern];
    CGFloat height  = isShowButton ? kActionButtonHeight : 0;
    self.actionBtn.hidden = !isShowButton;
    [self.actionBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}
#pragma mark --- Getters
- (YYLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[YYLabel alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.frame),MAXFLOAT)];
        _textLabel.numberOfLines = 5;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.userInteractionEnabled = YES;
        _textLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _textLabel.font = self.textPackAndExpendConfig.font;
        _textLabel.backgroundColor = [UIColor yellowColor];
    }
    return _textLabel;
}

-(NSMutableAttributedString *)attributedText{
    if (!_attributedText) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
          //调整行间距
        paragraphStyle.lineSpacing = self.textPackAndExpendConfig.lineSpace;
        NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle};
        _attributedText = [[NSMutableAttributedString alloc]initWithString:self.textPackAndExpendConfig.textString attributes:attriDict];
        _attributedText.font = self.textPackAndExpendConfig.font;
    }
    return _attributedText;
}
-(UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_actionBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_actionBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_actionBtn setTitleColor:[UIColor colorWithRed:31/255.0 green:184/255.0 blue:149/255.0 alpha:1.0] forState:UIControlStateNormal];
        _actionBtn.selected = NO;
        _actionBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _actionBtn.backgroundColor = [UIColor clearColor];
        [_actionBtn addTarget:self  action:@selector(didActionShow:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn;
}

-(void)didActionShow:(UIButton*)actionButton{
    [self updateFrameInActionTextLineStartPattern:!actionButton.selected];
    actionButton.selected = !actionButton.selected;
}
@end
