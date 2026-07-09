class Drydock < Formula
  desc "Inspect your Argo CD fleet without getting wet"
  homepage "https://github.com/sholdee/drydock"
  version "0.2.2"
  license "Apache-2.0"

  host_cpu = RbConfig::CONFIG.fetch("host_cpu")
  host_os = RbConfig::CONFIG.fetch("host_os")

  if host_os.include?("linux") && ["aarch64", "arm64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_linux-arm64.tar.gz"
    sha256 "8f678053d728d18a421b42fc555953a260a9bae5f1a91a0fb24d9033abb17ccf"
  elsif host_os.include?("linux") && ["amd64", "x86_64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_linux-amd64.tar.gz"
    sha256 "39a010402d4b6fe01597905840b4bb29c9f89b0bdad5c2c43c50663c2bb6cb43"
  elsif ["aarch64", "arm64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_darwin-arm64.tar.gz"
    sha256 "1e4f7a15a9e4a901f65e0e98a4d7338611c6de25b9cc066c66e302fa821b5eff"
  elsif ["amd64", "x86_64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_darwin-amd64.tar.gz"
    sha256 "5a49c12919ea24dd3efe841f6c93d93ab078db5eff1581c5f89c5157dbdcd4af"
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
