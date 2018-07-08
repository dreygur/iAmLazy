#!/usr/bin/python3

"""
#   Solution Checker
#   Author: Totul
#   URI: https://www.facebook.com/rytotul
"""

import os
import subprocess
import shutil
from argparse import ArgumentParser

COMPILE = {
        '.c': 'gcc -Wall -Wextra -g -o bin/{0} src/{0}.c',
        '.cpp': 'g++ -std=c++11 -Wall -Wextra -g -o bin/{0} src/{0}.cpp'
        }

RUN = {
        '.py': 'python src/{0}.py',
        'other': 'bin/{0}'
        }

def run_solution(filename, expect):
    if not os.path.exists('bin/'):
        os.makedirs('bin/')

    try:
        if not os.path.exists('src/'+filename):
            print("Invalid file!")
            return

        prefix, ext = os.path.splitext(filename)
        prefix = prefix.split('/')[-1]

        if ext in ['.c', '.cpp']:
            compiler_commad = COMPILE[ext].format(prefix)
            try:
                subprocess.run(compiler_commad, shell=True, check=True)
                print('Compiled!')
            except subprocess.CalledProcessError as e:
                print(e)
                return

        outputfile = subprocess.PIPE
        inputfile = open('inputs/{0}.in'.format(prefix))

        if ext == '.py':
            program = RUN[ext].format(prefix)
        else:
            program = RUN['other'].format(prefix)

        process = subprocess.Popen(program.split(' '),\
                stdin=inputfile,\
                stdout=outputfile)

        while process.poll() is None:
            pass

        if process.returncode != 0:
            print("\nFAILURE")
            return

        content = process.stdout.read().decode()

        print('Output: ')
        print('+-+-+-+-+-+-+')
        print(content)

        if expect:
            print('Matching...')
            try:
                expected = open('expected/{0}.txt'.format(prefix)).read()
                if expected.strip() == str(content):
                    print('SUCCESS')
                else:
                    print('WRONG ANSWER')
                    print('\nExpected:')
                    print('+-+-+-+-+-+-+')
                    print(expected.strip())

            except Exception as e:
                print(e)

    except Exception as e:
        print(e)
        return

def clean():
    if os.path.exists('bin/'):
        for f in os.listdir('bin/'):
            os.remove('bin/' + f)
        shutil.rmtree('bin/')

def main():
    parser = ArgumentParser(description='Solution Manager\nAuthor: Totul (fb.com/rytotul).')

    parser.add_argument('solution', metavar='solution', type=str, nargs='?',
            help='The complete filename for the solution')

    parser.add_argument('-c', '--clean', action='store_true', default=False,
            help='Same as `rm -rf bin/`')

    parser.add_argument('-e', '--expect', action='store_true', default=False,
            help='Writes the program output to a file')

    args = parser.parse_args()
    if args.clean:
        clean()
        return

    solution_file = args.solution
    if solution_file == None:
        parser.print_help()
        return

    run_solution(solution_file, args.expect)

if __name__ == '__main__':
    main()
