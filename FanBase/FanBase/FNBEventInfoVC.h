//
//  FNBEventInfoVC.h
//  FanBase
//
//  Created by Angelica Bato on 4/7/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FNBArtistEvent.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"



@interface FNBEventInfoVC : UIViewController

@property (strong, nonatomic) FNBArtistEvent *event;

@end
