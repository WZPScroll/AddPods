//
//  FMDBManager.h
//  NEW
//
//  Created by WZP on 16/4/27.
//  Copyright © 2016年 123. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMDBManager : UIView
{
    FMDatabase  *db;
}

/** 
    类方法进行初始化会创建表
 */
+ (FMDBManager*)shareManager;

/** 
    遍历所有表中的信息
 */
- (void)selectTableAllInfomation;

/** 
    插入数据
 */
- (void)inserIntoTableWithName:(NSString*)name age:(NSString*)age;

/** 
    根据名字删除数据
 */
- (void)deleteWithName:(NSString*)name;

/**
    根据名字查询年龄
 */
- (void)selectWithName:(NSString*)name;

/**
    根据名字修改年龄
 */
- (void)changeAgeWithName:(NSString*)name newAge:(NSString*)newAge;

@end
