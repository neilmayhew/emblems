{ stdenv, mkDerivation, base, bytestring, utf8-string, cmdargs, gio, gtk
}:

mkDerivation {
  pname = "emblems";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base bytestring utf8-string cmdargs gio gtk ];
  description = "A command-line utility for manipulating emblems on file icons";
  license = stdenv.lib.licenses.gpl3;
}
