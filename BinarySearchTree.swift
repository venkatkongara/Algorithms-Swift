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
    var parent:Node?
    var data:Int?

}

class BinarySearchTree: NSObject {

    let root = Node()

    init(array:[Int]) {
        super.init()
        createSuperBalancedTree(array)
    }

    private func createSuperBalancedTree(array:[Int]) {
        createSuperBalancedTreeFromSorted(array.sort())
    }

    private func createSuperBalancedTreeFromSorted(array:[Int]) {
        if array.count == 1 {
            insertData(array[0])
            return
        }
        if array.count == 0 {
            return
        }
        let centerIndex = Int(ceil(Double(array.count)/Double(2) - 1))
        insertData(array[centerIndex])
        
        var leftArray = [Int]()
        for i in 0..<centerIndex {
            leftArray.append(array[i])
        }
        var rightArray = [Int]()
        for i in centerIndex + 1...array.count - 1 {
            rightArray.append(array[i])
        }
        
        if leftArray.count > 0 {
            createSuperBalancedTree(leftArray)
        }
        if rightArray.count > 0 {
            createSuperBalancedTree(rightArray)
        }
    }

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
                right.parent = node
                insertUsingNode(right, num: num)
            }
            else {
                let right = Node()
                node.right = right
                right.parent = node
                right.data = num
            }
        }
        else {
            if let left = node.left {
                left.parent = node
                left.parent = node
                insertUsingNode(left, num: num)
            }
            else {
                let left = Node()
                node.left = left
                left.parent = node
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

    private func leftAndRightDepthsOfTreeFromNode(node:Node) -> (Int,Int){
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

    func printTree() {
        if root.data != nil {
            printNode(root,space: "")
        }
        else {
            print("no items found")
        }
    }

    private func printNode(node:Node,space:String) {
        let extraSpace = " "
        if let data = node.data {
            print(space + "\(data)")
        }
        if let left = node.left {
            printNode(left,space: space + extraSpace)
        }
        if let right = node.right {
            printNode(right,space: space + extraSpace)
        }
    }

    func remove(num:Int) {
        if root.data == num {
            root.data = nil
        } else {
            checkAndRemove(num, node: root)
        }
    }

    private func checkAndRemove(num:Int,node:Node){
        if node.data == num {
            if (node.left != nil && node.right == nil) || (node.left == nil && node.right != nil) {
                if node.parent?.left == node {
                    node.parent?.left = node.left
                }
                else {
                    node.parent?.right = node.right
                }
            }
            
            if node.left != nil && node.right != nil {
                node.parent?.left = node.right
                node.right?.parent = node.parent
                
                var tempNode = node.right
                while tempNode != nil {
                    if let tempLeft = tempNode?.left {
                        tempNode = tempLeft
                    }else {
                        break
                    }
                }
                tempNode?.left = node.left
            }
            if node.left == nil && node.right == nil {
                if node.parent?.left == node {
                    node.parent?.left = nil
                }
                else {
                    node.parent?.right = nil
                }
            }
            return
        }
        else {
            if num > node.data {
                if let right = node.right {
                    checkAndRemove(num,node: right)
                }
            }
            else {
                if let left = node.left {
                    checkAndRemove(num,node: left)
                }
            }
        }
        
    }

}
