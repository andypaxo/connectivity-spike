#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSString* downloadResult;
}

@synthesize webView;
@synthesize spinner;

- (void)viewDidUnload {
    [self setSpinner:nil];
    [self setWebView:nil];
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
         [self performSelectorOnMainThread:@selector(updateUi) withObject:nil waitUntilDone:false];
     }];
}

- (void) showFail {
    downloadResult = @"Failed to download anything";
}

- (void) showError: (NSError*) error {
    downloadResult = [NSString stringWithFormat:@"Error: %@", error];
}

- (void) showData: (NSData*) data {
    downloadResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void) updateUi {
    // NOTE: This is a very silly way to use a web view
    [webView loadHTMLString:downloadResult baseURL:[NSURL URLWithString:@"http://github.com"]];
    [spinner stopAnimating];
}
@end
