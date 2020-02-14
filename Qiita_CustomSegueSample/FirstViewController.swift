//
//  FirstViewController.swift
//  Qiita_CustomSegueSample
//

import Cocoa

class FirstViewController: NSViewController {
    
    @IBOutlet var myLabel: NSTextField!
    var labelText = "First View"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        myLabel.stringValue = labelText
    }
    
    @IBAction func debugButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "FirstToSecond", sender: "This is a message from FirstViewController")
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstToSecond" {
            let controller = segue.destinationController as! SecondViewController
            if let labelText = sender as? String {
                controller.labelText = labelText
                self.view.window?.title = "SecondView"
            }
        }
    }
}
