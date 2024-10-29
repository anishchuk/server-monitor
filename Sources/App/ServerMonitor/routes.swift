import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        let output: String = await Terminal.run("df", args: "-H")
        return output
    }
}
