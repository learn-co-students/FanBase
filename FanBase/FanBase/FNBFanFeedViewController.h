//
//  FNBFanFeedViewController.h
//  FanBase
//
//  Created by Angelica Bato on 4/11/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

#import <JSQMessagesViewController/JSQMessagesViewController.h>
#import <JSQMessagesBubbleImage.h>
#import <JSQMessagesAvatarImage.h>
#import <JSQMessagesBubbleImageFactory.h>
#import <JSQMessagesAvatarImageFactory.h>
#import <UIColor+JSQMessages.h>
#import <JSQMessage.h>
#import <Firebase/Firebase.h>
#import <JSQSystemSoundPlayer/JSQSystemSoundPlayer.h>
#import <JSQMessageAvatarImageDataSource.h>
#import <JSQMessagesCollectionViewFlowLayout.h>
#import <UIImage+AFNetworking.h>
#import "FNBFirebaseClient.h"
#import "FNBArtist.h"
#import "Secrets.h"
#import "FNBUser.h"
#import "FanBase-Bridging-Header.h"
#import "Fanbase-Swift.h"


@interface FNBFanFeedViewController : JSQMessagesViewController 

@property (strong, nonatomic) NSString *senderId;
@property (strong, nonatomic) NSString *senderDisplayName;
@property (strong, nonatomic) UIImage *senderAvatar;
@property (strong, nonatomic) FNBArtist *artist;
@property (strong, nonatomic) FNBUser *user;

@property (strong,nonatomic) SideBar *sideBar;


@end
