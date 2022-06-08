//
//  TriviaGame.swift
//  pokemonTrivia
//
//  Created by noam muallem on 27/05/2022.
//

import UIKit
import Material
class GameViewController: UIViewController{
    
    @IBOutlet weak var btnA1: UIButton!
    @IBOutlet weak var btnA2: UIButton!
    @IBOutlet weak var btnA3: UIButton!
    @IBOutlet weak var btnA4: UIButton!
    
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreCounter: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    let URL_ = "https://pastebin.com/raw/T2qAz7eq"
    var questions: [Question] = []
    var round:Int = 0
    var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        print(questions);
        while questions.isEmpty{}
        nextQuestion()
        
    }
    @IBAction func chooseAnswer1(_ sender: Any) {
        chooseAnAnswer(answerIndex:1);
    }
    
    @IBAction func chooseAnswer2(_ sender: Any) {
        chooseAnAnswer(answerIndex:2);
    }
    
    @IBAction func chooseAnswer3(_ sender: Any) {
        chooseAnAnswer(answerIndex:3);
    }
    
    @IBAction func chooseAnswer4(_ sender: Any) {
        chooseAnAnswer(answerIndex:4);
    }
    
    func chooseAnAnswer(answerIndex:Int) {
        if questions[round-1].rightAnswer == answerIndex{
            score += 1
            scoreCounter.text = "Score: \(score)"
        }
        if round < 15 {
            nextQuestion()
            progressBar.progress = Float(round)/Float(questions.count)
        }else{
            print("returrning to homeview");
            returnToHomeView();
        }
        roundLabel.text = "Round \(round)/\(questions.count)"
    }
    
    func returnToHomeView(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        vc.score = score
        present(vc, animated: true)
    }


    func nextQuestion(){
        let url = URL(string: questions[round].imageUrl)
        let imageData = try? Data(contentsOf: url!)
        let loadedImage = UIImage(data: imageData!)
        pokemonImage.image = loadedImage;

        btnA1.setTitle(questions[round].answer1, for: .normal)
        btnA2.setTitle(questions[round].answer2, for: .normal)
        btnA3.setTitle(questions[round].answer3, for: .normal)
        btnA4.setTitle(questions[round].answer4, for: .normal)
        round += 1
    }
    
    func parseJson(){
        if let url = URL(string: URL_) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let parsedJSON = try jsonDecoder.decode(Questions.self, from: data)
                        for q in parsedJSON.questions {
                            print(q);
                            self.questions.append(Question(imageUrl: q.imageUrl, answer1: q.answer1, answer2: q.answer2,answer3: q.answer3,answer4: q.answer4, rightAnswer: q.rightAnswer));
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
