class StellarCoreFuturenet < Formula
  desc "Futurenet build of Stellar Core including Soroban"
  homepage "https://github.com/stellar/stellar-core"
  url "https://github.com/stellar/stellar-core.git",
      revision: "064a2787acb9e98c70567523785333581ee1ffa4"
  version "0"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bison" => :build # Bison 3.0.4+
  depends_on "libtool" => :build
  depends_on "pandoc" => :build
  depends_on "pkg-config" => :build
  depends_on "parallel" => :test
  depends_on "libpq"
  depends_on "libpqxx"
  depends_on "libsodium"
  depends_on macos: :catalina # Requires C++17 filesystem
  depends_on "rust"
  uses_from_macos "flex" => :build

  on_linux do
    depends_on "libunwind"
  end

  # https://github.com/stellar/stellar-core/blob/master/INSTALL.md#build-dependencies
  fails_with :gcc do
    version "7"
    cause "Requires C++17 filesystem"
  end

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--disable-tests",
                          "--enable-postgres",
                          "--enable-next-protocol-version-unsafe-for-production"
    system "make", "install"
  end

  test do
    # To generate this version string, run `git describe --always --dirty --tags` in
    # your stellar-core repo with the released core revision checked out. BUT SEE NOTE BELOW.
    # NOTE: The version was taken from the PR where this assert failed. The command mentioned above will
    # give you the right string, but it looks like the last char is removed and there's a newline
    # because stellar-core version returns more info. Related to https://github.com/stellar/homebrew-tap/issues/15,
    # which is why we missed assert mismatches.
    assert_match "v19.8.0-35-g064a2787", shell_output("#{bin}/stellar-core version | head -n 1")
    assert_match "soroban-env-host", shell_output("#{bin}/stellar-core version")
    assert_match "Secret seed", shell_output("#{bin}/stellar-core gen-seed")
  end
end
