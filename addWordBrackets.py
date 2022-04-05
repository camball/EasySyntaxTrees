"""A simple script that when given a directory containing only `.stree` files,
adds brackets around each word in each line in each file."""
import os
from sys import argv

if len(argv) != 2:
    print("Usage: python3 addWordBrackets.py <path_to_directory>")
    exit(1)

data_source_directory = argv[1]

for file in os.listdir(data_source_directory):
    # for each file in the directory, store it's contents in memory,
    # modify them, and write them back to the original file.
    with open(os.path.join(data_source_directory, file), "r") as f:
        lines = f.readlines()
    with open(os.path.join(data_source_directory, file), "w") as f:
        for line in lines:
            toWrite = str()
            for token in line.strip("\n").split():
                toWrite += f"[ {token}] "
            toWrite = toWrite.strip()  # for removing the trailing space off the end
            f.write(toWrite)
