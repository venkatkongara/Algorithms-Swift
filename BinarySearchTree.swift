//
//  BinaryTree.swift
//  AlgorithmsSwift
//
//  Created by siva kongara on 12/2/16.
//  Copyright © 2016 venkat kongara. All rights reserved.
//

import Foundation

class Node: NSObject {

    var left:Node?
    var right:Node?
    var data:Int?

}

class BinarySearchTree: NSObject {
    
    let root = Node()
    
    func insertData(num:Int) {
        if root.data != nil {
            insertUsingNode(root, num: num)
        }else {
            root.data = num
        }
    }
    
    private func insertUsingNode(node:Node,num:Int) {
        if num == node.data {
            return
        }
        else if num > node.data {
            if let right = node.right {
                insertUsingNode(right, num: num)
            }
            else {
                let right = Node()
                node.right = right
                right.data = num
            }
        }
        else {
            if let left = node.left {
                insertUsingNode(left, num: num)
            }
            else {
                let left = Node()
                node.left = left
                left.data = num
            }
        }
    }
    
    func find(num: Int) -> Bool{
        if root.data != nil {
           return findUsingNode(root, num: num)
        }else {
            return false
        }
    }
    
    private func findUsingNode(node:Node,num:Int) -> Bool{
        var found = false
        if num == node.data {
            found = true
        }
        else if num > node.data {
            if let right = node.right {
                found = findUsingNode(right, num: num)
            }
        }
        else {
            if let left = node.left {
                found = findUsingNode(left, num: num)
            }
        }
        return found
    }
    
    func depthOfTree() -> Int{
        return max(leftAndRightDepthsOfTreeFromNode(root).0, leftAndRightDepthsOfTreeFromNode(root).1)
    }
    
    func depthOfTreeFromNode(node:Node) -> Int{
        return max(leftAndRightDepthsOfTreeFromNode(node).0, leftAndRightDepthsOfTreeFromNode(node).1)
    }
    
    func leftAndRightDepthsOfTreeFromNode(node:Node) -> (Int,Int){
        var depth = 0
        var leftDepth = 0
        var rightDepth = 0
        
        if node.data != nil {
            depth = 1
        }
        if let left = node.left {
            leftDepth = depth + leftAndRightDepthsOfTreeFromNode(left).0
        }
        if let right = node.right {
            rightDepth = depth + leftAndRightDepthsOfTreeFromNode(right).1
        }
        return (leftDepth,rightDepth)
    }
}