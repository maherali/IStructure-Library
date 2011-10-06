#ifndef AGILIS_MACROS

#define AGILIS_MACROS


#define $watch(OBJS...)\
    do { \
        id theObjs[] = {OBJS}; \
        int no = sizeof(theObjs)/sizeof(id);\
        NSMutableArray *objs = [NSMutableArray array];\
        id *p = &theObjs[0];\
        if(no >= 1){\
                [objs addObject:(*p)];\
        }\
        if(no >= 2){\
            if([*(p+1) respondsToSelector:@selector(copyWithZone:)]){\
                [objs addObject:[[*(p+1) copy] autorelease]];\
            }else {\
                [objs addObject:*(p+1)];\
            }\
        }\
        if(no >= 3){\
            [objs addObject:[[*(p+2) copy] autorelease]];\
        }\
        BOOL hasObservers = [this respondsToSelector:@selector(observers)];\
        NSMutableArray *theObservers = nil;\
        if(hasObservers){\
            theObservers = [this performSelector:@selector(observers)];\
        }\
        if(hasObservers){\
            if(!theObservers){\
                LOG(@"You need to initialize the observers with an empty mutable array."); \
                @throw @"You need to initialize the observers with an empty mutable array."; \
            } \
        } else {\
            LOG(@"You need to create observers property that is a mutable array."); \
            @throw @"You need to create observers property that is a mutable array."; \
        } \
        if(no == 3){\
            id ret = [[NSNotificationCenter defaultCenter]\
                      addObserverForName:[objs objectAtIndex:0] object:[objs objectAtIndex:1] queue:nil usingBlock:[objs objectAtIndex:2]];\
            [theObservers addObject:[ISObserver valueWithName:[objs objectAtIndex:0] andObserver:ret forObject:[objs objectAtIndex:1]]];\
        } else if (no == 2){\
            if([[objs objectAtIndex:0] isKindOfClass:[NSString class]]){\
                id ret = [[NSNotificationCenter defaultCenter] addObserverForName:[objs objectAtIndex:0] object:nil queue:nil usingBlock:[objs objectAtIndex:1]];\
                [observers addObject:[ISObserver valueWithName:[objs objectAtIndex:0] andObserver:ret forObject:nil]];\
            }else{\
                id ret = [[NSNotificationCenter defaultCenter] addObserverForName:nil object:[objs objectAtIndex:0] queue:nil usingBlock:[objs objectAtIndex:1]];\
                [observers addObject:[ISObserver valueWithName:nil andObserver:ret forObject:[objs objectAtIndex:0]]];\
            }\
        }\
    } while(0);



#define $unwatch(OBJS...)\
    do { \
        id theObjs[] = {OBJS}; \
        int no = sizeof(theObjs)/sizeof(id);\
        NSArray *objs = [NSArray arrayWithObjects:theObjs count:no];\
        BOOL hasObservers = [this respondsToSelector:@selector(observers)];\
        NSMutableArray *theObservers = nil;\
        if(hasObservers){\
            theObservers = [this performSelector:@selector(observers)];\
        }\
        if(hasObservers){\
            if(!theObservers){\
                LOG(@"You need to initialize the observers with an empty mutable array."); \
                @throw @"You need to initialize the observers with an empty mutable array."; \
            } \
        } else {\
            LOG(@"You need to create observers property that is a mutable array."); \
            @throw @"You need to create observers property that is a mutable array."; \
        } \
        if(no == 2){\
            NSMutableArray *temp = [NSMutableArray array];\
            for(ISObserver *ob in theObservers){\
                if([objs objectAtIndex:1] == ob.object && [[objs objectAtIndex:0] isEqualToString:ob.name]){\
                    [[NSNotificationCenter defaultCenter] removeObserver:ob.observer];\
                    [temp addObject:ob];\
                }\
            }\
            [theObservers removeObjectsInArray:temp];\
        }else if (no == 1 && [[objs objectAtIndex:0] isKindOfClass:[NSString class]]){\
            NSMutableArray *temp = [NSMutableArray array];\
            for(ISObserver *ob in theObservers){\
                if([[objs objectAtIndex:0] isEqualToString:ob.name]){\
                    [[NSNotificationCenter defaultCenter] removeObserver:ob.observer];\
                    [temp addObject:ob];\
                }\
            }\
            [theObservers removeObjectsInArray:temp];\
        }else if (no == 1){\
            NSMutableArray *temp = [NSMutableArray array];\
            for(ISObserver *ob in theObservers){\
                if([objs objectAtIndex:0] == ob.object){\
                    [[NSNotificationCenter defaultCenter] removeObserver:ob.observer];\
                    [temp addObject:ob];\
                }\
            }\
            [theObservers removeObjectsInArray:temp];\
        }else if (no == 0){\
            for(ISObserver *ob in theObservers){\
                [[NSNotificationCenter defaultCenter] removeObserver:ob.observer];\
            }\
            [theObservers removeAllObjects];\
        }\
    } while(0);


//////////////////////////////////////// used internally  ////////////////////////////////////////
#define $watchp(NAME, OTHER, BLOCK)\
    do { \
        if([OTHER respondsToSelector:@selector(observers)]){\
            id ret = [[NSNotificationCenter defaultCenter] addObserverForName:NAME object:nil queue:nil usingBlock:BLOCK];\
            if([OTHER performSelector:@selector(observers)]){\
                [[OTHER performSelector:@selector(observers)] addObject:[ISObserver valueWithName:NAME andObserver:ret forObject:nil]];\
            } else {\
                LOG(@"You need to initialize the observers with an empty mutable array."); \
                @throw @"You need to initialize the observers with an empty mutable array."; \
            } \
        } else {\
            LOG(@"You need to create observers property that is a mutable array."); \
            @throw @"You need to create observers property that is a mutable array."; \
        } \
    } while(0);

#define $unwatchp(NAME, OTHER) \
    do { \
        if([OTHER respondsToSelector:@selector(observers)]){\
            NSMutableArray *temp = [NSMutableArray array];\
            for(ISObserver *ob in [OTHER performSelector:@selector(observers)]){\
                if([NAME isEqualToString:ob.name]){\
                    [[NSNotificationCenter defaultCenter] removeObserver:ob.observer];\
                    [temp addObject:ob];\
                }\
            }\
            [[OTHER performSelector:@selector(observers)] removeObjectsInArray:temp];\
        } else {\
            LOG(@"You need to create observers property that is a mutable array."); \
            @throw @"You need to create observers property that is a mutable array."; \
        } \
    } while(0);

//////////////////////////////////////// TRIGGER ///////////////////////////////////////////

#define $trigger(OBJS...)\
    do { \
        id theObjs[] = {OBJS}; \
        int no = sizeof(theObjs)/sizeof(id);\
        id *p = &theObjs[0];\
        LOG(@"Trigger: %@", *p);\
        if(no == 2){\
            [[NSNotificationCenter defaultCenter] postSyncNotificationName:*p object:this userInfo:(NSDictionary*)*(p+1)];\
        }else if(no == 3){\
            [[NSNotificationCenter defaultCenter] postSyncNotificationName:*p object:*(p+2) userInfo:(NSDictionary*)*(p+1)];\
        }else if(no == 1){\
            [[NSNotificationCenter defaultCenter] postSyncNotificationName:*p object:this userInfo:nil];\
        }\
    } while(0);

//////////////////////////////////////// ROUTE ///////////////////////////////////////////

#define $routec(OBJS...) \
    do { \
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; \
        id theObjs[] = {OBJS}; \
        int no = sizeof(theObjs)/sizeof(id);\
        id *p = &theObjs[0];\
        if(no == 1){\
            [ISRouter routeControllerName:NSStringFromClass([this class]) withAction:nil toRoutePattern:*p]; \
        }else if(no == 2){\
            [ISRouter routeControllerName:NSStringFromClass([this class]) withAction:*(p+1) toRoutePattern:*p]; \
        }\
        [pool release]; \
    } while(0);


#define $register(OBJS...) \
    do { \
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; \
        id theObjs[] = {OBJS}; \
        int no = sizeof(theObjs)/sizeof(id);\
        id *p = &theObjs[0];\
        if(no == 1){\
            [ISRouter registerService:*p toServiceClass:NSStringFromClass([this class])]; \
        }\
        [pool release]; \
    } while(0);

#define $start(ARGS...) \
    do { \
        id theArgs[] = {ARGS}; \
        int no = sizeof(theArgs)/sizeof(id);\
        id *p = &theArgs[0];\
        id __$options = nil;\
        if(no == 2){\
            __$options = *(p+1);\
        }\
        [ISRouter startService:*p withOptions:__$options]; \
    } while(0);

#define $stop(ARGS...) \
    do { \
        id theArgs[] = {ARGS}; \
        int no = sizeof(theArgs)/sizeof(id);\
        id *p = &theArgs[0];\
        id __$options = nil;\
        if(no == 2){\
            __$options = *(p+1);\
        }\
        [ISRouter stopService:*p withOptions:__$options]; \
    } while(0);

#define $route(ROUTE_PATTERN, BLOCK) \
    do { \
        [ISRouter routePattern:ROUTE_PATTERN toController:this withBlock:BLOCK];\
    } while(0);

#define $route_exist(ROUTE_PATTERN) [ISRouter routeExist:ROUTE_PATTERN]
 
#define $unroute(ROUTE_PATTERN) \
    do { \
        [ISRouter unroutePattern:ROUTE_PATTERN fromController:this]; \
    } while(0);

#define $navigate(ARGS...) \
    do { \
        id theArgs[] = {ARGS}; \
        int no = sizeof(theArgs)/sizeof(id);\
        id *p = &theArgs[0];\
        id __$options = nil;\
        if(no == 2){\
            __$options = *(p+1);\
        }\
        LOG(@"Navigate: %@", *p);\
        if([this respondsToSelector:@selector(navigationController)]){\
            UINavigationController *nav = [(UIViewController*)this navigationController];\
            [ISRouter navigate:*p withNavCtrl:nav andOptions:__$options]; \
        }else{\
            [ISRouter navigate:*p withOptions:__$options]; \
        }\
    } while(0);

/////////////////////////////////////////////////////////////////////

#define REJECT_SIMULTANEOUS_CONNECTIONS if(self.sync) return;

#define IS_COLLECTION(OPTIONS) [OPTIONS objectForKey:COLLECTION_KEY]
#define IS_SILENT(OPTIONS) [[OPTIONS objectForKey:SILENT_KEY] boolValue]

#define $arg(HASH,NAME) [HASH objectForKey:NAME]

#define $block(block) [[block copy] autorelease]

#define CONCAT(x, y) x ## y

#define EXTRACT_FILE_NAME(F) ([[[[NSURL alloc] initFileURLWithPath:[NSString stringWithUTF8String:F]] autorelease] lastPathComponent])

#ifdef DEBUG
#define LOG(fmt, ...) \
    do { \
        NSLog(@"%@:%d (%s): " fmt, EXTRACT_FILE_NAME(__FILE__), __LINE__, __func__, ## __VA_ARGS__); \
    } while(0);

#else
    #define LOG(fmt, ...) 
#endif






#endif
