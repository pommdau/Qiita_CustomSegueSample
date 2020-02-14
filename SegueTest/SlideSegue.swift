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
        
        let window = sourceViewController.view.window!
        let contentsViewHeightOffset = sourceViewController.view.frame.height - destinationViewController.view.frame.height
        let titlebarHeight = window.frame.height - sourceViewController.view.frame.height // タイトルバーの高さ
        let newFrame = NSRect(x: window.frame.origin.x,
                              y: window.frame.origin.y + contentsViewHeightOffset,
                              width: destinationViewController.view.frame.width,
                              height: destinationViewController.view.frame.height + titlebarHeight
        )
        
        sourceViewController.view.superview?.addSubview(destinationViewController.view) // ContainerViewに追加
        sourceViewController.view.removeFromSuperview() // 遷移前のビューを削除
        
        // Constraintsの設定
        destinationViewController.view.translatesAutoresizingMaskIntoConstraints = false
        destinationViewController.view.leadingAnchor.constraint(equalTo: parentViewController.view.leadingAnchor).isActive = true
        destinationViewController.view.trailingAnchor.constraint(equalTo: parentViewController.view.trailingAnchor).isActive = true
        destinationViewController.view.topAnchor.constraint(equalTo: parentViewController.view.topAnchor).isActive = true
        destinationViewController.view.bottomAnchor.constraint(equalTo: parentViewController.view.bottomAnchor).isActive = true
        
        // アニメーション的にウィンドウを変形する
        destinationViewController.view.isHidden = true   // ウィンドウサイズが変更された後に内容を表示するため
        NSAnimationContext.runAnimationGroup({ _ in
            window.animator().setFrame(newFrame, display: false)
        }, completionHandler: { [weak self] in
            destinationViewController.view.isHidden = false
        })
    }
}
