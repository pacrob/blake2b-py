test_rust:
	@echo ~~~~~~~~~~~~~~~ Running rust implementation unit tests ~~~~~~~~~~~~~~~
	cargo test --release \
		test_

test_rust_eip_152_vec_8:
	@echo ~~~~~~~~~~~~~~~ Running slow EIP 152 test vector 8 ~~~~~~~~~~~~~~~
	cargo test --release \
		test_blake2b_compress_eip_152_vec_8 \
		-- --ignored --nocapture

bench_rust:
	@echo ~~~~~~~~~~~~~~~ Running rust implementation benchmarks ~~~~~~~~~~~~~~~
	cargo bench

test_python:
	@echo ~~~~~~~~~~~~~~~ Running python binding tests ~~~~~~~~~~~~~~~
	tox

test_all: test_rust test_rust_eip_152_vec_8 bench_rust test_python

clean:
	rm -rf *.egg-info build dist target pip-wheel-metadata

build_docker:
	docker build \
		--tag=davesque/rust:nightly .
	docker build \
		--build-arg=PYTHON_VERSION=3.6 \
		--tag=davesque/rust:nightly-py36 .
	docker build \
		--build-arg=PYTHON_VERSION=3.7 \
		--tag=davesque/rust:nightly-py37 .

push_docker:
	docker push davesque/rust:nightly
	docker push davesque/rust:nightly-py36
	docker push davesque/rust:nightly-py37

.PHONY: test_rust test_rust_eip_152_vec_8 bench_rust test_python test_all clean
