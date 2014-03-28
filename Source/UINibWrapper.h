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

#import <UIKit/UIKit.h>

/**
 * UINibWrapper allows you to nest nib files inside other nib files.
 *
 * To use UINibWrapper you must:
 *   1. In your parent nib file you must add a blank UIView and change the class type to UINibWrapper.
 *   2. In the "User Defined Runtime Attributes" tab, add an entry for the keyPath "nibName" of type String with the name of your view nib file.
 *   3. If you, optionally, have created a subview class, your subclass name must have the same name as your nested nib file name.
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
