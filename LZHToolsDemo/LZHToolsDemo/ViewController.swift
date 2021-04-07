//
//  ViewController.swift
//  LZHToolsDemo
//
//  Created by QD202010282474A on 2021/4/2.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


          let textView = UITextView(frame:CGRect(x:10, y:20, width:300, height:100))
          //要显示的文字
          let str = "欢迎访问hangge.com 欢迎访问hangge.com 欢迎访问hangge.com"
          //通过富文本来设置行间距
          let paraph = NSMutableParagraphStyle()
          //将行间距设置为28
          paraph.lineSpacing = 20
          //样式属性集合
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),
                          NSAttributedString.Key.paragraphStyle: paraph]
          textView.attributedText = NSAttributedString(string: str, attributes: attributes)
          self.view.addSubview(textView)

    }


}

