//
//  main.m
//  demo20191226
//
//  Created by wangjingru on 2019/12/26.
//  Copyright © 2019 wangjingru. All rights reserved.
//


/*
 引用计数demo
#import <Foundation/Foundation.h>


@interface RetainTracker: NSObject
@end

@implementation RetainTracker

-(id) init{
    if(self = [super init]){
        NSLog(@"init : Retain count of %lu", [self retainCount]);
    }
    
    return (self);
} //init

-(void) dealloc{
    NSLog(@"dealloc called. Bye Bye.");
    [super dealloc];
} //dealloc
@end //RetainTracker

int main(int argc,const char* argv[]){
    RetainTracker* tracker = [RetainTracker new];
    
    [tracker retain];
    NSLog(@"retainCount is %lu\n", [tracker retainCount]);
    
    [tracker release];
    NSLog(@"retainCount is %lu\n", [tracker retainCount]);
    
    
    [tracker release];
    
    return (0);
}
*/

//

#import <Foundation/Foundation.h>

@interface Engine: NSObject
@end


@implementation Engine

-(NSString*) description{
    return (@"i am an engine");
}

-(id) init{
    if(self = [super init]){
        NSLog(@"this is engine init");
    }
    
    return (self);
}

-(void) dealloc{
    NSLog(@"engine dealloc called. Bye, Bye");
    [super dealloc];
}

@end


@interface Car : NSObject{
    Engine* engine;
    //Tire *tires[4];
}

-(void) setEngine: (Engine*) newEngine;
-(Engine*) engine;

//-(void) setTire: (Tire*) tire atIndex: (int) index;
//-(Tire*) tireAtIndex: (int) index;

//-(void) print;
@end


@implementation Car

/*
//此代码会造成内存泄漏
-(void) setEngine: (Engine*) newEngine{
    engine = [newEngine retain];
}
 */
/*
 //当engine 与 newEngine 为同一个实例时， [engine release] 会将引用计数减为0，并释放engine对象，此时
 //这两个实例都指向刚释放的内存区
-(void) setEngine: (Engine*) newEngine{
    [engine release];
    [newEngine retain];
    engine = newEngine;
}
 */

//此为正确写法
-(void) setEngine: (Engine*) newEngine{
    [newEngine retain];
    [engine release];
    engine = newEngine;
    
}
-(Engine*) engine{
    return engine;
}

-(void) dealloc{
    NSLog(@"Car dealloc called");
    [engine release];
    [super dealloc];
}

//-(Tire*) tireAtIn
@end


/*
int main(int argc, const char* argv[]){
    Car *car = [Car new];
    
    Engine* engine1 = [Engine new];
    [car setEngine: engine1];
    [engine1 release];
    
    Engine* engine2 = [Engine new];
    [car setEngine: engine2];
    [engine2 release];
    [car release];
    
    return (0);
    
}
 */

//自动释放
@interface SomeObject : NSObject
@end

@implementation SomeObject
-(id) init{
    if(self = [super init]){
        NSLog(@"SomeObject init called");
    }
    
    return self;
}

-(void) dealloc{
    NSLog(@"SomeObject dealloc called");
    [super dealloc];
}

-(NSString*) description{
    NSString * desp;
    desp = [[NSString alloc] initWithFormat: @"i am %d years old", 4];
    
    return ([desp autorelease]); //autorelease是将该对象添加到NSAutoreleasePool中
}
@end


int main(int argc, const char* argv[]){
    NSAutoreleasePool *pool;
    pool = [[NSAutoreleasePool alloc] init];
    
    SomeObject* ret = [SomeObject new];
    NSString *str = [ret description];
    NSLog(@"str retainCount is %lu", [str retainCount]);// retainCount 为 1
    
    
    SomeObject * someobject;
    someobject = [SomeObject new];
    [someobject retain];// retainCount 为 2
    [someobject autorelease]; //retainCount 为 2
    [someobject release]; //retainCount 为 1
    
    [pool release];
    
    NSLog(@"str retainCount is %lu", [str retainCount]);//此时str 的retainCount 值是一个随机值。

    
    return 0;
}

//

