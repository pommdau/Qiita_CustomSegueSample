//
//  SecondViewController.swift
//  Qiita_CustomSegueSample
//

import Cocoa

class SecondViewController: NSViewController {
    
    var labelText: String = ""
    
    @IBOutlet var myLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        myLabel.stringValue = labelText
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        performSegue(withIdentifier: "SecondToFirst", sender: "This is a message from SecondViewController")
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "SecondToFirst" {
            let controller = segue.destinationController as! FirstViewController
            if let labelText = sender as? String {
                controller.labelText = labelText
                self.view.window?.title = "FirstView"
            }
        }
    }
}
