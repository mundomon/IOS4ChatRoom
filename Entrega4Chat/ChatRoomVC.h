//
//  ChatRoomVC.h
//  Entrega4Chat
//
//  Created by dedam on 25/1/17.
//  Copyright © 2017 dedam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatRoomVC : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *tituloChat;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property(strong,nonatomic)NSString *userChat;
@property(strong,nonatomic)UIImage *imageChat;
@property (strong, nonatomic) IBOutlet UIImageView *userImg;

@end
