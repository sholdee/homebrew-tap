class Drydock < Formula
  desc "Inspect your Argo CD fleet without getting wet"
  homepage "https://github.com/sholdee/drydock"
  version "0.1.12"
  license "Apache-2.0"

  host_cpu = RbConfig::CONFIG.fetch("host_cpu")
  host_os = RbConfig::CONFIG.fetch("host_os")

  if host_os.include?("linux") && ["aarch64", "arm64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_linux-arm64.tar.gz"
    sha256 "ac2acafa82cde221e8290177e7c349d159b42a9c7e52e8cc4835c45daedf69bd"
  elsif host_os.include?("linux") && ["amd64", "x86_64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_linux-amd64.tar.gz"
    sha256 "8e5e5b615fa448aa40a694638d6e69496d3f39268fa137a24b28ce5b9b30f5ce"
  elsif ["aarch64", "arm64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_darwin-arm64.tar.gz"
    sha256 "35738415254d740926fd9ff49adcd76a9634ab3da705db48dd62982cae359c30"
  elsif ["amd64", "x86_64"].include?(host_cpu)
    url "https://github.com/sholdee/drydock/releases/download/v#{version}/drydock_darwin-amd64.tar.gz"
    sha256 "11055df60aec48ed6c66440406f3ba566f5a7480832ff980eda0232a18c931bb"
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
