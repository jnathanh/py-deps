A project for testing various solutions for python dependency management

## Useful commands

### What dependencies does __ project have?
```bash
package_name="requests"
curl https://pypi.org/pypi/"$package_name"/json | jq ".info.requires_dist"
```

### What requirements are not yet installed?
```bash
# uses the existing requirements file as a template for the output of the currently installed dependencies, then diffs that output with the requirements file
pip freeze -r requirements.txt | diff - requirements.txt

# output what pip would install if run
pip install -r requirements.txt --dry-run

# dry-run, but output machine-readable format (report to stdout, silence logs)
pip install -r requirements.txt --dry-run -qqq --report -
```

### What is installed, but different from requirements?
```bash
# uses the existing requirements file as a template for the output of the currently installed dependencies, then diffs that output with the requirements file
pip freeze -r requirements.txt | diff requirements.txt -
```

### Uninstall all packages

```bash
pip uninstall -y -r <(pip freeze)
```

### Add a package

```bash
package_name="requests"
echo "$package_name" >> requirements.txt
pip install -r requirements.txt
```

