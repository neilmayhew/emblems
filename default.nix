{ lib, mkDerivation, base, bytestring, utf8-string, cmdargs, gio, gtk3
}:

mkDerivation {
  pname = "emblems";
  version = "0.1.0.0";
  src = lib.cleanSource ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base bytestring utf8-string cmdargs gio gtk3 ];
  description = "A command-line utility for manipulating emblems on file icons";
  license = lib.licenses.gpl3;
}
