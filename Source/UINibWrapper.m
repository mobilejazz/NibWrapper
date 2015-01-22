// Copyright 2014 MobileJazz S.L.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "UINibWrapper.h"

@interface NibFileCacher : NSObject

+ (NibFileCacher *)sharedInstance;
- (UINib *)nibWithName:(NSString *)name;

@property (nonatomic) dispatch_semaphore_t cacheAccessSemaphore;
@property (nonatomic, strong) NSMutableDictionary *cachedNib;

@end

@implementation NibFileCacher

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id instance = nil;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cachedNib = [[NSMutableDictionary alloc] init];
        self.cacheAccessSemaphore = NULL;
        self.cacheAccessSemaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)dealloc
{
    if (self.cacheAccessSemaphore != NULL) {
        dispatch_release(self.cacheAccessSemaphore);
    }
}

- (UINib *)nibWithName:(NSString *)name
{
    dispatch_semaphore_wait(self.cacheAccessSemaphore, DISPATCH_TIME_FOREVER);
    UINib *nib = nil;
    nib = self.cachedNib[name];
    if (!nib) {
        nib = [UINib nibWithNibName:name bundle:nil];
        self.cachedNib[name] = nib;
    }
    dispatch_semaphore_signal(self.cacheAccessSemaphore);
    return nib;
}

@end

#pragma mark - 
/**
 * Private category on UIView to be used by the UINibWrapper.
 **/
@interface UIView (UINibWrapper)

/**
 * Attempts to create a new instance of the current view from a NIB with named with the class name.
 **/
+ (instancetype)nwp_instanceFromNibName:(NSString*)nibName;

@end

#pragma mark -
@implementation UINibWrapper

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    Class viewClass = NSClassFromString(_nibName);
    
    if (!viewClass)
        viewClass = UIView.class;
    
    UIView *view = [viewClass nwp_instanceFromNibName:_nibName];
    
    if (view)
    {
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addSubview:view];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
        [self layoutIfNeeded];
    }
}

- (id)contentView
{
    return self.subviews.firstObject;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self.contentView isUserInteractionEnabled])
        return [self.contentView pointInside:point withEvent:event];
    else
        return NO;
}

@end

#pragma mark -
@implementation UIView (UINibWrapper)

+ (instancetype)nwp_instanceFromNibName:(NSString*)nibName
{
    NSString *className = NSStringFromClass(self);
    
    UINib *nib = [[NibFileCacher sharedInstance] nibWithName:nibName];
    
    if (!nib)
    {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException
                                                         reason:[NSString stringWithFormat:@"NibWrapper could not find nib file %@", nibName]
                                                       userInfo:nil];
        [exception raise];
    }
    
    NSArray *array = [nib instantiateWithOwner:nil options:nil];
    
    if (array.count != 1)
    {
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException
                                                         reason:[NSString stringWithFormat:@"NibWrapper found more than one view in nib file %@", className]
                                                       userInfo:nil];
        [exception raise];
    }
    
    return array.lastObject;
}


@end