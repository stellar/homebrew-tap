class StellarCoreFuturenet < Formula
  desc "Futurenet build of Stellar Core including Soroban"
  homepage "https://github.com/stellar/stellar-core"
  url "https://github.com/stellar/stellar-core.git",
      revision: "875f47e247cefc25c8a4b3982ee65610e6a620e3"
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
    # your stellar-core repo with the released core revision checked out.
    assert_match "soroban-preview-10-July5", shell_output("#{bin}/stellar-core version")
    assert_match "soroban-env-host", shell_output("#{bin}/stellar-core version")
    assert_match "Secret seed", shell_output("#{bin}/stellar-core gen-seed")
  end
end
