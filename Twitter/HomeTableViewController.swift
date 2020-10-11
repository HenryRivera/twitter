//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Henry Rivera on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numTweets: Int!
    
    let tweetRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // target: Where do I want this to happen
        // Selector: What do you want us to do?
        tweetRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        
        // telling table which refresh control to use
        tableView.refreshControl = tweetRefreshControl
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 150
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()
    }
    
    
    @objc func loadTweets(){
        numTweets = 24
        
        let baseURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": numTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: baseURL, parameters: params, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.tweetRefreshControl.endRefreshing()
        }, failure: {(Error) in
            print("Could not retrieve tweets! Try again")
        })
    }
    
    func loadMoreTweets(){
        let baseURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numTweets += 24
        let params = ["count": numTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: baseURL, parameters: params, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: {(Error) in
            print("Could not retrieve tweets! Try again")
        })
    }
    
    // syntax for what we want to happen when user gets towards end of page
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
    }
    

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        
        // screen will dismiss itself
        self.dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetContentTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.usernameLabel.text = (user["name"] as! String)
        cell.tweetLabel.text = (tweetArray[indexPath.row]["text"] as! String)
        
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        return cell
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

}
