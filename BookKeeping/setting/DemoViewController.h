
#import <UIKit/UIKit.h>

typedef void(^moneyTransValue)(NSString *moneyType);

typedef void(^budgetTransValue)(NSString *budget);

@interface DemoViewController : UIViewController

@property (nonatomic,copy) moneyTransValue moneyTransValueBlock ;

@property (nonatomic,copy) budgetTransValue budgetTransValueBlock ;

@end
