class StellarXdr < Formula
  desc "CLI for encoding/decoding Stellar XDR"
  homepage "https://github.com/stellar/rs-stellar-xdr"
  url "https://github.com/stellar/rs-stellar-xdr.git", tag: "v0.0.11"
  head "https://github.com/stellar/rs-stellar-xdr.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/stellar/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dd15d4341de1e6b09f9667b8fafc69f95506db99ff017c532e5a1701618fc321"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--features=cli", *std_cargo_args
  end

  test do
    assert_match "stellar-xdr 0.0.11", shell_output("#{bin}/stellar-xdr version")
  end
end
