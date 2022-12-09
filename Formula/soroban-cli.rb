class StellarXdr < Formula
  version "0.3.3"
  url "https://github.com/stellar/soroban-tools.git", tag: "v0.3.3"
  head "https://github.com/stellar/soroban-tools.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--bin=soroban", *std_cargo_args
  end

  test do
    system "soroban", "version"
  end
end
