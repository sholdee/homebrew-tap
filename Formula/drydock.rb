class Drydock < Formula
  desc "Inspect your Argo CD fleet without getting wet"
  homepage "https://github.com/sholdee/drydock"
  version "0.3.6"
  license "Apache-2.0"

  host_cpu = RbConfig::CONFIG.fetch("host_cpu")
  host_os = RbConfig::CONFIG.fetch("host_os")

  if host_os.include?("linux") && ["aarch64", "arm64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_linux-arm64.tar.gz"
    sha256 "430cbd940f3a914b52633f6147cc513bc2c36292d00cd215c920511fb099a02b"
  elsif host_os.include?("linux") && ["amd64", "x86_64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_linux-amd64.tar.gz"
    sha256 "fb44b390080136728caed2bc911a20c3b86fe44b36b71d4eaaa69e8ac294bde1"
  elsif ["aarch64", "arm64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_darwin-arm64.tar.gz"
    sha256 "1f953f4aa293582942f881d6194fbdf1a2351537191ee921592a0a5df2d377eb"
  elsif ["amd64", "x86_64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_darwin-amd64.tar.gz"
    sha256 "82be63ffaab2660a77b0a7bc01315d60ffe8495e3392f5ab0ddeb6e4122f3d2f"
  else
    odie "drydock supports macOS and Linux on amd64 or arm64"
  end

  def install
    bin.install "drydock"
    generate_completions_from_executable bin/"drydock", "completion"
  end

  test do
    assert_match "version: v#{version}", shell_output("#{bin}/drydock version")
    assert_match "completion", shell_output("#{bin}/drydock completion --help")
  end
end
