//
//  ViewController.m
//  ARKitDetectionImage
//
//  Created by LJP on 2018/4/2.
//  Copyright © 2018年 LJP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the view's delegate
    self.sceneView.delegate = self;
    
    // Show statistics such as fps and timing information
    self.sceneView.showsStatistics = YES;
    
    // Create a new scene
    SCNScene *scene = [SCNScene new];
    
    // Set the scene to the view
    self.sceneView.scene = scene;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    
    configuration.detectionImages = [ARReferenceImage referenceImagesInGroupNamed:@"AR Resources" bundle:nil];
    
    
    [self.sceneView.session runWithConfiguration:configuration options:ARSessionRunOptionResetTracking |ARSessionRunOptionRemoveExistingAnchors];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
    ARImageAnchor * imageAnchor = (ARImageAnchor *)anchor;
    
    //获取参考图片对象
    ARReferenceImage * referenceImage = imageAnchor.referenceImage;
    
    if ([referenceImage.name isEqual: @"lcw"]) {
        
        SCNNode * tempNode = [SCNNode new];
        
        CGFloat w = referenceImage.physicalSize.width;
        CGFloat h = referenceImage.physicalSize.height;
        
        SCNBox * box = [SCNBox boxWithWidth:w height:h length:0.01 chamferRadius:0];
        tempNode.geometry = box;
        tempNode.eulerAngles = SCNVector3Make(-M_PI/2.0, 0, 0);
        tempNode.opacity = 0.5;//透明度
        
        [node addChildNode:tempNode];
    }
    
}

@end
