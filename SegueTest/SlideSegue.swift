//
//  SlideSegue.swift
//  SegueTest
//

import Cocoa

class SlideSegue: NSStoryboardSegue {
    override func perform() {
        // NSViewControllerの親子関係を設定
        guard
            let sourceViewController = self.sourceController as? NSViewController,
            let destinationViewController = self.destinationController as? NSViewController,
            let parentViewController = sourceViewController.parent
            else {
                print("downcasting or unwrapping error")
                return
        }
        
        if (!parentViewController.children.contains(destinationViewController)) {
            parentViewController.addChild(destinationViewController)
        }
        
        if let window = sourceViewController.view.window  {
            let contentsViewHeightOffset = sourceViewController.view.frame.height - destinationViewController.view.frame.height
            let titleBarHeightOffset = window.frame.height - sourceViewController.view.frame.height // Titlebar.height分
            let newRect = NSRect(x: window.frame.origin.x,
                                 y: window.frame.origin.y + contentsViewHeightOffset,
                                 width: destinationViewController.view.frame.width,
                                 height: destinationViewController.view.frame.height + titleBarHeightOffset
)
            window.setFrame(newRect, display: true)
        }
        
        sourceViewController.view.superview?.addSubview(destinationViewController.view) // ContainerViewに追加
        sourceViewController.view.removeFromSuperview()
        
        // Constraintsの設定
        destinationViewController.view.translatesAutoresizingMaskIntoConstraints = false
        destinationViewController.view.leadingAnchor.constraint(equalTo: parentViewController.view.leadingAnchor).isActive = true
        destinationViewController.view.trailingAnchor.constraint(equalTo: parentViewController.view.trailingAnchor).isActive = true
        destinationViewController.view.topAnchor.constraint(equalTo: parentViewController.view.topAnchor).isActive = true
        destinationViewController.view.bottomAnchor.constraint(equalTo: parentViewController.view.bottomAnchor).isActive = true
    }
}
