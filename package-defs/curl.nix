let flags = [
"--disable-ares"
"--disable-ldap"
"--disable-ldaps"
"--disable-manual"
"--disable-websockets"
"--enable-versioned-symbols"
"--with-ca-fallback"
"--without-gssapi"
"--with-libssh2=${pkgs}.libssh2"
"--with-openssl=${pkgs}.openssl"
"--without-brotli"
"--without-gnutls"
"--without-libidn2"
"--without-libpsl"
"--without-librtmp"
"--without-nghttp3"
"--without-ngtcp2"
"--without-rustls"
"--without-zstd"
]
in


curlMinimal = pkgs.curlMinimal.overrideAttrs {configureFlags = flags;}
curl = pkgs.curl.overrideAttrs {configureFlags = flags;}
# .configureFlags
