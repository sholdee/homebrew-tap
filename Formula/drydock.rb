class Drydock < Formula
  desc "Inspect your Argo CD fleet without getting wet"
  homepage "https://github.com/sholdee/drydock"
  version "0.4.3"
  license "Apache-2.0"

  host_cpu = RbConfig::CONFIG.fetch("host_cpu")
  host_os = RbConfig::CONFIG.fetch("host_os")

  if host_os.include?("linux") && ["aarch64", "arm64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_linux-arm64.tar.gz"
    sha256 "2025fee5590090c997c9813b7a4ec97e648b598055300073c5b4ab382d868181"
  elsif host_os.include?("linux") && ["amd64", "x86_64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_linux-amd64.tar.gz"
    sha256 "9be79854c3569137c959a96179a8b3c5a84d1716ce2b8284d08b4b338ec892a4"
  elsif ["aarch64", "arm64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_darwin-arm64.tar.gz"
    sha256 "ae6f57c8e70258caeef272cb0d62a63cac150a873a83bb83013ef0ce3d4c7f20"
  elsif ["amd64", "x86_64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_darwin-amd64.tar.gz"
    sha256 "71a2b4d7fddb06153967c186abf988fdbc38f1bc65e1f8d75787fd9acf3299ac"
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
