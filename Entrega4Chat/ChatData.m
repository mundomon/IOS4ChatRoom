//
//  ChatData.m
//  Entrega4Chat
//
//  Created by dedam on 26/1/17.
//  Copyright © 2017 dedam. All rights reserved.
//

#import "ChatData.h"

@implementation ChatData



-(ChatData*)createData:(int)iVersionParam iID:(int)iIDParam bIsMine:(BOOL)bIsMineParam eChatDataType:(ChatDataType)eChatDataTypeParam sMessage:(NSString*)sMessageParam mdate:(NSDate*)dateParam image:(UIImage*)imageParam{
    
    ChatData *m1 = [[ChatData alloc]init];
    m1.m_iVersion=iVersionParam;
    m1.m_iID=iIDParam;
    m1.m_bIsMine=bIsMineParam;
    m1.m_eChatDataType=eChatDataTypeParam;
    m1.m_sMessage=sMessageParam;
    m1.m_Date=dateParam;
    m1.m_Image=imageParam;
    
    return m1;
}

@end
