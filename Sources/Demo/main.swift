import Flamingo

let kernel = AppKernel()

do {
  let application = try Application(
    kernel: kernel,
    config: Config(root: "Sources/Development")
  )

  try application.start()
} catch {
  print(error)
}
