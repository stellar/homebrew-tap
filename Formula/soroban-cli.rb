class SorobanCli < Formula
  desc "CLI for interacting with and deploying to Soroban"
  homepage "https://developers.stellar.org"
  url "https://github.com/stellar/soroban-cli.git", tag: "v20.3.4"
  head "https://github.com/stellar/soroban-cli.git", branch: "main"

  depends_on "rust" => :build

  def install
    chdir "cmd/soroban-cli" do
      system "cargo", "install", "--bin=soroban", *std_cargo_args
    end
  end

  test do
    assert_match "soroban 20.3.4", shell_output("#{bin}/soroban version")
  end
end
