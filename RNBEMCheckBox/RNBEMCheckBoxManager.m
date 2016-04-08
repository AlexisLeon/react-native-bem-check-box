#import "BEMCheckBox.h"
#import "RNBEMCheckBoxManager.h"

#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "UIView+React.h"
#import "RCTConvert.h"

@implementation RCTConvert (BEMCheckBox)

RCT_ENUM_CONVERTER(BEMBoxType, (@{
    @"circle": @(BEMBoxTypeCircle),
    @"square": @(BEMBoxTypeSquare),
}), BEMBoxTypeCircle, integerValue);


RCT_ENUM_CONVERTER(BEMAnimationType, (@{
    @"stroke": @(BEMAnimationTypeStroke),
    @"fill": @(BEMAnimationTypeFill),
    @"bounce": @(BEMAnimationTypeBounce),
    @"flat": @(BEMAnimationTypeFlat),
    @"one-stroke": @(BEMAnimationTypeOneStroke),
    @"fade": @(BEMAnimationTypeFade),
}), BEMAnimationTypeStroke, integerValue);

@end

@interface RNBEMCheckBoxManager() <BEMCheckBoxDelegate>
@end

@implementation RNBEMCheckBoxManager {
    BEMCheckBox *_checkBox;
}

RCT_EXPORT_MODULE();

- (UIView *)view
{
    _checkBox = [BEMCheckBox new];
    _checkBox.delegate = self;
    return _checkBox;
}

- (void)reactSetFrame:(CGRect)frame
{
    [_checkBox setFrame:frame];
}

#pragma mark BEMCheckBoxDelegate
- (void)didTapCheckBox:(BEMCheckBox*)sender {
    NSDictionary *event = @{
        @"target": sender.reactTag,
        @"value": @(sender.on),
        @"name": @"tap",
    };
    [self.bridge.eventDispatcher sendInputEventWithName:@"topChange" body:event];
}

- (void)animationDidStopForCheckBox:(BEMCheckBox *)sender {
    NSDictionary *event = @{
        @"target": sender.reactTag,
        @"value": @(sender.on),
        @"name": @"animation",
    };
    [self.bridge.eventDispatcher sendInputEventWithName:@"topChange" body:event];
}

RCT_REMAP_VIEW_PROPERTY(value, on, BOOL);

RCT_EXPORT_VIEW_PROPERTY(lineWidth, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(hideBox, BOOL);
RCT_REMAP_VIEW_PROPERTY(boxType, boxType, BEMBoxType);
RCT_EXPORT_VIEW_PROPERTY(tintColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(onCheckColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(onFillColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(onTintColor, UIColor);

RCT_EXPORT_VIEW_PROPERTY(animationDuration, CGFloat);
RCT_REMAP_VIEW_PROPERTY(onAnimationType, onAnimationType, BEMAnimationType);
RCT_REMAP_VIEW_PROPERTY(offAnimationType, offAnimationType, BEMAnimationType);

@end