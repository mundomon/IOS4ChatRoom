//
//  ChatData.h
//  Entrega4Chat
//
//  Created by dedam on 26/1/17.
//  Copyright © 2017 dedam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum{
    ChatData_Message = 0,
    ChatData_Image,
    ChatData_None
}ChatDataType;


@interface ChatData : NSObject
{}

//---Properties:
@property (nonatomic, assign) int           m_iVersion;
@property (nonatomic, assign) int           m_iID;
@property (nonatomic, assign) BOOL          m_bIsMine;
@property (nonatomic, assign) ChatDataType  m_eChatDataType;
@property (nonatomic, copy) NSString*       m_sMessage;
@property (nonatomic, copy) NSDate*         m_Date;
@property (nonatomic, copy) UIImage*        m_Image;




//---Functions:
//...


@end
