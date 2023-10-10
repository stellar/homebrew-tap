class StellarXdr < Formula
  desc "CLI for encoding and decoding Stellar XDR"
  homepage "https://github.com/stellar/rs-stellar-xdr"
  url "https://github.com/stellar/rs-stellar-xdr.git", tag: "v20.0.0-rc1"
  head "https://github.com/stellar/rs-stellar-xdr.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--features=cli", *std_cargo_args
  end

  test do
    assert_match "stellar-xdr v20.0.0-rc1", shell_output("#{bin}/stellar-xdr version")
  end
end
