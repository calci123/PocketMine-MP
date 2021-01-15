VERSION="$1"

sudo apt update && sudo apt install -y \
	re2c \
	libtool \
	libtool-bin \
	zlib1g-dev \
	libcurl4-openssl-dev \
	libxml2-dev \
	libyaml-dev \
	libgmp-dev \
	libzip-dev \
	libssl-dev

INSTALL_DIR="$(pwd)/bin/php7"

export CFLAGS="$CFLAGS -march=x86-64"
export CXXFLAGS="$CXXFLAGS -march=x86-64"

git clone https://github.com/php-build/php-build.git
cd php-build
./install-dependencies.sh
echo '"pthreads",,"https://github.com/pmmp/pthreads.git",,,"extension",' >> share/php-build/extension/definition
PHP_BUILD_INSTALL_EXTENSION='pthreads=@bc16ee7b5a21faee9bd1743f830f7135b763fb56 yaml=2.2.0' PHP_BUILD_ZTS_ENABLE=on ./bin/php-build "$VERSION" "$INSTALL_DIR"
