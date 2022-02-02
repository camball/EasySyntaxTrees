import os

data_source_directory = 'replace_me'

for file in os.listdir(data_source_directory):
    with open(os.path.join(data_source_directory, file), 'r') as f:
        lines = f.readlines()
    with open(os.path.join(data_source_directory, file), 'w') as f:
        for line in lines:
            toWrite = str()
            for token in line.strip('\n').split():
                toWrite += f'[ {token}] '
            toWrite.strip() # take the trailing space off the end
            # TODO: for some reason, there is still a trailing space at the end. Don't have time to fix now lol.
            f.write(toWrite)
