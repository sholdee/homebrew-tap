class Drydock < Formula
  desc "Inspect your Argo CD fleet without getting wet"
  homepage "https://github.com/sholdee/drydock"
  version "0.2.9"
  license "Apache-2.0"

  host_cpu = RbConfig::CONFIG.fetch("host_cpu")
  host_os = RbConfig::CONFIG.fetch("host_os")

  if host_os.include?("linux") && ["aarch64", "arm64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_linux-arm64.tar.gz"
    sha256 "b9c4494e6019fb2f5a76535a1bd94773b6607b5a7e673e4596ce49aa6f58edb2"
  elsif host_os.include?("linux") && ["amd64", "x86_64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_linux-amd64.tar.gz"
    sha256 "d350234019597adf4daa9a4a010125902be0d2e01b0dfb8eaef53c1353ea1d57"
  elsif ["aarch64", "arm64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_darwin-arm64.tar.gz"
    sha256 "b04725de3612e7e44b4f5decc4421e84dd16af0dbbd68e547a58d61a7d21446e"
  elsif ["amd64", "x86_64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_darwin-amd64.tar.gz"
    sha256 "3679074baa0055fbe83a0c76c024c9b93be56b4ca72ae44d39fb38c62e8ea52a"
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
