//
//  FactsViewController.swift
//  InterestingNumbers
//
//  Created by Екатерина Токарева on 11/03/2023.
//

import UIKit

final class FactPageViewController: UIPageViewController {    
    private var facts: [NumberFact] = []
    private let pageControl = UIPageControl()
    weak var factDataDelegate: FactDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 128/255, green: 54/255, blue: 204/255, alpha: 1)
        dataSource = self
        delegate = self
        if let firstViewController = viewControllerAtIndex(0) {
            setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
        }
        pageControl.numberOfPages = facts.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
        
    private func viewControllerAtIndex(_ index: Int) -> FactViewController? {
        guard index >= 0 && index < facts.count else { return nil }
        let factVC = FactViewController()
        factVC.delegate = self
        self.factDataDelegate = factVC
        let fact = NumberFact(text: facts[index].text, number: facts[index].number)
        factDataDelegate?.didReceiveFacts(fact: fact, factsDictionary: nil)
        return factVC
    }
    
    private func indexOfViewController(_ viewController: FactViewController) -> Int? {
        facts.firstIndex(where: { $0.number == viewController.getNumber() })
    }
}

extension FactPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let factVC = viewController as? FactViewController,
              let index = indexOfViewController(factVC),
              index > 0 else { return nil }
        return viewControllerAtIndex(index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let factVC = viewController as? FactViewController,
              let index = indexOfViewController(factVC),
              index < facts.count - 1 else { return nil }
        return viewControllerAtIndex(index + 1)
    }
}

extension FactPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = viewControllers?.first as? FactViewController,
              let index = indexOfViewController(currentVC) else { return }
        pageControl.currentPage = index
    }
}

extension FactPageViewController: FactDataDelegate {
    func didReceiveFacts(fact: NumberFact?, factsDictionary: [String : String]?) {
        if let fact = fact {
            self.facts.append(fact)
        } else if let factsDictionary = factsDictionary {
            for (key, value) in factsDictionary {
                if let number = Double(key) {
                    let fact = NumberFact(text: value, number: number)
                    self.facts.append(fact)
                    self.facts = self.facts.sorted { $0.number < $1.number }
                }
            }
        }
    }
}

extension FactPageViewController: FactViewControllerDelegate {
    func closeButtonTapped() {
        dismiss(animated: true)
    }
}
