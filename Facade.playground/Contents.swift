import UIKit

class Project {
    let title: String
    let description: String
    var deadline: Date?
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

protocol ClientResponsibilities: class {
    func createProposal(for project: Project)
    func sendPayment()
}

class Client: ClientResponsibilities {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func createProposal(for project: Project) {
        // Client creates a proposal
    }
    
    func sendPayment() {
        // Client sends payment to a company
    }
}

protocol ProductManagerResponsibilities: class {
    func setDeadline(date: Date)
    func acceptSketch()
    func acceptFinalDesign()
    func createTrello(for members: [Developer])
}

class ProductManager: ProductManagerResponsibilities {
    let name: String
    let project: Project
    
    init(name: String, project: Project) {
        self.name = name
        self.project = project
    }
    
    func setDeadline(date: Date) {
        // PM sets the deadline for the project
    }
    
    func acceptSketch() {
        // PM accepts a sketch from a designer
    }
    
    func acceptFinalDesign() {
        // PM accepts the final design from a designer
    }
    
    func createTrello(for members: [Developer]) {
        // PM creates a Trello board for developers
    }
}

protocol DesignerResponsibilities: class {
    func createSketch()
    func createFinalDesign()
}

class Designer: DesignerResponsibilities {
    let name: String
    let project: Project
    
    init(name: String, project: Project) {
        self.name = name
        self.project = project
    }
    
    func createSketch() {
        // Designer creates a sketch of the product
    }
    
    func createFinalDesign() {
        // Designer creates the final design
    }
}

protocol DeveloperResponsibilities: class {
    func startDevelopment()
}

class Developer: DeveloperResponsibilities {
    let name: String
    let project: Project
    
    init(name: String, project: Project) {
        self.name = name
        self.project = project
    }
    
    func startDevelopment() {
        // Developer starts working on the project
    }
}

class OrderFacade {
    let client: Client
    let productManager: ProductManager
    let designer: Designer
    let developers: [Developer]
    
    init(client: Client,
         productManager: ProductManager,
         designer: Designer,
         developers: [Developer]) {
        
        self.client = client
        self.productManager = productManager
        self.developers = developers
        self.designer = designer
    }
    
    public func placeOrder(project: Project) {
        client.createProposal(for: project)
        designer.createSketch()
        productManager.acceptSketch()
        productManager.setDeadline(date: Date())
        designer.createFinalDesign()
        productManager.acceptFinalDesign()
        client.sendPayment()
        
        developers.forEach {
            $0.startDevelopment()
        }
    }
}

let client = Client(name: "Some Large Company")
let project = Project(title: "New Big Project", description: "Confidential")
let productManager = ProductManager(name: "Steve", project: project)
let designer = Designer(name: "Johny", project: project)
let developer1 = Developer(name: "Steve", project: project)
let developer2 = Developer(name: "Craig", project: project)

let orderFacade = OrderFacade(client: client,
                              productManager: productManager,
                              designer: designer,
                              developers: [developer1, developer2])
orderFacade.placeOrder(project: project)
