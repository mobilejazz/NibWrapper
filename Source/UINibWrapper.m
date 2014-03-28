//
//  UINibWrapper.m
//
//  Created by Joan Martin on 27/03/14.
//  Copyright (c) 2014 MobileJazz. All rights reserved.
//

#import "UINibWrapper.h"

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

@end

#pragma mark -
@implementation UIView (UINibWrapper)

+ (instancetype)nwp_instanceFromNibName:(NSString*)nibName
{
    NSString *className = NSStringFromClass(self);
    
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    
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
