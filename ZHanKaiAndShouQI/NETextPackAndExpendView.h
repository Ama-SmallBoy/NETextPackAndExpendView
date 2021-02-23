//
//  NETextPackAndExpendView.h
//  ZHanKaiAndShouQI
//
//  Created by Xdf on 2021/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    NEActionTextLineEnd, //文本末尾显示 ActionButton
    NEActionTextLineStart,//另一行 行首 ActionButton
} NEActionTextPosition;

@protocol  NETextPackAndExpendViewDelegate <NSObject>

- (void)updateSelfHeight:(CGFloat)height;
- (void)showContentInputView;

@end

@interface NETextPackAndExpendConfig :NSObject
@property (nonatomic, copy) NSString * defaultTextString;
@property (nonatomic, copy) NSString * textString;
@property (nonatomic, assign) NSInteger maxLine;
@property (nonatomic, strong) UIFont * font;
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic,assign) NEActionTextPosition actionTextPosition;
@property (nonatomic, assign) BOOL isOpenNormalTextAction;// 是否为正常文字设置点击事件
@property (nonatomic, strong) UIColor * actionTextColor;//全部  和 收起

#pragma mark -- NEActionTextLineStart

@property (nonatomic, strong) NSString * titleExpend;//全部
@property (nonatomic, strong) NSString * titlePack;//收起

@end

@interface NETextPackAndExpendView : UIView

@property (nonatomic,weak) id <NETextPackAndExpendViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame textPackAndExpendConfig:(NETextPackAndExpendConfig*)textPackAndExpendConfig;
- (void)updateTextView;
@end

NS_ASSUME_NONNULL_END
