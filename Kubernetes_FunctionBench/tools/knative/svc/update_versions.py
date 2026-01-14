import glob
import sys
import re

def update_yaml_files(version):
    # Specify the path to your YAML files
    yaml_files = glob.glob('/home/users/filiadis/kube_functionbench/vitaminv/tools/knative/svc/*.yml')

    for file_path in yaml_files:
        with open(file_path, 'r') as file:
            content = file.read()

        updated_content = re.sub(
            r'-\s*image:\s*ghcr\.io/arkountos/vitaminv-([^-]+(?:-[^-]+)*)\s*:\s*0\.0\.\d+',
            f'- image: ghcr.io/arkountos/vitaminv-\\1:0.0.{version}',
            content
        )

        # Update any benchmark names in the format name: vitaminv-<benchmark_name>-ubuntu-<version>
        updated_content = re.sub(r'name:\s*vitaminv-([^-]+(?:-[^-]+)*)-ubuntu-\d+', f'name: vitaminv-\\1-ubuntu-{version}', updated_content)

        with open(file_path, 'w') as file:
            file.write(updated_content)

    print(f"Version updated to 0.0.{version} for all benchmarks in YAML files.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python update_version.py <version_number>")
        sys.exit(1)

    version_number = sys.argv[1]
    update_yaml_files(version_number)
