class SorobanCli < Formula
  desc "CLI for building for and interacting with the Stellar network"
  homepage "https://developers.stellar.org"
  url "https://github.com/stellar/stellar-cli.git", tag: "v21.2.0"
  head "https://github.com/stellar/stellar-cli.git", branch: "main"

  depends_on "rust" => :build
  depends_on "openssl@3"

  def install
    chdir "cmd/soroban-cli" do
      system "cargo", "install", "--bin=soroban", "--features=opt", *std_cargo_args
      system "cargo", "install", "--bin=stellar", "--features=opt", *std_cargo_args
    end
  end

  test do
    assert_match "stellar 21.2.0", shell_output("#{bin}/soroban version")
    assert_match "stellar 21.2.0", shell_output("#{bin}/stellar version")
  end
end
