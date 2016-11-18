#! /usr/bin/python

from optparse import OptionParser
from __builtin__ import True

min_memory = None
max_memory = None
file_path = "/opt/atlassian/jira/bin/setenv.sh"

def options_valid():
    if min_memory and max_memory:
        if min_memory < max_memory:
            return True
        else:
            print "Can't run: min value is bigger than max value."
            return False
    else:
        print "Can't run: please specify both min and max value."
        return False

def main():
    if options_valid():
        new_content = ""
        infile = open(file_path, "r")
        for line in infile:
            if "JVM_MINIMUM_MEMORY=" in line and min_memory:
                line = 'JVM_MINIMUM_MEMORY="'+min_memory+'"\n'
            if "JVM_MAXIMUM_MEMORY=" in line and max_memory:
                line = 'JVM_MAXIMUM_MEMORY='+max_memory+'"\n'
            new_content += line
        infile.close()
        outfile = open(file_path, "w")
        outfile.write(new_content)
        outfile.close()
            

if __name__ == "__main__":
    parser = OptionParser()
    parser.add_option("--min-memory", dest="min_mem")
    parser.add_option("--max-memory", dest="max_mem")
    parser.add_option("--file-path", dest="fpath")
    opt, args = parser.parse_args()
    if opt.min_mem:
        min_memory = opt.min_mem
    if opt.max_mem:
        max_memory = opt.max_mem
    if opt.fpath:
        file_path = opt.fpath
    main()
    
    


