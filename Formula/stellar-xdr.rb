class StellarXdr < Formula
  version "0.0.11"
  url "https://github.com/stellar/rs-stellar-xdr.git", tag: "v0.0.11"
  head "https://github.com/stellar/rs-stellar-xdr.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--features=cli", *std_cargo_args
  end

  test do
    system "stellar-xdr", "version"
  end
end
