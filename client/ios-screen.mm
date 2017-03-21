#include "ios-screen.h"


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

void IosScreen::setTimerDisabled() {
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
}
