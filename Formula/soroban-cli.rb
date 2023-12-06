class SorobanCli < Formula
  desc "CLI for interacting with and deploying to Soroban"
  homepage "https://soroban.stellar.org"
  url "https://github.com/stellar/soroban-tools.git", tag: "v20.0.0"
  head "https://github.com/stellar/soroban-tools.git", branch: "main"

  depends_on "rust" => :build

  def install
    chdir "cmd/soroban-cli" do
      system "cargo", "install", "--bin=soroban", *std_cargo_args
    end
  end

  test do

    assert_match "soroban 20.0.0", shell_output("#{bin}/soroban version")
  end
end
