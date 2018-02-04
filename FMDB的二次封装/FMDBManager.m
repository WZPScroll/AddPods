//
//  FMDBManager.m
//  NEW
//
//  Created by WZP on 16/4/27.
//  Copyright © 2016年 123. All rights reserved.
//

#import "FMDBManager.h"

@implementation FMDBManager

static FMDBManager * manager;

//单利方法
+ (FMDBManager*)shareManager{
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager=[[FMDBManager alloc] init];
        });
    }
    return manager;

}
//初始化方法
- (instancetype)init{
    self=[super init];
    if (self) {
        NSString * documentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 1, YES)[0];
        
        NSLog(@"%@",documentPath);
        
        NSString * dbPath=[documentPath stringByAppendingString:@"/数据库"];
        
        db=[FMDatabase databaseWithPath:dbPath];
        
        if ([db open]) {
            
            NSLog(@"创建数据库成功");
            
            NSString * createTable=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS USERTABLE (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
            
            if ([db executeUpdate:createTable]) {
                NSLog(@"建表成功!!");
                
            }
        }
        
    }

    return self;
}
//遍历数据库
- (void)selectTableAllInfomation{
    FMResultSet * resultSet=[db executeQuery:@"select * from USERTABLE"];
    while ([resultSet next]) {
        NSString * name=[resultSet stringForColumn:@"name"];
        NSString * age=[resultSet stringForColumn:@"age"];
        NSLog(@"%@ 今年 %@岁",name,age);
    }
    
}
//插入数据
- (void)inserIntoTableWithName:(NSString*)name age:(NSString*)age{

    NSString * insert=[NSString stringWithFormat:@"insert into USERTABLE(name,age) values('%@','%@')",name,age];
    
    if ([db executeUpdate:insert]) {
        NSLog(@"插入%@成功",name);
    }
    
}
//删除数据
- (void)deleteWithName:(NSString*)name{
    NSString * delete=[NSString stringWithFormat:@"delete from USERTABLE where name='%@'",name];

    if ([db executeUpdate:delete]) {
        NSLog(@"删除%@成功",name);
    }

}
//查询
- (void)selectWithName:(NSString*)name{
    NSString * select=[NSString stringWithFormat:@"select * from USERTABLE where name='%@'",name];

   FMResultSet * set=[db executeQuery:select];
    while ([set next]) {
        NSString * age=[set stringForColumn:@"age"];
        NSLog(@"%@年龄是%@",name,age);
    }
    
    
    
}
//修改数据
- (void)changeAgeWithName:(NSString*)name newAge:(NSString*)newAge{
    NSString * change=[NSString stringWithFormat:@"UPDATE USERTABLE SET age='%@' where name='%@'",newAge,name];
    if ([db executeUpdate:change]) {
        NSLog(@"修改 %@ 成功",name);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
