all: test
TEST?=./...

.PHONY: ci deps test alldeps updatedeps maze bench testsetup

deps:
	@go get -v -d ./...

alldeps:
	@go get -v -d -t ./...

updatedeps:
	@go get -v -d -u ./...

test: alldeps
	@go test . ./errors ./sessions ./headers; \
	@go vet 2>/dev/null ; if [ $$? -eq 3 ]; then \
		go get golang.org/x/tools/cmd/vet; \
	fi
	@go vet $(TEST) ; if [ $$? -eq 1 ]; then \
		echo "go-vet: Issues running go vet ./..."; \
		exit 1; \
	fi

maze:
	@bundle exec bugsnag-maze-runner

ci: alldeps test

bench:
	@go test --bench=.*

testsetup:
	@gem update --system
	@gem install bundler
	@bundle install
