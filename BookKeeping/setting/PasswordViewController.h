

#import <UIKit/UIKit.h>
@protocol password<NSObject>

-(void)try:(BOOL)tryfalg;

@end
@interface PasswordViewController : UIViewController
@property(nonatomic,strong)id<password>delegade;
@property(nonatomic,assign)BOOL try;
@end
