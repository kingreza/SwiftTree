//Node definition
class Node
{
    var left: Node?;
    var right: Node?;
    var value: Int?;
    
    init(nodeValue: Int)
    {
        value = nodeValue;
    }
    init(){}
}

//create a binary search tree based on the input in array
func createBSTree(input: [Int]) -> Node
{
    var root = Node();
    for value in input
    {
        insertToBST(value, root)
    }
    return root;
}

//insert node to binary search tree
func insertToBST(value: Int, root: Node)
{
    if let currentValue = root.value
    {
        if (value < currentValue)
        {
            if let left = root.left
            {
                insertToBST(value, left);
            }else
            {
                root.left = Node(nodeValue: value);
            }
        }
        if (value > currentValue)
        {
            if let right = root.right
            {
                insertToBST(value, right)
                
            }else
            {
                root.right = Node(nodeValue: value)
            }
        }
    }else
    {
        root.value = value;
    }
}

//number of nodes on the longest path from the root
//explanation http://www.geeksforgeeks.org/diameter-of-a-binary-tree/
func heightOfTree(root: Node) -> Int
{
    var sizeOfLeft = 0;
    if let left = root.left
    {
        sizeOfLeft = heightOfTree(left) + 1;
    }
    
    var sizeOfRight = 0;
    if let right = root.right
    {
        sizeOfRight = heightOfTree(right) + 1;
    }
    
    return max(sizeOfRight, sizeOfLeft);
}

//number of nodes in a tree
func sizeOfTree(root: Node?) -> Int
{
    if let node = root
    {
        return sizeOfTree(node.left) + sizeOfTree(node.right) + 1;
    }
    else
    {
        return 0;
    }
}

//calculate the distance between the two furthest nodes
//explanation http://www.geeksforgeeks.org/diameter-of-a-binary-tree/
func diameterOfTree(root: Node?, inout height: Int) -> Int
{
    var leftHeight = 0;
    var rightHeight = 0;
    if let node = root
    {
        var left = diameterOfTree(node.left, &leftHeight);
        var right = diameterOfTree(node.right, &rightHeight);
        
        height = max(leftHeight, rightHeight) + 1;
        
        return max(leftHeight + rightHeight + 1, max(left, right));
    }
    return 0;
}

//find node based on value
func findNode(value: Int, root: Node?) -> Node?
{
    if let node = root
    {
        if value == node.value
        {
            return node;
        }
        if value > node.value
        {
            return findNode(value, node.right);
        }
        if value < node.value
        {
            return findNode(value, node.left);
        }
    }
    return nil;
}

//return right most node in the tree
func largestNode(root: Node?) -> Node?
{
    if let node = root
    {
        if (node.right == nil)
        {
            return node;
        }else
        {
            return largestNode(node.right);
        }
    }
    return nil;
}

//delete node from tree
//explanation http://www.algolist.net/Data_structures/Binary_search_tree/Removal
// http://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/code/BST.java
func deleteNode(value: Int, var root: Node?, parent: Node?)
{
    if let node = root
    {
        if value < node.value
        {
            deleteNode(value, node.left, node);
        }
        
        if value > node.value
        {
            deleteNode(value, node.right, node);
        }
        
        if node.value == value
        {
            if (node.left != nil) && (node.right != nil)
            {
                var rightMost = largestNode(node);
                var temp = rightMost!.value;
                deleteNode(temp!, node, parent);
                node.value = temp;
                return;

            }
            
            if node.left != nil && node.right == nil
            {
                
                if let parentNode = parent
                {
                    if parentNode.left != nil && parentNode.left === node
                    {
                        parentNode.left = node.left;
                    }
                    
                    if parentNode.right != nil && parentNode.right === node
                    {
                        parentNode.right = node.left;
                    }
                }else
                {
                    root = node.left;
                }
                return;
            }
            
            if node.right != nil && node.left == nil
            {
                if let parentNode = parent
                {
                    if parentNode.left != nil && parentNode.left === node
                    {
                        parentNode.left = node.right;
                    }
                    
                    if parentNode.right != nil && parentNode.right === node
                    {
                        parentNode.right = node.right;
                    }
                }else
                {
                    root = node.right;
                }
                return;
            }
            
            if node.left == nil && node.right == nil
            {
                if let parentNode = parent
                {
                    if parentNode.left != nil && parentNode.left === node
                    {
                        parentNode.left = nil;
                    }
                    
                    if parentNode.right != nil && parentNode.right === node
                    {
                        parentNode.right = nil;
                    }
                }else
                {
                    root = nil;
                }
                return;
            }
        }
    }
}

//preorder traversal of the tree
func printTreePreOrder (root: Node)
{
    if let value = root.value
    {
        println(value);
    }
    
    if let left = root.left
    {
        printTreePreOrder(left);
    }
    
    if let right = root.right
    {
        printTreePreOrder(right);
    }
}

//inorder traversal of the tree
func printTreeInOrder (root: Node)
{
    if let left = root.left
    {
        printTreePreOrder(left);
    }
    
    if let value = root.value
    {
        println(value);
    }
    
    if let right = root.right
    {
        printTreePreOrder(right);
    }
}

//post order traversal of the tree
func printTreePostOrder (root: Node)
{
    if let left = root.left
    {
        printTreePreOrder(left);
    }
    
    if let right = root.right
    {
        printTreePreOrder(right);
    }
    
    if let value = root.value
    {
        println(value);
    }
}

//sample data
var values = [5,4,11,7,6,14,1,0,9,8];

//create tree
var tree = createBSTree(values);

//print tree using different traversals
printTreePreOrder(tree);
println("*****")
printTreeInOrder(tree);
println("*****")
printTreePostOrder(tree);

//calculate height of tree
heightOfTree(tree);

//calculate number of nodes
sizeOfTree(tree);

//find node in tree and return it;
var node = findNode(1, tree);

//calculate diameter of tree
var h = 0;
diameterOfTree(tree, &h);

//find largest node in tree
largestNode(tree);

//delete node
deleteNode(11, tree, nil);
printTreePreOrder(tree);
println("*****")

//delete node
deleteNode(0, tree, nil);

printTreePreOrder(tree);
println("*****")


