//
//  HomeViewController.swift
//  pokemonTrivia
//
//  Created by noam muallem on 27/05/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lastScoreLbl: UILabel!
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastScoreLbl.text = "Final Score: \(score)"
    }
    @IBAction func startGame(_ sender: Any) {
        print("entered")
        let vc = storyboard?.instantiateViewController(withIdentifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

