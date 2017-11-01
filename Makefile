PYTHON_VER=$(CNTK_PYTHON_VERSION)
OS=$(CNTK_OS_TYPE)
TYPE=$(CNTK_TYPE)
VERSION=$(CNTK_VERSION)
DOCKERFILE_PATH=./$(OS)/version_$(VERSION)/$(TYPE)/runtime/python-$(PYTHON_VER)
DOCKER_ACCOUNT=$(CNTK_DOCKER_ACCOUNT)
DOCKER_TAG=$(CNTK_TAG)

all: cntk

cntk:
	docker build -t $(DOCKER_ACCOUNT)/cntk "$(DOCKERFILE_PATH)"
	docker tag "$(DOCKER_ACCOUNT)/cntk" $(DOCKER_ACCOUNT)/cntk:$(DOCKER_TAG)

clean:
	docker rmi -f $$(docker images -a | grep "${DOCKER_ACCOUNT}/cntk" | awk '{print $3}') > /dev/null 2>&1 ;true
