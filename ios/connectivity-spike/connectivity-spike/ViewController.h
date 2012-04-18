#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)startDownload:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
