//
//  PViCadeReader.m
//  Provenance
//
//  Created by Josejulio Martínez on 19/06/15.
//  Copyright (c) 2015 James Addyman. All rights reserved.
//

#import "PViCadeReader.h"
#import "iCadeReaderView.h"

static PViCadeReader* sharedReader = nil;

@implementation PViCadeReader

+(PViCadeReader*) sharedReader {
    if (!sharedReader) {
        sharedReader = [[PViCadeReader alloc] init];
    }
    return sharedReader;
}

-(instancetype) init {
    if (self = [super init]) {
        _internalReader = [[iCadeReaderView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

-(void) listenToKeyWindow {
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    if (keyWindow != _internalReader.window) {
        [_internalReader removeFromSuperview];
        [keyWindow addSubview:_internalReader];
    }
    _internalReader.active = YES;
    _internalReader.delegate = self;
}

-(iCadeState) state {
    return _internalReader.iCadeState;
}

#pragma mark - iCadeEventDelegate

- (void)stateChanged:(iCadeState)state {
    if (self.stateChanged) {
        self.stateChanged(state);
    }
}

- (void)buttonDown:(iCadeState)button {
    if (self.buttonDown) {
        self.buttonDown(button);
    }
}

- (void)buttonUp:(iCadeState)button {
    if (self.buttonUp) {
        self.buttonUp(button);
    }
}

@end
