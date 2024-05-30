class StellarCli < Formula
  desc "CLI for interacting with and deploying to Stellar"
  homepage "https://developers.stellar.org/"
  url "https://github.com/stellar/stellar-cli.git", tag: "v20.3.4"
  head "https://github.com/stellar/stellar-cli.git", branch: "main"

  depends_on "rust" => :build

  def install
    chdir "cmd/stellar-cli" do
      system "cargo", "install", "--bin=stellar", *std_cargo_args
    end
  end

  test do
    assert_match "stellar 20.3.4", shell_output("#{bin}/stellar version")
  end
end
