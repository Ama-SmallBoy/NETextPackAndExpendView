//
//  TextEpendMacro.h
//  ZHanKaiAndShouQI
//
//  Created by zhanggaotong on 2021/3/9.
//

#ifndef TextEpendMacro_h
#define TextEpendMacro_h
#import "UIColor+YYAdd.h"

#ifndef NEScreenCurrentWidth
    #define NEScreenCurrentWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
    #define NEScreenCurrentHeight CGRectGetHeight([UIScreen mainScreen].bounds)
    #define NEScreenNaturalWidth  MIN(NEScreenCurrentWidth, NEScreenCurrentHeight)
    #define NEScreenNaturalHeight MAX(NEScreenCurrentWidth, NEScreenCurrentHeight)
#endif

#ifndef RGBColor
    #define RGBColor(_hex_) UIColorHex(_hex_)
    #define RGBAColor(_hex_, _alpha_) [UIColor colorWithRGB:_hex_ alpha:_alpha_]
#endif

// 苹方 常规
#define _NEFontPFRegular(_fontSize_)        [UIFont systemFontOfSize:_fontSize_ weight:UIFontWeightLight]//[UIFont fontWithName:@"PingFangSC-Regular" size:_fontSize_]
// 苹方-简 中粗体
#define _NEFontPFMediumBold(_fontSize_)     [UIFont fontWithName:@"PingFangSC-Semibold" size:_fontSize_]
// 苹方 中等
#define _NEFontPFMedium(_fontSize_)         [UIFont systemFontOfSize:_fontSize_ weight:UIFontWeightRegular]//[UIFont fontWithName:@"PingFangSC-Medium" size:_fontSize_]
// 苹方 粗
#define _NEFontPFBold(_fontSize_)           [UIFont systemFontOfSize:_fontSize_ weight:UIFontWeightBold]//[UIFont fontWithName:@"PingFang-SC-Bold" size:_fontSize_]
// 苹方 特粗
#define _NEFontPFHeavy(_fontSize_)          [UIFont fontWithName:@"PingFang-SC-Heavy" size:_fontSize_]

// SF UI Display Regular
#define _NEFontSFRegular(_fontSize_)        [UIFont fontWithName:@"SFUIDisplay-Regular" size:_fontSize_]
// SF UI Display Medium
#define _NEFontSFMedium(_fontSize_)         [UIFont fontWithName:@"SFUIDisplay-Medium" size:_fontSize_]
// SFUIDisplay-Semibold
#define _NEFontSFMediumBold(_fontSize_)     [UIFont fontWithName:@"SFUIDisplay-Semibold" size:_fontSize_]
// SFUIDisplay-Bold
#define _NEFontSFBold(_fontSize_)           [UIFont fontWithName:@"SFUIDisplay-Bold" size:_fontSize_]
// SFUIDisplay-Black
#define _NEFontSFBlack(_fontSize_)          [UIFont fontWithName:@"SFUIDisplay-Black" size:_fontSize_]

// 苹方 常规
#define NEFontPFRegular(_fontSize_)     \
    _NEFontPFRegular(_fontSize_) ?: [UIFont systemFontOfSize:_fontSize_]
// 苹方-简 中粗体
//#define NEFontPFMediumBold(_fontSize_)  \
    _NEFontPFMediumBold(_fontSize_) ?: [UIFont boldSystemFontOfSize:_fontSize_]
// 苹方 中等
#define NEFontPFMedium(_fontSize_)      \
    _NEFontPFMedium(_fontSize_) ?: [UIFont systemFontOfSize:_fontSize_]
// 苹方 特等
//#define NEFontPFHeavy(_fontSize_)      \
_NEFontPFHeavy(_fontSize_) ?: [UIFont systemFontOfSize:_fontSize_]

// 苹方 粗
#define NEFontPFBold(_fontSize_)      \
_NEFontPFBold(_fontSize_) ?: [UIFont systemFontOfSize:_fontSize_]

// SF UI Display Regular
#define NEFontSFRegular(_fontSize_)      \
_NEFontSFRegular(_fontSize_) ?: [UIFont systemFontOfSize:_fontSize_]
// SF UI Display Medium
#define NEFontSFMedium(_fontSize_)      \
    _NEFontSFMedium(_fontSize_) ?: [UIFont systemFontOfSize:_fontSize_]
// SFUIDisplay-Semibold
#define NEFontSFMediumBold(_fontSize_)  \
    _NEFontSFMediumBold(_fontSize_) ?: [UIFont systemFontOfSize:_fontSize_]
// SFUIDisplay-Bold
#define NEFontSFBold(_fontSize_)        \
    _NEFontSFBold(_fontSize_) ?: [UIFont boldSystemFontOfSize:_fontSize_]
// SFUIDisplay-Black
#define NEFontSFBlack(_fontSize_)       \
_NEFontSFBlack(_fontSize_) ?: [UIFont boldSystemFontOfSize:_fontSize_]






#endif /* TextEpendMacro_h */
