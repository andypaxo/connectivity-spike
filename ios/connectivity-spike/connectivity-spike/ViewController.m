#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textView;
@synthesize spinner;

- (void)viewDidUnload {
    [self setSpinner:nil];
    [self setTextView:nil];
    [super viewDidUnload];
}

- (IBAction)startDownload:(id)sender {
    [spinner startAnimating];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://github.com"]];
    NSOperationQueue* queue = [NSOperationQueue new];
    
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:queue
     completionHandler:^(NSURLResponse* response,
                         NSData* data,
                         NSError* error) {
         if (!data.length)
             [self showFail];
         else if (error)
             [self showError:error];
         else
             [self showData:data];
     }];
}

- (void) showFail {
    NSLog(@"Failed to download anything");
}

- (void) showError: (NSError*) error {
    NSLog(@"Error: %@", error);
}

- (void) showData: (NSData*) data {
    NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
@end
