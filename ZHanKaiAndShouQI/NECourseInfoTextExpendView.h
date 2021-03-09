//
//  NETextPackAndExpendView.h
//  NETeacherEmbeddedSDK
//
//  Created by Xdf on 2021/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol NECourseInfoTextExpendViewDelegate <NSObject>

- (void)didClickTotalButtonInCourseInfoTextExpendView;
- (void)didTapCourseInfoTextExpendView;

@end

@interface NECourseInfoTextExpendConfig : NSObject

@property (nonatomic, copy) NSString *defaultTextString;
@property (nonatomic, copy) NSString *textString;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *actionTextColor;//全部  和 收起

@property (nonatomic, copy) NSString *titleExpend;//全部
@property (nonatomic, copy) NSString *titlePack;//收起

@end

@interface NECourseInfoTextExpendView : UIView

@property (nonatomic,weak) id<NECourseInfoTextExpendViewDelegate> delegate;

- (instancetype)initWithCourseInfoTextExpendConfig:(NECourseInfoTextExpendConfig *)courseInfoTextExpendConfig;
- (void)setUpCourseInfoText;

@end

NS_ASSUME_NONNULL_END
