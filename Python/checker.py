#!/usr/bin/env python3

"""
#   Solution Checker
#   Author: Totul
#   URI: https://www.facebook.com/dreygur
#   Free to use!
"""

#   Importing Modules
import os
import sys
import subprocess
import shutil
from argparse import ArgumentParser

#   A Dictionary for source file extensions and the compile command
COMPILE = {
		'.c': 'gcc -Wall -Wextra -g -o bin/{0} src/{0}.c',
		'.cpp': 'g++ -std=c++11 -Wall -Wextra -g -o bin/{0} src/{0}.cpp'
		}

#   Dictionary for running embeded scripts
RUN = {
		'.py': 'python src/{0}.py',
		'other': 'bin/{0}'
		}

#   Runs the solution
def run_solution(filename, expect):
	#   Run The Solution

	# Tests if dir bin exists if not then creates it
	if not os.path.exists('bin/'):
		os.makedirs('bin/')

	try:
		# Checks the src folder exists or not
		if not os.path.exists('src/'+filename):
			print("Invalid file!\nPut your sourcefile to 'src' directory.")
			os.mkdir('src/')
			return

		# Existance checking of inputs directory
		if not os.path.exists('inputs/'):
			os.mkdir('inputs/')
		
		# Checker for existance of expected directory
		if not os.path.exists('expected/'):
			os.mkdir('expected/')

		# Only GOD and I know what i have written here ;P
		prefix, ext = os.path.splitext(filename)
		prefix = prefix.split('/')[-1]

		# Checks file extension and runs command as it applies
		if ext in ['.c', '.cpp']:
			compiler_commad = COMPILE[ext].format(prefix)
			try:
				subprocess.run(compiler_commad, shell=True, check=True)
				print('Compiled!\n')
			except subprocess.CalledProcessError as e:
				print(e)
				return

		# Sets PIPE 
		outputfile = subprocess.PIPE
		# Takes inputs from the input file located at inputs directory
		inputfile = open('inputs/{0}.in'.format(prefix))

		# Checks extension and decides which command to run
		if ext == '.py':
			program = RUN[ext].format(prefix)
		else:
			program = RUN['other'].format(prefix)

		# Runs Commands in PIPE and process input oputputs
		process = subprocess.Popen(program, stdin=inputfile, stdout=outputfile)

		# Skip it
		while process.poll() is None:
			pass

		# Oh boy!
		if process.returncode != 0:
			print("\nFAILURE")
			return

		# Gets output from PIPE->stdout
		content = process.stdout.read().decode()

		# Anyone can get these!
		print('Output: ')
		print('+-+-+-+-+-+-+')
		print(content)

		# This also...
		if expect:
			print('Matching...')
			print('+-+-+-+-+-+-+')
			try:
				expected = open('expected/{0}.txt'.format(prefix)).read()
				if expected == str(content):
					print('SUCCESS\n')
				else:
					print('WRONG ANSWER')
					print('\nExpected:')
					print('+-+-+-+-+-+-+')
					print(expected.strip())
					print('\n')
			except Exception as e:
				print(e)

	except Exception as e:
		print(e)
		return

def clean():
	#   Function to clean junks from bin directory 
	if os.path.exists('bin/'):
		for f in os.listdir('bin/'):
			os.remove('bin/' + f)
		shutil.rmtree('bin/')

def banner():
	#   Yeah, Babe! It's the banner...
	lol = """        
			 dP""b8 88  88 888888  dP""b8 88  dP 888888 88""Yb 
			dP   `" 88  88 88__   dP   `" 88odP  88__   88__dP 
			Yb      888888 88""   Yb      88"Yb  88""   88"Yb  
			 YboodP 88  88 888888  YboodP 88  Yb 888888 88  Yb 

			 By: Rakibul Yeasin
			 Github: https://www.github.com/dreygur
			 Facebook: https://www.facebook.com/dreygur
		+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
		"""
	print(lol)

def main():
	#   The main function. Get it as you think
	parser = ArgumentParser(description='Solution Manager\nAuthorRakibul Yeasin (fb.com/dreygur).')

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
	sys.exit()

if __name__ == '__main__':
	try:
		banner()
		main()
	except KeyboardInterrupt:
		print('User Exited...')
		sys.exit()
#   My code ends. Time to sleep :D
