//
//  ViewController.h
//  JFKit-master
//
//  Created by Jeffrey on 2018/9/12.
//  Copyright © 2018 Jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JFNetManager;

@protocol ControllerProtocol
@required
- (void)setupUI;

- (void)registerNotificaion;
@end

@interface ViewController : UIViewController


@end
