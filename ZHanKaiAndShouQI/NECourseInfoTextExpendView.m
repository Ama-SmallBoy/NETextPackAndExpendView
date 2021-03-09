//
//  NETextPackAndExpendView.m
//  NETeacherEmbeddedSDK
//
//  Created by Xdf on 2021/2/22.

#import "NECourseInfoTextExpendView.h"
#import "Masonry.h"
#import "TextEpendMacro.h"

@interface NECourseInfoTextExpendView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *actionBtn;
@property (nonatomic, strong) NECourseInfoTextExpendConfig *textConfig;

@end

static CGFloat const kShowTotalButtonMaxHeight = 5*20.0;
static CGFloat const kTotalButtonHeight = 20;
static CGFloat const kTotalButtonTopSpace = 6.0;
static CGFloat const kMinimumLineHeight = 20;
static CGFloat const kMaximumLineHeight = 20;

static CGFloat const kEdgeTopHeight = 20.0;//上边距
static CGFloat const kEdgeBottomHeight = 12.0;//下边距
static CGFloat const kEdgeLeftHeight = 16.0;//左边距
static CGFloat const kEdgeRightHeight = 24.0;//右边距

@implementation NECourseInfoTextExpendConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig {
    self.defaultTextString = @"默认信息可以自定义处理";
    self.textString = @"默认信息可以自定义处理";
    self.font = NEFontPFRegular(14.0);
    self.textColor = RGBColor(0x333333);
    self.actionTextColor = RGBColor(0x1FB895);
    self.titleExpend = @"全文";
    self.titlePack = @"收起";
}

@end

@implementation NECourseInfoTextExpendView

- (instancetype)initWithCourseInfoTextExpendConfig:(NECourseInfoTextExpendConfig *)courseInfoTextExpendConfig {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textConfig = courseInfoTextExpendConfig;
        [self addSubViews];
        [self layoutContentView];
        [self addGestureRecognizerAction];
    }
    return self;
}

- (void)addGestureRecognizerAction {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didShowAction:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)addSubViews {
    [self addSubview:self.textLabel];
    [self addSubview:self.actionBtn];
}

- (void)layoutContentView {
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kEdgeLeftHeight);
        make.bottom.mas_equalTo(self).offset(-kEdgeBottomHeight);
        make.height.mas_equalTo(0);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kEdgeLeftHeight);
        make.right.mas_equalTo(self).offset(-kEdgeRightHeight);
        make.bottom.mas_equalTo(self.actionBtn.mas_top).offset(-kTotalButtonTopSpace).priorityHigh();
        make.top.mas_equalTo(self).offset(kEdgeTopHeight);
    }];
}

#pragma mark --- 设置Text
- (void)setUpCourseInfoText {
    self.textConfig.textColor = [self.textConfig.defaultTextString isEqualToString:self.textConfig.textString] ? RGBColor(0x999999) : RGBColor(0x333333);
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.textConfig.textString attributes:[self fetchAttributes]];
    self.textLabel.attributedText = [attributedText copy];
    
    BOOL isShowButton = [self isShowExpendButton];
    self.actionBtn.hidden = !isShowButton;
    [self relayoutUIWithButtonHiddenStatus:!isShowButton];
}

- (void)relayoutUIWithButtonHiddenStatus:(BOOL)buttonHidden {
    if (buttonHidden) {
        [self.actionBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        CGFloat textHeight = [self fetchTextHeight];
        [self.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(textHeight);
            make.bottom.mas_equalTo(self.actionBtn.mas_top).priorityHigh();
        }];
    } else {
        [self.actionBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kTotalButtonHeight);
        }];
        CGFloat height = self.actionBtn.isSelected ? [self fetchTextHeight] : kShowTotalButtonMaxHeight;
        [self.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
            make.bottom.mas_equalTo(self.actionBtn.mas_top).offset(-kTotalButtonTopSpace).priorityHigh();
        }];
    }
}

//是否需要展示 全部按钮
- (BOOL)isShowExpendButton {
    return [self fetchTextHeight] > kShowTotalButtonMaxHeight;
}

//展示 收起
- (void)updateFrameInActionTextLineStartPattern:(BOOL)isExpand {
    CGFloat height = 0;
    if (isExpand) {
        _textLabel.numberOfLines = 0;
        height = [self fetchTextHeight];
    } else {
        _textLabel.numberOfLines = 5;
        height = [self isShowExpendButton] ? kShowTotalButtonMaxHeight : [self fetchTextHeight] ;
    }
    
    [self.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    if ([self.delegate respondsToSelector:@selector(didClickTotalButtonInCourseInfoTextExpendView)]) {
        [self.delegate didClickTotalButtonInCourseInfoTextExpendView];
    }
}

//获取行高
- (CGFloat)fetchTextHeight {
    CGFloat width = NEScreenCurrentWidth - kEdgeLeftHeight - kEdgeRightHeight;
    return [self getTextHeight:width];
}

#pragma mark --- Getters
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 5;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = self.textConfig.font;
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _textLabel;
}

- (void)didShowAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(didTapCourseInfoTextExpendView)]) {
        [self.delegate didTapCourseInfoTextExpendView];
    }
}

- (UIButton *)actionBtn {
    if (!_actionBtn) {
        _actionBtn = [[UIButton alloc] init];
        [_actionBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_actionBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_actionBtn setTitleColor:RGBColor(0x1FB895) forState:UIControlStateNormal];
        _actionBtn.selected = NO;
        _actionBtn.titleLabel.font = NEFontPFRegular(14);
        _actionBtn.backgroundColor = [UIColor clearColor];
        [_actionBtn addTarget:self  action:@selector(didActionShow:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn;
}

- (void)didActionShow:(UIButton *)actionButton {
    [self updateFrameInActionTextLineStartPattern:!actionButton.selected];
    actionButton.selected = !actionButton.selected;
}

- (CGFloat)getTextHeight:(CGFloat)width {
    CGSize fitLabelSize = CGSizeMake(width, MAXFLOAT);
    NSDictionary *attriDict = [self fetchAttributes];
    CGSize size = [self.textConfig.textString boundingRectWithSize:fitLabelSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attriDict context:nil].size;
    size.height = ceil(size.height);
    return size.height;
}

- (NSDictionary *)fetchAttributes {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.minimumLineHeight = kMinimumLineHeight;
    paragraphStyle.maximumLineHeight = kMaximumLineHeight;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attriDict = @{
        NSParagraphStyleAttributeName:paragraphStyle,
        NSFontAttributeName:self.textConfig.font,
        NSForegroundColorAttributeName:self.textConfig.textColor,
    };
    return attriDict;
}

@end
