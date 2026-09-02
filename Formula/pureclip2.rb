class Pureclip2 < Formula
  desc "Detect protein-RNA interaction footprints from single-nucleotide CLIP-seq data"
  homepage "https://github.com/johan-stph/PureCLIP"
  url "https://github.com/johan-stph/PureCLIP/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "1986693320fe00ef3a998accd5f1d746b804713994d32daddec7598122a1ef1d"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "gsl"
  depends_on "libomp"

  def install
    mkdir "build" do
      system "cmake", "../src",
        "-DCMAKE_BUILD_TYPE=Release",
        "-DPURE_CLIP_VERSION=#{version}",
        "-DGSL_ROOT_DIR=#{Formula["gsl"].opt_prefix}",
        "-DCMAKE_PREFIX_PATH=#{Formula["boost"].opt_prefix}",
        *std_cmake_args
      system "make", "-j#{ENV.make_jobs}"
    end
    bin.install "build/pureclip" => "pureclip2"
    bin.install "build/winextract"
  end

  test do
    system "#{bin}/pureclip2", "--version"
  end
end
