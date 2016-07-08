import Champagne

let kernel = AppKernel()

do {
  let application = Application(
    kernel: kernel,
    config: Config(root: "Sources/Demo")
  )

  try application.start()
} catch {
  print(error)
}
