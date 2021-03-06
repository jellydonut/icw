serve:
	dev_appserver.py .

upload: install
	appcfg.py update .

bump:
	vim +'/version:' app.yaml
	vim +'/__version__' icw/__init__.py
	vim HISTORY.md

install:
	../bin/pip install --upgrade -r requirements_local.txt
	../bin/pip install --upgrade -t lib -r requirements_gae.txt

logs:
	appcfg.py request_logs --append --severity=3 --include_all . logs.txt
	appcfg.py request_logs --append --severity=4 --include_all . logs.txt

clean:
	-rm -r .tox tests/.cache logs.txt

clean-all: clean
	../bin/pip freeze | xargs ../bin/pip uninstall -y
	find lib -not -name 'README.md' -delete

