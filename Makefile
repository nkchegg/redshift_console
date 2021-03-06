VERSION=$(shell python -m redshift_console version)

deps:
	npm install -g gulp bower
	npm install
	bower install

bump_version:
	bumpversion $(PART)

clean:
	rm -rf 27-sdist
	rm -rf build
	rm -rf dist
	rm -rf redshift_console.egg-info

build_package:
	gulp build
	python setup.py sdist

test_package:
	rm -rf 27-sdist
	virtualenv 27-sdist
	27-sdist/bin/pip install dist/redshift-console-$(VERSION).tar.gz
	27-sdist/bin/redshift-console version
	rm -rf 27-sdist

update_package_description:
	python setup.py register

upload_package:
	python setup.py sdist upload
