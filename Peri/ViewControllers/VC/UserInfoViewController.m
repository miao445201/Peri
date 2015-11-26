//
//  UserInfoViewController.m
//  Peri
//
//  Created by fitfun on 15/11/24.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "UserInfoViewController.h"
#import "PeriDBModel.h"

@interface UserInfoViewController ()
@property(nonatomic,strong)FMDatabase *db;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"个人中心"];
    [[PeriDBModel GetInstance]initDB];
    [self animationTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animationTest {
    //演员初始化
    CALayer *groupLayer = [[CALayer alloc] init];
    groupLayer.frame = CGRectMake(60, 340+100, 50, 50);
    groupLayer.cornerRadius = 10;
    groupLayer.backgroundColor = [[UIColor purpleColor] CGColor];
    [self.view.layer addSublayer:groupLayer];
    
    //设定剧本
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:groupLayer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(320 - 80,
                                                                  groupLayer.position.y)];
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 2;
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 2;
    
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 2;
    groupAnnimation.autoreverses = YES;
    groupAnnimation.animations = @[moveAnimation, scaleAnimation, rotateAnimation];
    groupAnnimation.repeatCount = MAXFLOAT;
    //开演
    [groupLayer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
}
- (IBAction)testBUtton:(id)sender {

}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    //1.获得数据库文件的路径
//    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *fileName=[doc stringByAppendingPathComponent:@"student.sqlite"];
//    NSLog(@"=========================%@",fileName);
//    //2.获得数据库
//    FMDatabase *db=[FMDatabase databaseWithPath:fileName];
//    
//    //3.打开数据库
//    if ([db open]) {
//        //4.创表
//        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
//        if (result) {
//            NSLog(@"创表成功");
//        }else
//        {
//            NSLog(@"创表失败");
//        }
//    }
//    self.db=db;
//    
//}
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self delete];
//    [self insert];
//    [self query];
//}
//
////插入数据
//-(void)insert
//{
//    for (int i = 0; i<10; i++) {
//        NSString *name = [NSString stringWithFormat:@"jack-%d", arc4random_uniform(100)];
//        // executeUpdate : 不确定的参数用?来占位
//        [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", name, @(arc4random_uniform(40))];
//        //        [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);" withArgumentsInArray:@[name, @(arc4random_uniform(40))]];
//        
//        // executeUpdateWithFormat : 不确定的参数用%@、%d等来占位
//        //        [self.db executeUpdateWithFormat:@"INSERT INTO t_student (name, age) VALUES (%@, %d);", name, arc4random_uniform(40)];
//    }
//}
//
////删除数据
//-(void)delete
//{
//    //    [self.db executeUpdate:@"DELETE FROM t_student;"];
//    [self.db executeUpdate:@"DROP TABLE IF EXISTS t_student;"];
//    [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
//}
//
////查询
//- (void)query
//{
//    // 1.执行查询语句
//    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_student"];
//    
//    // 2.遍历结果
//    while ([resultSet next]) {
//        int ID = [resultSet intForColumn:@"id"];
//        NSString *name = [resultSet stringForColumn:@"name"];
//        int age = [resultSet intForColumn:@"age"];
//        NSLog(@"%d %@ %d", ID, name, age);
//    }
//}
@end
