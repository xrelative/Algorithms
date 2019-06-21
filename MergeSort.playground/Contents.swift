import Foundation

func merge<T: Comparable>(array: inout [T], startIndex: Int, middleIndex: Int, endIndex: Int) {
    let leftSubarray = Array(array[startIndex...middleIndex])
    let rightSubarray = Array(array[middleIndex + 1...endIndex])

    var index = startIndex
    var leftIndex = 0
    var rightIndex = 0

    while leftIndex < leftSubarray.count && rightIndex < rightSubarray.count {
        if leftSubarray[leftIndex] < rightSubarray[rightIndex] {
            array[index] = leftSubarray[leftIndex]
            leftIndex += 1
        } else {
            array[index] = rightSubarray[rightIndex]
            rightIndex += 1
        }
        index += 1
    }

    /* Copy the remaining elements of leftSubarray, if there are any */
    while leftIndex < leftSubarray.count {
        array[index] = leftSubarray[leftIndex]
        leftIndex += 1
        index += 1
    }

    /* Copy the remaining elements of rightSubarray, if there are any */
    while rightIndex < rightSubarray.count {
        array[index] = rightSubarray[rightIndex]
        rightIndex += 1
        index += 1
    }
}

func mergeSort<T: Comparable>(array: inout [T], startIndex: Int, endIndex: Int) {
    guard startIndex < endIndex else { return }
    let middleIndex = (startIndex + endIndex)/2
    mergeSort(array: &array, startIndex: startIndex, endIndex: middleIndex)
    mergeSort(array: &array, startIndex: middleIndex + 1, endIndex: endIndex)
    merge(array: &array, startIndex: startIndex, middleIndex: middleIndex, endIndex: endIndex)
}

func mergeSort<T: Comparable>(array: inout [T]) {
    mergeSort(array: &array, startIndex: 0, endIndex: array.count-1)
}

let arraySize = 1000
var array: [Int] = [] // [3, 5, 4, 6, 1, 2]
for _ in 0..<arraySize {
    array.append(Int.random(in: 0..<Int.max))
}

let start = DispatchTime.now()
mergeSort(array: &array)
let end = DispatchTime.now()

let timeInterval = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000
print("Time: \(timeInterval) seconds")

