//
//  ViewController.swift
//  FetchDataAssignment3CollectionView
//
//  Created by Mac on 20/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postCollectionView: UICollectionView!
    var post : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initializeTableView()
        registerXIBWithTableView()
    }
    func initializeTableView()
    {
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
    }
    func registerXIBWithTableView()
    {
        let uinib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
        postCollectionView.register(uinib, forCellWithReuseIdentifier: "PostCollectionViewCell")
    }
    func fetchData()
    {
        let postUrl = URL(string: "https://jsonplaceholder.typicode.com/todos")
        var postUrlRequest = URLRequest(url: postUrl!)
        postUrlRequest.httpMethod = "Get"
        
        let postUrlSession = URLSession(configuration: .default)
        let postDataTask = postUrlSession.dataTask(with: postUrlRequest) { postData, postResponse, postError in
//            print(postData)
//            print(postResponse)
//            print(postError)
            let postResponse = try! JSONSerialization.jsonObject(with: postData!) as! [[String : Any]]
            
            for eachResponse in postResponse
            {
                let postDictionary = eachResponse as! [String : Any]
                let postUserId = postDictionary["userId"] as! Int
                let postId = postDictionary["id"] as! Int
                let postTitle = postDictionary["title"] as! String
                let postCompleted = postDictionary["completed"] as! Bool
                
                let postObject = Post(userId: postUserId, id: postId, title: postTitle, completed: postCompleted)
                
                self.post.append(postObject)
            }
            DispatchQueue.main.async {
                self.postCollectionView.reloadData()
            }
            
        }
        postDataTask.resume()
        
}
    
    

}
extension ViewController : UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

}
extension ViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        post.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCollectionViewCell = self.postCollectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        
        postCollectionViewCell.userIdLabel.text = String(post[indexPath.item].userId)
        postCollectionViewCell.idLabel.text = String(post[indexPath.item].id)
        postCollectionViewCell.titleLabel.text = post[indexPath.item].title
        postCollectionViewCell.completedLabel.text = String(post[indexPath.item].completed)
        
        return postCollectionViewCell
    }
    
    
}
extension ViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let spaceBetweenTheCell : CGFloat = (flowLayout.minimumInteritemSpacing ?? 0.0) + (flowLayout.sectionInset.left ?? 0.0) + (flowLayout.sectionInset.right ?? 0.0)
        
        let size = (self.postCollectionView.frame.width - spaceBetweenTheCell) / 2
        
        return CGSize(width: size, height: size)
    }
}

    

