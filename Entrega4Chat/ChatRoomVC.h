//
//  ChatRoomVC.h
//  Entrega4Chat
//
//  Created by dedam on 25/1/17.
//  Copyright © 2017 dedam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatRoomVC : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *m_imgPicker;
    UIActionSheet *m_ActionSheet;
}
@property (strong, nonatomic) IBOutlet UILabel *tituloChat;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property(strong,nonatomic)NSString *userChat;
@property(strong,nonatomic)UIImage *imageChat;
@property (strong, nonatomic) IBOutlet UIImageView *userImg;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *viewToolBar;
@property (strong, nonatomic) IBOutlet UITextField *textField;



- (IBAction)btnFoto:(id)sender;
- (IBAction)btnEnviar:(id)sender;



@end
