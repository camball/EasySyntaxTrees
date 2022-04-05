"""A simple script that adds brackets around each word in each line in a file.
When given a directory, it performs this action for each `.stree` file in the
directory."""
import os
from sys import argv

data_source = argv[1]

if len(argv) != 2:
    print("Usage: python3 addWordBrackets.py <path_to_directory>")
    exit(1)
elif not os.path.exists(data_source):
    print(f'"{argv[1]}" is not a file or directory.')
    exit(1)


def add_brackets(path_to_file: str) -> None:
    """Stores `path_to_file`'s contents in memory, adds brackets, then writes
    the modified text back to the original file."""
    with open(path_to_file, "r") as f:
        lines = f.readlines()
    with open(path_to_file, "w") as f:
        for idx, line in enumerate(lines):
            toWrite = str()
            for token in line.strip("\n").split():
                toWrite += f"[ {token}] "
            toWrite = toWrite.strip()  # for removing the trailing space off the end
            if idx != len(lines) - 1:
                toWrite += "\n"
            f.write(toWrite)


if os.path.isfile(data_source):
    add_brackets(data_source)
elif os.path.isdir(data_source):
    for file in os.listdir(data_source):
        if os.path.splitext(file)[1] != ".stree":
            continue
        add_brackets(os.path.join(data_source, file))
else:
    print("Please pass either a file or directory.")
    exit(1)
