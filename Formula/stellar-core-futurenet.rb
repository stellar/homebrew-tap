class StellarCoreFuturenet < Formula
  desc "Stellar Core including Soroban compiled for Futurenet"
  homepage "https://github.com/stellar/stellar-core"
  url "https://github.com/stellar/stellar-core.git",
      # The version of stellar-core actually deployed to Futurenet is
      # b3a6bc28116e80bff7889c2f3bcd7c30dd1ac4d6, however this revision adds a
      # couple of compatible improvements that are helpful.
      revision: "776cb5110af84783c63a7cf1a50dc9cbf4b311d9"
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
  depends_on "rust"
  depends_on macos: :catalina # Requires C++17 filesystem
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
    assert_match "v19.6.0-8-g776cb511", shell_output("#{bin}/stellar-core version")
    assert_match "soroban-env-host", shell_output("#{bin}/stellar-core version")
    assert_match "Secret seed", shell_output("#{bin}/stellar-core gen-seed")
  end
end
