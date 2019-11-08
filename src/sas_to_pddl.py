#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys
try:
    # Python 3.x
    from builtins import open as file_open
except ImportError:
    # Python 2.x
    from codecs import open as file_open

def read_initial_state(file_name):
    new_sas = open(file_name, "r")
    
    variables = []
    state_str = ""
    
    line = new_sas.readline()
    while line:
        if "begin_variable" in line:
            variable = []
            new_sas.readline() # name
            new_sas.readline() # axiom layer
            domain_size = int(new_sas.readline())
            for i in range(domain_size):
                value = new_sas.readline()
                variable.append(value.replace('\n', '')) # value
            last_line = new_sas.readline()
            if not "end_variable" in last_line:
                sys.exit("Expected end_variable, got %s" % last_line)
            variables.append(variable)
        elif "begin_state" in line:
            line = new_sas.readline()
            while "end_state" not in line:
                state_str += " " + line
                line = new_sas.readline()
                if not line:
                    sys.exit("Reached end of file before end_state.")
        line = new_sas.readline()
    new_sas.close()
    
    state_values = [int(x) for x in state_str.strip().split()]
    for var in range(len(state_values)):
        val = state_values[var]
        state_values[var] = variables[var][val]
    return state_values


def find_pddl_init(pddl):
    if type(pddl[0]) is unicode:
        if ":init" in pddl[0].lower():
            return pddl
    for i in range(len(pddl)):
        if type(pddl[i]) is list:
            pddl_init = find_pddl_init(pddl[i])
            if pddl_init:
                return pddl_init
    return None

def pddl_var_to_string(pddl):
    if type(pddl) is str:
        return pddl
    if type(pddl) is unicode:
        return pddl
    if len(pddl) == 1:
        return pddl_var_to_string(pddl[0]) + "()"
    name = pddl_var_to_string(pddl[0]) + "(" + pddl_var_to_string(pddl[1])
    for i in range(2, len(pddl)):
        name += "," + pddl_var_to_string(pddl[i])
    return name + ")"


def lisp_to_string(node):
    if type(node) is str or type(node) is unicode:
        return node
    s = []
    for child in node:
        s.append(lisp_to_string(child))
    return "(" + ' '.join(s) + ")"


def replace_init_values(state_values, pddl):
    if not pddl:
        sys.exit(":init not found in PDDL.")

    del pddl[:]
    pddl.append(":init")

    for value in state_values:
        value = value.replace('()', '').replace('(', ',').replace(')', '')
        if "NegatedAtom" in value:
            value = value.replace("NegatedAtom ", '')
            pddl.append(['not', value.split(',')])
        else:
            value = value.replace("Atom ", '')
            pddl.append(value.split(','))


class ParseError(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return self.value

def tokenize(input):
    for line in input:
        line = line.split(";", 1)[0]  # Strip comments.
        try:
            line.encode("ascii")
        except UnicodeEncodeError:
            raise ParseError("Non-ASCII character outside comment: %s" %
                             line[0:-1])
        line = line.replace("(", " ( ").replace(")", " ) ").replace("?", " ?")
        for token in line.split():
            yield token.lower()

def parse_list_aux(tokenstream):
    # Leading "(" has already been swallowed.
    while True:
        try:
            token = next(tokenstream)
        except StopIteration:
            raise ParseError("Missing ')'")
        if token == ")":
            return
        elif token == "(":
            yield list(parse_list_aux(tokenstream))
        else:
            yield token

def parse_pddl_file(type, filename):
    try:
        tokens = tokenize(file_open(filename, encoding='ISO-8859-1'))
        next_token = next(tokens)
        if next_token != "(":
            raise ParseError("Expected '(', got %s." % next_token)
        result = list(parse_list_aux(tokens))
        for tok in tokens:  # Check that generator is exhausted.
            raise ParseError("Unexpected token: %s." % tok)
        return result

    except IOError as e:
        raise SystemExit("Error: Could not read file: %s\nReason: %s." %
                         (e.filename, e))
    except ParseError as e:
        raise SystemExit("Error: Could not parse %s file: %s\nReason: %s." %
                         (type, filename, e))


def write_pddl(file, pddl):
    file.write(lisp_to_string(pddl))

def convert(original_pddl_name, sas_name, new_pddl_name):
    state_values = read_initial_state(sas_name)
    pddl = parse_pddl_file("task", original_pddl_name)
    replace_init_values(state_values, find_pddl_init(pddl))
    with file_open(new_pddl_name, "w") as new_pddl_file:
        write_pddl(new_pddl_file, pddl)
    print("New PDDL file successfully written: %s" % new_pddl_name)

if __name__ == "__main__":
    original_pddl_name = sys.argv[1]
    sas_name = sys.argv[2]
    new_pddl_name = sys.argv[3]
    convert(original_pddl_name, sas_name, new_pddl_name)

