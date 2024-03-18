{ lib
, stdenv
, cmake
, doxygen
, boost
, eigen
, jrl-cmakemodules
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "eiquadprog";
  version = "1.2.7";

  src = ./.;

  strictDeps = true;

  buildInputs = [
    jrl-cmakemodules
  ];

  nativeBuildInputs = [
    cmake
    doxygen
  ];

  propagatedBuildInputs = [
    boost
    eigen
  ];

  cmakeFlags = [
    "-DINSTALL_DOCUMENTATION=ON"
  ];

  doCheck = true;

  outputs = [ "dev" "out" "doc" ];

  meta = with lib; {
    description = "C++ reimplementation of eiquadprog";
    homepage = "https://github.com/stack-of-tasks/eiquadprog";
    license = licenses.bsd2;
    maintainers = with maintainers; [ nim65s ];
    platforms = platforms.unix;
  };
})

