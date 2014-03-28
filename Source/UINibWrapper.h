//
//  UINibWrapper.h
//
//  Created by Joan Martin on 27/03/14.
//  Copyright (c) 2014 MobileJazz. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * UINibWrapper allows you to nest nib files inside other nib files.
 *
 * To use UINibWrapper you must:
 *   1. In your parent nib file you must add a blank UIView and change the class type to UINibWrapper.
 *   2. In the "User Defined Runtime Attributes" tab, add an entry for the keyPath "className" of type String with the name of your view class.
 *   3. The nib file of your nested view needs to have the same name as the view class name.
 *
 * And voilà, you are nesting nib files inside other nib files! Then, you can use the method "-contentView" to retrieve the nested view instance.
 *
 * @discussion By using UINibWrapper, you are adding an extra UIView in your nested views (the UINibWrapper itself).
 **/
@interface UINibWrapper : UIView

/**
 * The name of the class of the nested view (same as the name of the nib file).
 * @discussion You must assing this property in the "User Defined Runtime Attributes" in Interface Builder.
 **/
@property (nonatomic, strong) NSString *nibName;

/**
 * Returns the instance of the nested view.
 **/
- (id)contentView;

@end
