//
//  RNDeviceBrightness.m
//  RNDeviceBrightness
//
//  Created by Calvin on 3/11/17.
//  Copyright © 2017 CapsLock. All rights reserved.
//

#import "RNDeviceBrightness.h"

@implementation RNDeviceBrightness

RCT_EXPORT_MODULE()

void runOnMainQueueWithoutDeadlocking(void (^block)(void))
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

RCT_EXPORT_METHOD(setBrightnessLevel:(CGFloat) brightnessLevel)
{
    runOnMainQueueWithoutDeadlocking(^{
        CGFloat brightness = brightnessLevel;
        // Update the UI on the main thread.
        [[UIScreen mainScreen] setBrightness: brightness];
    });
}

RCT_REMAP_METHOD(getBrightnessLevel, getBrightnessLevel:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    __block float result = 0;
    result = [UIScreen mainScreen].brightness;
    resolve(@(result));
}

@end
