

# Build command definitions
define build-server-cmd =
podman build --label "maintainer=bjwhite@fnal.gov" -t gm2-xrd-standalone img-build
endef

define build-server-nc-cmd =
podman build --label "maintainer=bjwhite@fnal.gov" --no-cache -t gm2-xrd-standalone img-build
endef

# Image build command declarations
build-server:
	$(build-server-cmd)

build-server-nc:
	$(build-server-nc-cmd)
