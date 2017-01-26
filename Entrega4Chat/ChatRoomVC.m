//
//  pag2VC.m
//  Entrega4Chat
//
//  Created by dedam on 25/1/17.
//  Copyright © 2017 dedam. All rights reserved.
//

#import "ChatRoomVC.h"

@interface ChatRoomVC ()

@end

@implementation ChatRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //cargamos datos del VC anterior
    _tituloChat.text=_userChat;
    [_userImg initWithImage:_imageChat];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatData* chatData = m_aMessages[indexPath.row];
    switch (chatData.m_eChatDataType) {
        case ChatData_Message:
        {
            if (chatData.m_bIsMine) {
                return [self tableView_MyMessage:tableView cellForRowAtIndexPath:indexPath];
            }else{
                return [self tableView_OtherMessage:tableView cellForRowAtIndexPath:indexPath];
            }
        }
            break;
        case ChatData_Image:
        {
            if (chatData.m_bIsMine) {
                return [self tableView_MyImage:tableView cellForRowAtIndexPath:indexPath];
            }else{
                return [self tableView_OtherImage:tableView cellForRowAtIndexPath:indexPath];
            }
        }
            break;
        case ChatData_None:
            NSLog(@"Error_ChatRoom:tableView--> chatData with ChatData_None value");
            return nil;
        default:
            break;
    }
    return nil;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
