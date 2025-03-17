//
//  HomeVM.swift
//  SocialSpace
//
//  Created by Вадим Игнатенко on 16.03.25.
//

import UIKit
import CoreData

final class HomeVM {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var postsFromCoreData: [PostModelForCD] = []

    
    private func checkStattusLike(id: Int) -> Bool {
        let checkPost = postsFromCoreData.first { $0.id == Int16(id) }
        return checkPost?.like ?? false
    }
    
    private func fromNetInCoreData(netValue: Post) -> PostModelForCD {
        let coreDataValue = PostModelForCD(context: self.context)
        coreDataValue.id = Int16(netValue.id)
        coreDataValue.userId = Int16(netValue.userId)
        coreDataValue.title = netValue.title
        coreDataValue.body = netValue.body
        coreDataValue.like = checkStattusLike(id: netValue.id)
        return coreDataValue
    }
    
    func getContentFromCoreData(completion: @escaping ()->()) {
        CoreDataService.shared.requetCoreData(with: PostModelForCD.fetchRequest()) { [weak self] result in
            DispatchQueue.main.async {
                self?.postsFromCoreData = result
                self?.postsFromCoreData.sort { $0.id < $1.id }
                completion()
            }
        }
    }
    
    func getContentFromNet(completion: @escaping ()->()) {
        Networkservice.shared.getPosts { [weak self] result, _ in
            guard let self else { return }
            var postsFronNet: [PostModelForCD] = []
            if let result {
                result.forEach {
                    postsFronNet.append(self.fromNetInCoreData(netValue: $0))
                }
                postsFronNet.sort { $0.id < $1.id }
                self.postsFromCoreData = postsFronNet
                CoreDataService.shared.saveData()
                completion()
            }
        }
    }
    
    func likeOrDislikePost(post: PostModelForCD) {
        post.like.toggle()
        CoreDataService.shared.saveData()
    }
    
}
