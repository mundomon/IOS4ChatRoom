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
    UITapGestureRecognizer *tapPress;
    NSString *stringDate;
    NSString *stringHour;
    NSDateFormatter *dateFormatter;
    NSDateFormatter *hourFormatter;
    NSDateFormatter *stringToDateFormat;
    NSMutableArray* list;
    NSMutableArray *secciones;
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
    _tableView.estimatedRowHeight=70;
    
    [self iniciarMensajes];
    
    list=[[NSMutableArray alloc]init];
    secciones=[[NSMutableArray alloc]init];
    
    dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    hourFormatter=[[NSDateFormatter alloc]init];
    [hourFormatter setDateFormat:@"HH:mm"];


    // Keyboard events
    [self registerForKeyBoardNotifications];
    
    //TAP gesture recognizer
    tapPress=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTaps:)];
    [tapPress setNumberOfTouchesRequired:1];
    [tapPress setNumberOfTapsRequired:1];
    [self.tableView addGestureRecognizer:tapPress];
    
    [self iniciarSecciones];
}

-(void)handleTaps:(UITapGestureRecognizer*)paramSender{
    if([_textField isFirstResponder]){
        [self.view endEditing:YES];
    }
}

#pragma mark - Keyboard events

-(void)registerForKeyBoardNotifications{
    // Keyboard events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = _viewToolBar.frame;
        frame.origin.y -= kbSize.height;
        _viewToolBar.frame = frame;
        
        frame = _tableView.frame;
        frame.size.height -= kbSize.height;
        _tableView.frame = frame;
        //[self goToLastMessage];
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [_textField becomeFirstResponder];
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = _viewToolBar.frame;
        frame.origin.y += kbSize.height;
        _viewToolBar.frame = frame;
        
        frame = _tableView.frame;
        frame.size.height += kbSize.height;
        _tableView.frame = frame;
    }];
}

#pragma mark - Funciones obligatorias del TableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return secciones.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    NSMutableArray* kk=[secciones objectAtIndex:section];
    return kk.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    
    
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =[list objectAtIndex:section];
    
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:
     [UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *kk= [secciones objectAtIndex:indexPath.section];
    ChatData* chatData = [kk objectAtIndex:indexPath.row];
    NSLog(@"verChatData");
    
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
    
    NSMutableArray *kk= [secciones objectAtIndex:indexPath.section];
    ChatData* chatData = [kk objectAtIndex:indexPath.row];
    NSString *CellType=@"Chat_Msg_Cell";
    
    //Gestion Fecha, secciones label
    stringDate=[dateFormatter stringFromDate:chatData.m_Date];
    stringHour=[hourFormatter stringFromDate:chatData.m_Date];

    
    Chat_Msg_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellType forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[Chat_Msg_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellType];
    }
    cell.txtMsg.text = chatData.m_sMessage;
    cell.txtMsg.numberOfLines=0; //para que el label se ajuste a la altura del texto
    //[cell.txtMsg sizeToFit];
    //[cell.contentCell sizeToFit];
    cell.labelDate.text = stringHour;
    
    return cell;
}

- (UITableViewCell *)tableView_OtherMessage:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *kk= [secciones objectAtIndex:indexPath.section];
    ChatData* chatData = [kk objectAtIndex:indexPath.row];
    NSString *CellType=@"Chat_MsgOthers_Cell";
    
    //Gestion Fecha, secciones label
    stringDate=[dateFormatter stringFromDate:chatData.m_Date];
    stringHour=[hourFormatter stringFromDate:chatData.m_Date];
    
    Chat_MsgOthers_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellType forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[Chat_MsgOthers_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellType];
    }
    cell.txtMsg.text=chatData.m_sMessage;
    cell.txtMsg.numberOfLines=0;
    cell.labelDate.text = stringHour;
    
    return cell;
}

- (UITableViewCell *)tableView_MyImage:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *kk= [secciones objectAtIndex:indexPath.section];
    ChatData* chatData = [kk objectAtIndex:indexPath.row];
    NSString *CellType=@"Chat_MyImage_Cell";
    
    //Gestion Fecha, secciones label
    stringDate=[dateFormatter stringFromDate:chatData.m_Date];
    stringHour=[hourFormatter stringFromDate:chatData.m_Date];
    
    Chat_MyImage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellType forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[Chat_MyImage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellType];
    }
    cell.imgMsg.image=chatData.m_Image;
    cell.labelDate.text = stringHour;

    
    return cell;
}

- (UITableViewCell *)tableView_OtherImage:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *kk= [secciones objectAtIndex:indexPath.section];
    ChatData* chatData = [kk objectAtIndex:indexPath.row];
    NSString *CellType=@"Chat_OtherImage_Cell";

    //Gestion Fecha, secciones label
    stringDate=[dateFormatter stringFromDate:chatData.m_Date];
    stringHour=[hourFormatter stringFromDate:chatData.m_Date];

    
    Chat_OtherImage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellType forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[Chat_OtherImage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellType];
    }
    cell.imgMsg.image=chatData.m_Image;
    cell.labelDate.text = stringHour;
    
    return cell;
}


#pragma mark - Botones

- (IBAction)btnEnviar:(id)sender{
    [self.view endEditing:YES];
    
    NSString* texto=_textField.text;
    if(![texto isEqual:@""]){
        _textField.text=@"";
        
        ChatData *m1 = [[ChatData alloc]init];
        m1.m_iVersion=1;
        m1.m_iID=1;
        m1.m_bIsMine=YES;
        m1.m_eChatDataType=0;
        m1.m_sMessage=texto;
        m1.m_Date=[[NSDate alloc]init]; //fecha actual
        m1.m_Image=nil;
        [m_aMessages addObject:m1];
        
        ChatData *m2=[[ChatData alloc]init];
        m2.m_iVersion=1;
        m2.m_iID=1;
        m2.m_bIsMine=NO;
        m2.m_eChatDataType=0;
        m2.m_sMessage=texto;
        m2.m_Date=[[NSDate alloc]init]; //fecha actual
        m2.m_Image=nil;
        [m_aMessages addObject:m2];
        
        [self iniciarSecciones];
        [_tableView reloadData];
    }
}

- (IBAction)btnFoto:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"IMATGES" message:@"Tria una imatge" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"CAMARA",@"GALERIA", nil];
    [alert show];
    
}
//ALERTA
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            if (m_imgPicker == nil){
                m_imgPicker = [[UIImagePickerController alloc] init];
            }
            m_imgPicker.allowsEditing = YES;
            m_imgPicker.delegate = self;
            m_imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:m_imgPicker animated:YES completion:nil];
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"La cámara no está disponible" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    if(buttonIndex==2){ //seleccion de imagen GALERIA
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            if(m_imgPicker==nil)
                m_imgPicker=[[UIImagePickerController alloc]init];
            
            m_imgPicker.allowsEditing=YES;
            m_imgPicker.delegate=self;
            m_imgPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:m_imgPicker animated:YES completion:nil];
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"No puedes seleccionar imagen de Archivo" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo{
    ChatData *m3 = [[ChatData alloc]init];
    m3.m_iVersion=1;
    m3.m_iID=3;
    m3.m_bIsMine=YES;
    m3.m_eChatDataType=1;
    m3.m_sMessage=@"mensaje pal mon";
    m3.m_Date=[[NSDate alloc]init]; //fecha actual
    m3.m_Image=img;
    [m_aMessages addObject:m3];
    
    [self iniciarSecciones];
    [_tableView reloadData];
    
    [self dismissModalViewControllerAnimated:YES];
}



#pragma mark - Iniciar Datos

-(void)iniciarMensajes{
    stringToDateFormat=[[NSDateFormatter alloc]init];
    [stringToDateFormat setDateFormat:@"HH:mm dd-MM-yyyy"];
   
    ChatData *m1 = [[ChatData alloc]init];
    m1.m_iVersion=1;
    m1.m_iID=1;
    m1.m_bIsMine=YES;
    m1.m_eChatDataType=0;
    m1.m_sMessage=@"mensaje del mon 1";
    m1.m_Date=[stringToDateFormat dateFromString:@"10:30 01-01-2017"];
    m1.m_Image=nil;
    //[m1 createData:1 iID:1 bIsMine:YES eChatDataType:0 sMessage:@"Mensaje del mon 1" mdate:[[NSDate alloc]init] image:nil];
    
    ChatData *m2 = [[ChatData alloc]init];
    m2.m_iVersion=1;
    m2.m_iID=2;
    m2.m_bIsMine=NO;
    m2.m_eChatDataType=0;
    m2.m_sMessage=@"mensaje del mon 2 que tiene que ser muy largo y ocupar mas de una linea para poder ver si se alarga el frame o no";
    m2.m_Date=[stringToDateFormat dateFromString:@"10:40 01-01-2017"]; //fecha actual
    m2.m_Image=nil;
    
    ChatData *m3 = [[ChatData alloc]init];
    m3.m_iVersion=1;
    m3.m_iID=3;
    m3.m_bIsMine=YES;
    m3.m_eChatDataType=1;
    m3.m_sMessage=@"mensaje pal mon";
    m3.m_Date=[stringToDateFormat dateFromString:@"11:30 02-01-2017"];
    m3.m_Image=[UIImage imageNamed:@"avatar.png" ];
    
    ChatData *m4 = [[ChatData alloc]init];
    m4.m_iVersion=1;
    m4.m_iID=4;
    m4.m_bIsMine=NO;
    m4.m_eChatDataType=1;
    m4.m_sMessage=@"mensaje pal mon";
    m4.m_Date=[stringToDateFormat dateFromString:@"11:59 02-01-2017"];
    m4.m_Image=[UIImage imageNamed:@"company.png" ];
    
    ChatData *m5 = [[ChatData alloc]init];
    m5.m_iVersion=1;
    m5.m_iID=5;
    m5.m_bIsMine=YES;
    m5.m_eChatDataType=0;
    m5.m_sMessage=@"mensaje del mon 3 que tiene que ser muy largo y ocupar mas de una linea para poder ver si se alarga el frame o no";
    m5.m_Date=[[NSDate alloc]init]; //fecha actual
    m5.m_Image=nil;
    
    m_aMessages = [[NSMutableArray alloc]init];
    [m_aMessages addObject:m1];
    [m_aMessages addObject:m1];
    [m_aMessages addObject:m2];
    [m_aMessages addObject:m2];
    [m_aMessages addObject:m3];
    [m_aMessages addObject:m3];
    [m_aMessages addObject:m4];
    [m_aMessages addObject:m4];
    [m_aMessages addObject:m5];
    [m_aMessages addObject:m5];
    
}

-(void)iniciarSecciones{
    // Initializing sections.
    ChatData *m=[[ChatData alloc]init];
    
    m=[m_aMessages objectAtIndex:0];
    NSString *fechaSeccion=[dateFormatter stringFromDate:m.m_Date];
    [list addObject:fechaSeccion];
    
    for(int i=0;i<m_aMessages.count;i++){
        m=[m_aMessages objectAtIndex:i];
        if([fechaSeccion isEqualToString:[dateFormatter stringFromDate:m.m_Date]]){
            NSMutableArray *rowForSection=[[NSMutableArray alloc]init];
            
            while([fechaSeccion isEqualToString:[dateFormatter stringFromDate:m.m_Date]] &&
                  i<m_aMessages.count){
                [rowForSection addObject:[m_aMessages objectAtIndex:i]];
                i++;
                if(i<m_aMessages.count) m=[m_aMessages objectAtIndex:i];
            }
            [secciones addObject:rowForSection];
            
            if(i<m_aMessages.count){ //sale del while pq fecha diferente, es decir nueva seccion
                fechaSeccion=[dateFormatter stringFromDate:m.m_Date];
                [list addObject:fechaSeccion];
                i--;
            }
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
