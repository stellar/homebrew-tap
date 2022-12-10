class SorobanCli < Formula
  version "0.3.3"
  url "https://github.com/stellar/soroban-tools.git", tag: "v0.3.3"
  head "https://github.com/stellar/soroban-tools.git", branch: "main"

  depends_on "rust" => :build

  def install
    chdir "cmd/soroban-cli" do
      system "cargo", "install", "--bin=soroban", *std_cargo_args
    end
  end

  test do
    assert_match "soroban 0.3.3", shell_output("#{bin}/soroban version")
  end
end
