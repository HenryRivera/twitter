//
//  TweetViewController.swift
//  Twitter
//
//  Created by Henry Rivera on 10/10/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // display keyboard
        tweetTextView.becomeFirstResponder()
        
        tweetTextView.delegate = self
    }
    
    func updateCharacterCount() {
        let tweetCount = self.tweetTextView.text.count
        self.characterCountLabel.text = "\(280 - tweetCount)"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if(textView == tweetTextView){
           return textView.text.count +  (text.count - range.length) <= 280
        }
        return false
        
    }
    
    
    

    @IBAction func cancelTweet(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createTweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetText: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
