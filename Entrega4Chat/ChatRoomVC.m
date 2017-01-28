//
//  pag2VC.m
//  Entrega4Chat
//
//  Created by dedam on 25/1/17.
//  Copyright © 2017 dedam. All rights reserved.
//

#import "ChatRoomVC.h"
#import "ChatData.h"
#import "Chat_Msg_Cell.h"
#import "Chat_MsgOthers_Cell.h"
#import "Chat_OtherImage_Cell.h"
#import "Chat_MyImage_Cell.h"

@interface ChatRoomVC ()
{
    NSMutableArray* m_aMessages;
}

@end

@implementation ChatRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //cargamos datos del VC anterior
    _tituloChat.text=_userChat;
    [_userImg initWithImage:_imageChat];
    
    //_tituloChat.numberOfLines=0;
    //[_tituloChat sizeToFit];
    _tableView.rowHeight=UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight=20;
    
    [self iniciarMensajes];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Funciones obligatorias del TableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return m_aMessages.count;
}

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

#pragma mark - Analisi Mensajes TableView

- (UITableViewCell *)tableView_MyMessage:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatData* chatData = m_aMessages[indexPath.row];
    NSString *CellType=@"Chat_Msg_Cell";
    
    
    Chat_Msg_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellType forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[Chat_Msg_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellType];
    }
    cell.txtMsg.text = chatData.m_sMessage;
    cell.txtMsg.numberOfLines=0;
    //[cell.txtMsg sizeToFit];
    //[cell.contentCell sizeToFit];
    
    
    return cell;
}

- (UITableViewCell *)tableView_OtherMessage:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatData* chatData = m_aMessages[indexPath.row];
    NSString *CellType=@"Chat_MsgOthers_Cell";
    
    Chat_MsgOthers_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellType forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[Chat_MsgOthers_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellType];
    }
    cell.txtMsg.text=chatData.m_sMessage;
    cell.txtMsg.numberOfLines=0;
    
    return cell;
}

- (UITableViewCell *)tableView_MyImage:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatData* chatData = m_aMessages[indexPath.row];
    NSString *CellType=@"Chat_MyImage_Cell";
    
    Chat_MyImage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellType forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[Chat_MyImage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellType];
    }
    cell.imgMsg.image=chatData.m_Image;
    
    return cell;
}

- (UITableViewCell *)tableView_OtherImage:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatData* chatData = m_aMessages[indexPath.row];
    NSString *CellType=@"Chat_OtherImage_Cell";
    
    Chat_OtherImage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellType forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[Chat_OtherImage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellType];
    }
    cell.imgMsg.image=chatData.m_Image;
    
    return cell;
}

#pragma mark - Iniciar Datos

-(void)iniciarMensajes{
    ChatData *m1 = [[ChatData alloc]init];
    m1.m_iVersion=1;
    m1.m_iID=1;
    m1.m_bIsMine=YES;
    m1.m_eChatDataType=0;
    m1.m_sMessage=@"mensaje del mon 1";
    //m1.m_Date=[NSDate init]; //fecha actual
    m1.m_Image=nil;
    
    ChatData *m2 = [[ChatData alloc]init];
    m2.m_iVersion=1;
    m2.m_iID=2;
    m2.m_bIsMine=NO;
    m2.m_eChatDataType=0;
    m2.m_sMessage=@"mensaje del mon 2 que tiene que ser muy largo y ocupar mas de una linea para poder ver si se alarga el frame ho non";
    //m2.m_Date=[NSDate init]; //fecha actual
    m2.m_Image=nil;
    
    ChatData *m3 = [[ChatData alloc]init];
    m3.m_iVersion=1;
    m3.m_iID=3;
    m3.m_bIsMine=YES;
    m3.m_eChatDataType=1;
    m3.m_sMessage=@"mensaje pal mon";
    //m3.m_Date=[NSDate init]; //fecha actual
    m3.m_Image=[UIImage imageNamed:@"avatar.png" ];
    
    ChatData *m4 = [[ChatData alloc]init];
    m4.m_iVersion=1;
    m4.m_iID=4;
    m4.m_bIsMine=NO;
    m4.m_eChatDataType=1;
    m4.m_sMessage=@"mensaje pal mon";
    //m4.m_Date=[NSDate init]; //fecha actual
    m4.m_Image=[UIImage imageNamed:@"company.png" ];
    
    ChatData *m5 = [[ChatData alloc]init];
    m5.m_iVersion=1;
    m5.m_iID=5;
    m5.m_bIsMine=YES;
    m5.m_eChatDataType=0;
    m5.m_sMessage=@"mensaje del mon 3 que tiene que ser muy largo y ocupar mas de una linea para poder ver si se alarga el frame ho no";
    //m1.m_Date=[NSDate init]; //fecha actual
    m5.m_Image=nil;
    
    m_aMessages = [[NSMutableArray alloc]init];
    [m_aMessages addObject:m1];
    [m_aMessages addObject:m2];
    [m_aMessages addObject:m3];
    [m_aMessages addObject:m4];
    [m_aMessages addObject:m1];
    [m_aMessages addObject:m2];
    [m_aMessages addObject:m3];
    [m_aMessages addObject:m4];
    [m_aMessages addObject:m1];
    [m_aMessages addObject:m2];
    [m_aMessages addObject:m3];
    [m_aMessages addObject:m4];
    [m_aMessages addObject:m5];
    [m_aMessages addObject:m2];
    [m_aMessages addObject:m3];
    [m_aMessages addObject:m4];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
