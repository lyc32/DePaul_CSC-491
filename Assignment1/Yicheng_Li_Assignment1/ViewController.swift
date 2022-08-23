//
//  ViewController.swift
//  Yicheng_Li_Assignment1
//
//  Created by mac on 2021/4/13.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var Size: UISegmentedControl!
    @IBOutlet weak var mode1: UISegmentedControl!
    @IBOutlet weak var mode2: UISegmentedControl!
    @IBOutlet weak var chart_view: UIView!
    @IBOutlet weak var sort: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func Sort(_ sender: UIButton)
    {
        for v in chart_view.subviews
        {
            v.removeFromSuperview()
        }
        let view1 = UIImageView(frame: CGRect(x: 5 ,  y: 45, width: self.view.frame.width, height: 200))
        let view2 = UIImageView(frame: CGRect(x: 5 ,  y: 300, width: self.view.frame.width, height: 200))
        chart_view.addSubview(view1)
        chart_view.addSubview(view2)
        let array_size = (Size.selectedSegmentIndex + 1)*16
        let height = 200
        let width  = chart_view.frame.width
        let bar_height = Int(height)
        let bar_width = (Int(width)/array_size) - 2
        var i = 0;
        let queue = DispatchQueue.global(qos: .userInteractive)
        var sort_array = [Int](repeating: 0, count: array_size)
        while(i<array_size)
        {
            sort_array[i] = (Int(arc4random()) % bar_height)
            i = i + 1
        }
        queue.async
        {
            while(i<array_size)
            {
                sort_array[i] = (Int(arc4random()) % bar_height)
                i = i + 1
            }
            DispatchQueue.main.async
            {
                switch self.mode1.selectedSegmentIndex
                {
                case 0: self.insertionSort (input_array: sort_array, view: view1, width: bar_width, height: bar_height,mode:1)
                case 1: self.selectionSort (input_array: sort_array, view: view1, width: bar_width, height: bar_height,mode:1)
                case 2: self.QuickSort (input_array: sort_array, view: view1, width: bar_width, height: bar_height,mode:1)
                case 3: self.merge_sort (input_array: sort_array, view: view1, width: bar_width, height: bar_height,mode:1)
                default:self.insertionSort (input_array: sort_array, view: view1, width: bar_width, height: bar_height,mode:1)
                }
                switch self.mode2.selectedSegmentIndex
                {
                case 0: self.insertionSort (input_array: sort_array, view: view2, width: bar_width, height: bar_height,mode:2)
                case 1: self.selectionSort (input_array: sort_array, view: view2, width: bar_width, height: bar_height,mode:2)
                case 2: self.QuickSort (input_array: sort_array, view: view2, width: bar_width, height: bar_height,mode:2)
                case 3: self.merge_sort (input_array: sort_array, view: view2, width: bar_width, height: bar_height,mode:2)
                default:self.selectionSort (input_array: sort_array, view: view2, width: bar_width, height: bar_height,mode:2)
                }
            }
        }
    }
    
    func selectionSort(input_array:[Int], view: UIView, width:Int,height:Int,mode:Int)
    {
        let queue = DispatchQueue.global(qos: .background)
        var array = [Int]();
        for index in 0..<input_array.count
        {
            array.append(input_array[index])
        }
        queue.async
        {
            var index = 0
            var bars = [UIView](repeating:view, count: array.count)
            for v in view.subviews
            {
                v.removeFromSuperview()
            }
            while(index < array.count)
            {
                DispatchQueue.main.async
                {
                    let viewRect = CGRect(x: (width+2)*index, y: array[index] , width: width, height: height-array[index])
                    if(mode == 1)
                    {
                        bars[index] = chart1(frame: viewRect)
                    }
                    else
                    {
                        bars[index] = chart2(frame: viewRect)
                    }
                    view.addSubview(bars[index])
                    index = index + 1
                }
                usleep(2000)
            }
            var i = 0
            while(i<array.count)
            {
                var j=i;
                var min = array[i];
                var index = i;
                while(j<array.count)
                {
                    if (min < array[j])
                    {
                        min = array[j]
                        index = j
                    }
                    j = j + 1;
                }
                var end = index
                while(end > i)
                {
                    array[end] = array[end-1]
                    end = end - 1
                }
                array[i] = min;
                
                var k = 0;
                let n = array.count;
                for v in view.subviews
                {
                    v.removeFromSuperview()
                }
                while( k < n)
                {
                    DispatchQueue.main.async
                    {
                        let viewRect = CGRect(x: (width+2)*k, y: array[k] , width: width, height: height-array[k])
                        if(mode == 1)
                        {
                            bars[k] = chart1(frame: viewRect)
                        }
                        else
                        {
                            bars[k] = chart2(frame: viewRect)
                        }
                        view.addSubview(bars[k])
                        k = k + 1
                    }
                    usleep(2000)
                }
                i = i + 1;
            }
        }
    }
   
    func insertionSort (input_array: [Int], view: UIView, width:Int,height:Int,mode:Int)
    {
        let queue = DispatchQueue.global(qos: .background)
        var array = [Int]();
        for index in 0..<input_array.count//copy array
        {
            array.append(input_array[index])
        }
        queue.async
        {
            var index = 0
            var bars = [UIView](repeating:view, count: array.count)
            for v in view.subviews
            {
                v.removeFromSuperview()
            }
            while(index < array.count)
            {
                DispatchQueue.main.async
                {
                    let viewRect = CGRect(x: (width+2)*index, y: array[index] , width: width, height: height-array[index])
                    if(mode == 1)
                    {
                        bars[index] = chart1(frame: viewRect)
                    }
                    else
                    {
                        bars[index] = chart2(frame: viewRect)
                    }
                    view.addSubview(bars[index])
                    index = index + 1
                }
                usleep(2000)
            }
            var i = 0;
            while(i<array.count)
            {
                var j = 0;
                while(j<i)
                {
                    if(array[j]<array[i])
                    {
                        var k = i;
                        let m = array[i]
                        while(k>j)
                        {
                            array[k] = array[k-1]
                            k = k - 1;
                        }
                        array[j] = m;
                    }
                    
                    j = j + 1;
                }
                var k = 0;
                let n = array.count;
                var bars = [UIView](repeating:view, count: array.count)
                for v in view.subviews
                {
                    v.removeFromSuperview()
                }
                while( k < n)
                {
                    DispatchQueue.main.async
                    {
                        let viewRect = CGRect(x: (width+2)*k, y: array[k] , width: width, height: height-array[k])
                        if(mode == 1)
                        {
                            bars[k] = chart1(frame: viewRect)
                        }
                        else
                        {
                            bars[k] = chart2(frame: viewRect)
                        }
                        view.addSubview(bars[k])
                        k = k + 1
                    }
                    usleep(2000)
                }
                i = i + 1;
            }
        }
    }

    func QuickSort (input_array:[Int], view: UIView, width:Int,height:Int,mode:Int)
    {
        let queue = DispatchQueue.global(qos: .background)
        var array = [Int]();
        let end = input_array.count - 1;
        let start = 0
        for index in 0..<input_array.count//copy array
        {
            array.append(input_array[index])
        }
        queue.async
        {
            var st = [Int]();
            
            if(start < end)
            {
                st.append(start);
                st.append(end);
            }
            var s = start
            var e = end
            var p:Int;
            
            while( st.count > 0)
            {
                e=st.popLast()!
                s=st.popLast()!
                var index=s;
                let target = array[e];
                var j = s
                while(j<e)
                {
                    if(array[j]>target)
                    {
                        let C1 = array[j]
                        array[j] = array[index]
                        array[index] = C1
                        index = index + 1;
                    }
                    j = j + 1;
                }
                let C2 = array[e]
                array[e] = array[index]
                array[index] = C2
                
                p = index;
                if(s<(p-1))
                {
                    st.append(s);
                    st.append(p-1);
                }
                if((p+1)<e)
                {
                    st.append(p+1);
                    st.append(e);
                }
                var k = 0;
                let n = array.count;
                var bars = [UIView](repeating:view, count: array.count)
                for v in view.subviews
                {
                    v.removeFromSuperview()
                }
                while( k < n)
                {
                    DispatchQueue.main.async
                    {
                        let viewRect = CGRect(x: (width+2)*k, y: array[k] , width: width, height: height-array[k])
                        if(mode == 1)
                        {
                            bars[k] = chart1(frame: viewRect)
                        }
                        else
                        {
                            bars[k] = chart2(frame: viewRect)
                        }
                        view.addSubview(bars[k])
                        k = k + 1
                    }
                    usleep(2000)
                }
            }
        }
    }
    
    func merge_sort(input_array: [Int], view: UIView, width:Int,height:Int,mode:Int)
    {
        var array = [Int]();
        for index in 0..<input_array.count
        {
            array.append(input_array[index])
        }
        let queue = DispatchQueue.global(qos: .background)
        queue.async
        {
            var step = 1;
            let n = array.count
            while (step < n)
            {
                var index = 0
                while (index < n - step)
                {
                    let left1 = index;
                    let left2 = index + step;
                    let leftLength = step;
                    var rightLength = leftLength;
                    
                    if (left2 + leftLength > n)
                    {
                        rightLength = n - left2;
                    }
                    else
                    {
                        rightLength = leftLength;
                    }
                    
                    var tempArr = [Int](repeating:0, count: n)
                    var i = left1
                    var j = left2
                    var k=0;
                    while ((i < leftLength+left1) && (j < left2+rightLength))
                    {
                        if (array[i] < array[j])
                        {
                            tempArr[k] = array[j];
                            k = k + 1;
                            j = j + 1;
                        }
                        else
                        {
                            tempArr[k] = array[i];
                            k = k + 1;
                            i = i + 1;
                        }
                    }
                    while (i != leftLength+left1)
                    {
                        tempArr[k] = array[i];
                        k = k + 1;
                        i = i + 1;
                    }
                    while (j != (left2+rightLength))
                    {
                        tempArr[k] = array[j];
                        k = k + 1;
                        j = j + 1;
                    }
                    i = left1
                    k = 0
                    while(i < left1+rightLength+leftLength)
                    {
                        array[i] = tempArr[k];
                        i = i + 1
                        k = k + 1
                    }
                    index = index + step*2
                }
                
                var k = 0;
                let n = array.count;
                var bars = [UIView](repeating:view, count: array.count)
                for v in view.subviews
                {
                    v.removeFromSuperview()
                }
                while( k < n)
                {
                    DispatchQueue.main.async
                    {
                        let viewRect = CGRect(x: (width+2)*k, y: array[k] , width: width, height: height-array[k])
                        if(mode == 1)
                        {
                            bars[k] = chart1(frame: viewRect)
                        }
                        else
                        {
                            bars[k] = chart2(frame: viewRect)
                        }
                        view.addSubview(bars[k])
                        k = k + 1
                    }
                    usleep(2000)
                }
                step = step * 2;
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        chart_view.frame =  CGRect(x:0, y: 100, width:self.view.frame.width, height:500)
        
        sort.frame = CGRect(x:10, y: 45, width:50, height:50)
        label.frame = CGRect(x:50, y: 50, width:40, height:40)
        Size.frame = CGRect(x:100, y: 50, width:200, height:40)
        
        mode1.frame = CGRect(x:10, y: 100, width:self.view.frame.width-20, height:40)
        mode1.selectedSegmentIndex = 0
        mode2.frame = CGRect(x:10, y: 350, width:self.view.frame.width-20, height:40)
        mode2.selectedSegmentIndex = 1
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}



class chart1: UIView
{
    override func draw(_ rect: CGRect)
    {
        UIColor.green.setFill()
        let path = UIBezierPath(rect: self.bounds)
        path.fill()
    }
}
class chart2: UIView
{
    override func draw(_ rect: CGRect)
    {
        UIColor.orange.setFill()
        let path = UIBezierPath(rect: self.bounds)
        path.fill()
    }
}

